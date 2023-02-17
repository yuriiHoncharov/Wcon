//
//  HTTPClient.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 16.02.2023.
//

import Foundation
import UIKit

struct Image {
    var key: String
    var image: UIImage
}


protocol HTTPClientProvider {
    
    func get(url: String, token: String?, params: [String: Any], completion: @escaping (Result<Data, Error>) -> Void)
    func post(url: String, token: String?, images: [Image]?, params: [String: Any], completion: @escaping (Result<Data, Error>) -> Void)
    func put(url: String, token: String?, images: [Image]?, params: [String: Any], completion: @escaping (Result<Data, Error>) -> Void)
    func delete(url: String, token: String?, images: [Image]?, params: [String: Any], completion: @escaping (Result<Data, Error>) -> Void)
}

final class HTTPClient: HTTPClientProvider {
    
    static let shared = HTTPClient()
    
    init() {
        self.delegateQueue = OperationQueue()
        self.delegateQueue.qualityOfService = .userInteractive
        self.delegateQueue.maxConcurrentOperationCount = 1
        
        self.urlSession = URLSession.init(configuration: .default, delegate: nil, delegateQueue: delegateQueue)
        
        self.requestDispatchQueue = DispatchQueue( label: "RequestDispatchQueue", attributes: .concurrent)
    }
    
    typealias DataTaskCompletion = ((Result<Data, Error>) -> Void)
    
    struct RestRequest {
        var request: URLRequest
        var completion: HTTPClient.DataTaskCompletion
    }
    
//    let apiSettings: ApiSettings = ApiSettings()
    let jsonParser: JSONParserServiceProtocol = JSONParserService()

    private var requests: [RestRequest] = []
    
    private let delegateQueue: OperationQueue
    private let urlSession: URLSession
    private let requestDispatchQueue: DispatchQueue
    
    enum RequestType: String {
        case post = "POST"
        case put = "PUT"
        case get = "GET"
        case delete = "DELETE"
    }
    
    func get(url: String, token: String? = nil, params: [String: Any], completion: @escaping (Result<Data, Error>) -> Void) {
        let request = createRequest(url: url, type: .get, token: token, params: params)
        performRequest(request, completion: completion)
    }
    
    func post(url: String, token: String? = nil, images: [Image]? = nil, params: [String: Any], completion: @escaping (Result<Data, Error>) -> Void) {
        let request = createRequest(url: url, type: .post, token: token, images: images, params: params)
        performRequest(request, completion: completion)
    }
    
    func delete(url: String, token: String? = nil, images: [Image]? = nil, params: [String: Any], completion: @escaping (Result<Data, Error>) -> Void) {
        let request = createRequest(url: url, type: .delete, token: token, images: images, params: params)
        performRequest(request, completion: completion)
    }
    
    func put(url: String, token: String? = nil, images: [Image]? = nil, params: [String: Any], completion: @escaping (Result<Data, Error>) -> Void) {
        let request = createRequest(url: url, type: .put, token: token, images: images, params: params)
        performRequest(request, completion: completion)
    }
    
    private func performRequest(_ urlRequest: URLRequest?, skipRefreshCheck: Bool = false, completion: @escaping (Result<Data, Error>) -> Void) {
        print("url : \(String(describing: urlRequest?.url?.absoluteString))")
//        print("token: \(String(describing: apiSettings.token))")
        
        guard let request = urlRequest else {
            return completion(.failure(HTTPClientError.emptyURL(message: "Empty URL")))
        }
        
        let dataTask = urlSession.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                let errorType = error as NSError
                
                switch errorType.code {
                case NSURLErrorCancelled:
                    break
                default:
                    completion(.failure(error))
                }
            } else if let data = data, let response = response as? HTTPURLResponse {
                
                switch response.statusCode {
                case 200...299:
                    completion(.success(data))
//                case 401:
//                    self.safelyAddRequest(oAuthRequest: oAuthRequest)
//                    self.refreshToken(completion: completion)
                default:
                    completion(.success(data))
                }
                
            } else {
                completion(.failure(HTTPClientError.responseStatusError(message: "Server error")))
            }
        }
        
        dataTask.resume()
    }
    
    
    private func removeSavedTask(_ url: String?) {
        requestDispatchQueue.async(flags: .barrier) { [weak self] in
            let requestUrl = url ?? ""
            self?.requests.removeAll(where: { $0.request.url?.absoluteString == requestUrl})
        }
    }
    
    private func createRequest(url: String, type: RequestType, token: String? = nil, images: [Image]? = nil, params: [String: Any] = [:]) -> URLRequest? {
        
        var link: URL? = URL(string: url)
        
        if type == .get {
            link = URL(string: url.replacingOccurrences(of: " ", with: "%20"))
        }
        
        guard let url = link else {  return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = type.rawValue
        
        if let token = token, !token.isEmpty {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
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
    
    private func createFormDataBody(parameters: [String: Any],
                                    boundary: String,
                                    images: [Image],
                                    mimeType: String) -> Data {
        var body = Data()
        
        for (key, value) in parameters {
            body.append(convertFormField(named: key, value: value, using: boundary))
        }
        
        for item in images {
            if let imageData = item.image.jpegData(compressionQuality: 0.7) {
                body.append(self.convertFileData(fieldName: item.key, fileName: Date().description, mimeType: mimeType, fileData: imageData, using: boundary))
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
}

extension Encodable {
    var convertToParameters: [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else { return [:] }
        let jsonObject = (try? (JSONSerialization.jsonObject(with: data, options: []))).flatMap { $0 as? [String: Any] } ?? [:]
        var jsonObjectString: [String: Any] = [:]

        for item in jsonObject {
            
            switch item.value {
            case let array as NSArray:
                jsonObjectString[item.key] = array.count > 0 ? "\(array)" : ""
                
            case let dict as NSDictionary:
                jsonObjectString[item.key] = dict.count > 0 ? dict : ""
                
            default:
                jsonObjectString[item.key] = String(describing: item.value)
            }
        }
        
        return jsonObjectString
    }
    
    fileprivate func convertValueToString(array: Any) -> String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: array)
            if let json = String(data: jsonData, encoding: .utf8) {
                return json
            }
        } catch {
            print("something went wrong with parsing json")
            return nil
        }
        
        return nil
    }
}

extension Data {
    mutating func append(_ string: String, using encoding: String.Encoding = .utf8) {
        if let data = string.data(using: encoding) {
            append(data)
        }
    }
}
