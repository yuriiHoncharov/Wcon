//
//  HTTPClient.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 16.02.2023.
//

import Foundation
import UIKit

struct ImageModel: Codable {
    var key: String = ""
    var image: UIImage?
    
    enum CodingKeys: String, CodingKey {
        case key
    }
}

protocol HTTPClientProvider {
    func request(method: HTTPClient.RequestType, url: String, withToken: Bool, images: [ImageModel]?, params: Any?, completion: @escaping (Result<Data, HTTPClientError>) -> Void)
}

final class HTTPClient: HTTPClientProvider {
    static let shared = HTTPClient()

//    @EventHandler private var eventHandler

    init() {
        self.delegateQueue = OperationQueue()
        self.delegateQueue.qualityOfService = .userInteractive
        self.delegateQueue.maxConcurrentOperationCount = 1
        
        self.urlSession = URLSession.init(configuration: .default, delegate: nil, delegateQueue: delegateQueue)
        
        self.requestDispatchQueue = DispatchQueue(label: "RequestDispatchQueue", attributes: .concurrent)
    }
    
    typealias DataTaskCompletion = ((Result<Data, HTTPClientError>) -> Void)
    
    struct RestRequest {
        var request: URLRequest
        var completion: HTTPClient.DataTaskCompletion
    }
    
    let jsonParser: JSONParserServiceProtocol = JSONParserService()
    
    private var requests: [RestRequest] = []
    private lazy var secureStorage = SecureStorage()
    private let networkMonitor = NetworkMonitor()

    private let tokenHeaderKey = "Authorization"
    private let deviceIdHeaderKey = "deviceId"
    private let platformHeaderKey = "platform"
    private let uuid: String? = UIDevice.current.identifierForVendor?.uuidString
    private var isRefreshTokenRequestInProgress = false
    
    private let delegateQueue: OperationQueue
    private let urlSession: URLSession
    private let requestDispatchQueue: DispatchQueue
    
    enum RequestType: String {
        case post = "POST"
        case put = "PUT"
        case get = "GET"
        case delete = "DELETE"
        case patch = "PATCH"
    }
    
    func request(method: HTTPClient.RequestType, url: String, withToken: Bool, images: [ImageModel]?, params: Any?, completion: @escaping DataTaskCompletion) {
        var parameters: [String: Any] = [:]
        var arrayParams: [[String: Any]] = []
        
        switch params {
        case let data as [String: Any]:
            parameters = data
        case let data as [Encodable]:
            arrayParams = data.map({ $0.convertToParameters })
        case let data as Encodable:
            parameters = data.convertToParameters
        case let data as [[String: Any]]:
            arrayParams = data
        default: break
        }
        
        var urlRequest: URLRequest?
        let token: String = withToken ? (getAccessData()?.token ?? "") : ""
        
        switch method {
        case .get:
            let urlWithQuery = url + parameters.queryItems()
            urlRequest = createRequest(url: urlWithQuery, type: method, token: token)
            
        default:
            if arrayParams.isEmpty == false {
                urlRequest = createRequestWith(url: url, type: method, token: token, images: images, params: arrayParams)
            } else {
                urlRequest = createRequest(url: url, type: method, token: token, images: images, params: parameters)
            }
        }
        
        performRequest(urlRequest, skipRefreshCheck: !withToken, completion: completion)
    }
    
    private func performRequest(_ urlRequest: URLRequest?, skipRefreshCheck: Bool = false, completion: @escaping DataTaskCompletion) {
        print("url: \(String(describing: urlRequest?.url?.absoluteString))")
        
        guard let request = urlRequest else {
            return completion(.failure(HTTPClientError.emptyURL(message: "Errors empty URL")))
        }
        
        guard networkMonitor.isConnected else {
            return completion(.failure(HTTPClientError.absentInternetConnection(message: "Errors absent Internet")))
        }
        
        let oAuthRequest = RestRequest(request: request, completion: completion)
        
        guard !shouldRefresh() || skipRefreshCheck else {
            safelyAddRequest(oAuthRequest: oAuthRequest)
            self.refreshToken(completion: completion)
            return
        }
        
        let dataTask = urlSession.dataTask(with: request) { (data, response, error) in
            if let error = error {
                let errorType = error as NSError
                
                switch errorType.code {
                case NSURLErrorCancelled:
                    break
                default:
                    completion(.failure(HTTPClientError.serverError(message: error.localizedDescription)))
                }
            } else if let data = data, let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200...299:
                    completion(.success(data))
                case 401:
                    if self.isUserBanned(data: data) {
                        completion(.failure(.userIsBanned))
                    } else {
                        if self.isRefreshTokenRequestInProgress {
                            completion(.failure(.requestAlreadyInQueue))
                        } else {
                            self.safelyAddRequest(oAuthRequest: oAuthRequest)
                            self.refreshToken(completion: completion)
                        }
                    }
                case 409:
                    if self.chatIsExist(data: data) {
                        completion(.failure(.chatIsExist(message: self.separatedChatId(data: data))))
                    } else {
                        completion(.success(data))
                    }
                case 410:
                    completion(.failure(.userIsDeleted))
                default:
                    completion(.success(data))
                }
            } else {
                completion(.failure(HTTPClientError.responseStatusError(message: "Server error")))
            }
        }
        
        dataTask.resume()
    }
    
    private func shouldRefresh() -> Bool {
        let accessData = getAccessData()
        let refreshToken = accessData?.refreshToken ?? ""
        
        if refreshToken.isEmpty || isRefreshTokenRequestInProgress {
            return false
        }
        
        let endDate: TimeInterval
        
        if let expirationDate = accessData?.expirationDate {
            endDate = expirationDate
        } else {
            endDate = Date().timeIntervalSince1970
        }
        
        let now = Date().timeIntervalSince1970
        let secondsBeforeEndTokenLive: Double = 10
        let shouldDoRefresh = (endDate - now) < secondsBeforeEndTokenLive
        
        return shouldDoRefresh
    }
    
    private func separatedChatId(data: Data) -> String {
        let message = String(data: data, encoding: .utf8)
        let separatedChatIdFromMessage = message?.components(separatedBy: ": ").last ?? ""
        let chatId = separatedChatIdFromMessage.components(separatedBy: "\"}").first ?? ""
        return chatId
    }
    
    private func isUserBanned(data: Data) -> Bool {
        let message = String(data: data, encoding: .utf8)?.lowercased() ?? ""
        return message.contains(Constants.ServerResponses.userIsBanned)
    }
    
    private func chatIsExist(data: Data) -> Bool {
        let message = String(data: data, encoding: .utf8)?.lowercased() ?? ""
        return message.contains(Constants.ServerResponses.chatIsExist)
    }
    
    private func refreshToken(completion: @escaping DataTaskCompletion) {
        guard let accessData = getAccessData(), accessData.refreshToken.isEmpty == false else {
            completion(.failure(HTTPClientError.authProblem(message: "Please re-login into app")))
            URLSession.shared.invalidateAndCancel()
            self.safelyRemoveAllRequests()
            return
        }
        
        let data = RefreshTokenApiEntity.Request(token: accessData.refreshToken)
        let parameters = data.convertToParameters
       
        guard let request = createRequest(url: APIEndpoints.Auth.refreshToken(),
                                          type: .post,
                                          token: accessData.token,
                                          images: nil,
                                          params: parameters) else {
            completion(.failure(HTTPClientError.authProblem(message: "Please re-login into app")))
            return
        }
        
        guard !self.requests.contains(where: {
            $0.request.url?.absoluteString == APIEndpoints.Auth.refreshToken()
        }) else { return }
        
        isRefreshTokenRequestInProgress = true
        
        self.performRequest(request, skipRefreshCheck: true, completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                
                self.jsonParser.parseJSON(of: RefreshTokenApiEntity.Response.self, from: data) { [weak self] result in
                    guard let self = self else { return }
                    
                    switch result {
                    case .success(let response):
                 
                        if let _ = response.error {
                            URLSession.shared.invalidateAndCancel()
                            self.safelyRemoveAllRequests()
                            self.clearAccessData()
                            
                            completion(.failure(HTTPClientError.authProblem(message: "Please re-login into the app"/*errorMessage*/)))
                        } else {
                            let accessData = AccessDataEntity(token: response.token ?? "",
                                                              refreshToken: response.refreshToken ?? "",
                                                              expirationDate: response.expirationDate ?? "")
                            self.secureStorage.save(with: SecureStorageKeys.kAccessData, value: accessData)
                            self.safelySendAllRequests()
//                            self.eventHandler.handle(.tokenUpdated)
                        }
                        
                    case .failure(let error):
                        completion(.failure(HTTPClientError.authProblem(message: error.localizedDescription)))
                    }
                }
                
            case .failure(let error):
                completion(.failure(HTTPClientError.authProblem(message: error.localizedDescription)))
            }
            
            self.isRefreshTokenRequestInProgress = false
        })
    }
    
    private func safelyAddRequest(oAuthRequest: RestRequest) {
        requestDispatchQueue.async(flags: .barrier) { [weak self] in
            self?.requests.append(oAuthRequest)
        }
    }
    
    private func safelySendAllRequests() {
        requestDispatchQueue.async(flags: .barrier) { [weak self] in
            guard let self = self else { return }
            
            let token = self.getAccessData()?.token ?? ""
            
            for restRequest in self.requests {
                var request = restRequest.request
                print(restRequest.request.url?.absoluteString as Any)
                if token.isEmpty == false, (request.allHTTPHeaderFields?.keys.contains(self.tokenHeaderKey) ?? false) {
                    request.setValue("Bearer \(token)", forHTTPHeaderField: self.tokenHeaderKey)
                }
                
                self.performRequest(request, completion: restRequest.completion)
            }
            
            self.requests.removeAll()
        }
    }
    
    private func safelyRemoveAllRequests() {
        requestDispatchQueue.async(flags: .barrier) { [weak self] in
            self?.requests.removeAll()
        }
    }
    
    private func createRequest(url: String, type: RequestType, token: String? = nil, images: [ImageModel]? = nil, params: [String: Any] = [:]) -> URLRequest? {
        var link: URL? = URL(string: url)
        
        if type == .get {
            link = URL(string: url.replacingOccurrences(of: " ", with: "%20"))
        }
        
        guard let url = link else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = type.rawValue
        
        let deviceId = uuid.setEmptyIfNil
        let platform = "IOS"
        
        request.setValue(deviceId, forHTTPHeaderField: self.deviceIdHeaderKey)
        request.setValue(platform, forHTTPHeaderField: self.platformHeaderKey)
        
        if let token = token, !token.isEmpty {
            request.setValue("Bearer \(token)", forHTTPHeaderField: self.tokenHeaderKey)
        }
        
        if let imagesArray = images {
            let boundary = "Boundary-\(UUID().uuidString)"
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            request.httpBody = createFormDataBody(parameters: params,
                                                  boundary: boundary,
                                                  images: imagesArray,
                                                  mimeType: "image/jpeg")
        } else if !params.isEmpty {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let jsonData = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            request.httpBody = jsonData
        }
        
        return request
    }
    
    private func createRequestWith(url: String, type: RequestType, token: String? = nil, images: [ImageModel]? = nil, params: [[String: Any]] = [[:]]) -> URLRequest? {
        var link: URL? = URL(string: url)
        
        if type == .get {
            link = URL(string: url.replacingOccurrences(of: " ", with: "%20"))
        }
        
        guard let url = link else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = type.rawValue
        
        let deviceId = uuid.setEmptyIfNil
        let platform = "IOS"
        
        request.setValue(deviceId, forHTTPHeaderField: self.deviceIdHeaderKey)
        request.setValue(platform, forHTTPHeaderField: self.platformHeaderKey)
        
        if let token = token, !token.isEmpty {
            request.setValue("Bearer \(token)", forHTTPHeaderField: self.tokenHeaderKey)
        }
        
        if !params.isEmpty {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let jsonData = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            request.httpBody = jsonData
        }
        
        return request
    }
    
    private func createFormDataBody(parameters: [String: Any],
                                    boundary: String,
                                    images: [ImageModel],
                                    mimeType: String) -> Data {
        var body = Data()
        
        for (key, value) in parameters {
            body.append(convertFormField(named: key, value: value, using: boundary))
        }
        
        for item in images {
            if let imageData = item.image?.jpegData(compressionQuality: 0.25) {
                let fileName: String = UUID().uuidString + ".jpg"
                body.append(self.convertFileData(fieldName: item.key, fileName: fileName, mimeType: mimeType, fileData: imageData, using: boundary))
            }
        }
        
        body.append("--\(boundary)--")
        
        return body
    }
    
    private func convertFormField(named name: String, value: Any, using boundary: String) -> String {
        let value = "\(value)"
        
        var fieldString = "--\(boundary)\r\n"
        fieldString += "Content-Disposition: form-data; name=\"\(name)\"\r\n"
        fieldString += "\r\n"
        fieldString += value.appending("\r\n")
        
        return fieldString
    }
    
    private func convertFileData(fieldName: String, fileName: String, mimeType: String, fileData: Data, using boundary: String) -> Data {
        var data = Data()
        
        data.append("--\(boundary)\r\n")
        data.append("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\r\n")
        data.append("Content-Type: \(mimeType)\r\n\r\n")
        data.append(fileData)
        data.append("\r\n")
        
        return data
    }
    
    private func getAccessData() -> AccessDataEntity? {
        return secureStorage.load(with: SecureStorageKeys.kAccessData, type: AccessDataEntity.self)
    }
    
    private func clearAccessData() {
        secureStorage.remove(with: SecureStorageKeys.kAccessData)
    }
}

extension Encodable {
    var convertToParameters: [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else { return [:] }
        
        let jsonObject = (try? (JSONSerialization.jsonObject(with: data, options: []))).flatMap { $0 as? [String: Any] } ?? [:]
        var jsonObjectString: [String: Any] = [:]
        
        for item in jsonObject {
            switch item.value {
            case let array as NSArray: jsonObjectString[item.key] = array.objectEnumerator().allObjects.isEmpty == false ? array : ""
            case let dict as NSDictionary: jsonObjectString[item.key] = dict.allValues.isEmpty == false ? dict : ""
            default: jsonObjectString[item.key] = String(describing: item.value)
            }
        }
        
        return jsonObjectString
    }
}

extension Encodable {
    private var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: [])).flatMap { $0 as? [String: Any] }
    }
    
    func queryItems() -> String {
        guard let dic = dictionary else { return "" }
        return dic.queryItems()
    }
}

extension Dictionary {
    fileprivate func queryItems() -> String {
        guard let dict = self as? [String: Any] else { return "" }
        
        var queryItems: [URLQueryItem] = []
        
        dict.forEach { key, value in
            if let array = value as? [Any] {
                array.forEach { item in
                    queryItems.append(URLQueryItem(name: key, value: String(describing: item)))
                }
            } else {
                if let value = value as? String, value.isEmpty {
                    print()
                } else {
                    queryItems.append(URLQueryItem(name: key, value: String(describing: value)))
                }
            }
        }
        
        var components = URLComponents()
        components.queryItems = queryItems
        
        let customAllowedSet = CharacterSet.init(charactersIn: "_+-").inverted
        return components.url?.absoluteString.addingPercentEncoding(withAllowedCharacters: customAllowedSet) ?? ""
    }
}

extension Data {
    mutating func append(_ string: String, using encoding: String.Encoding = .utf8) {
        if let data = string.data(using: encoding) {
            append(data)
        }
    }
}

//protocol ErrorManagerProcessor {
//    var httpErrorManager: HTTPErrorManager { get }
//    var coordinator: NavigationCoordinator { get }
//}
//extension ErrorManagerProcessor {
//    func processError(_ httpError: HTTPClientError) {
//        var error: String = ""
//        var shouldShowAlert = false
//
//        httpErrorManager.processError(httpError, text: &error, shouldShowAlert: &shouldShowAlert)
//        guard shouldShowAlert else { return }
//        coordinator.showAlert(.base(title: "Error",
//                                    message: error,
//                                    navigation: .none))
//    }
//}
