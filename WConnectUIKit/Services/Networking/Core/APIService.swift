//
//  APIService.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 16.02.2023.
//

import Foundation

class APIService {
    let httpClient: HTTPClientProvider
    let jsonParser: JSONParserServiceProtocol
    
    private lazy var secureStorage = SecureStorage()
    
    init() {
        self.httpClient = HTTPClient.shared
        self.jsonParser = HTTPClient.shared.jsonParser
    }
    
    func handleResponseResult<T: BaseResponseProtocol>(result: Result<Data, HTTPClientError>, responseModel: T.Type, completion: @escaping (Result<T, HTTPClientError>) -> Void) {
        switch result {
        case .success(let data):
            print(String(decoding: data, as: UTF8.self))
            
            self.jsonParser.parseJSON(of: responseModel.self, from: data) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let response):
                    if let errorMessage = response.error {
                        completion(.failure(HTTPClientError.serverError(message: errorMessage)))
                        break
                    }
                    
                    if let response = response as? TokenResponseProtocol {
                        let accessData = AccessDataEntity(token: response.token ?? "",
                                                          refreshToken: response.refreshToken ?? "",
                                                          expirationDate: response.expirationDate ?? "")
                        self.secureStorage.save(with: SecureStorageKeys.kAccessData, value: accessData)
                    }

                    completion(.success(response))
                    
                case .failure(let error):
                    print(error)
                    let errorMessage = error.localizedDescription
                    completion(.failure(HTTPClientError.parseDataProblem(message: errorMessage)))
                }
            }
            
        case .failure(let error):
            print(error)
            completion(.failure(error))
        }
    }
    
    func handleResponseResult(result: Result<Data, HTTPClientError>, completion: @escaping (Result<Bool, HTTPClientError>) -> Void) {
        DispatchQueue.main.async {
            switch result {
            case .success(let data):
                print(String(decoding: data, as: UTF8.self))
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func handleResponseResult<T: BaseResponseProtocol>(result: Result<Data, HTTPClientError>, responseModels: [T].Type, completion: @escaping (Result<[T], HTTPClientError>) -> Void) {
        DispatchQueue.main.async {
            switch result {
            case .success(let data):
                print(String(decoding: data, as: UTF8.self))
                
                self.jsonParser.parseJSON(of: responseModels.self, from: data) { result in
                    switch result {
                    case .success(let response):
                        completion(.success(response))
                        
                    case .failure(let error):
                        print(error)
                        let errorMessage = error.localizedDescription
                        completion(.failure(HTTPClientError.parseDataProblem(message: errorMessage)))
                    }
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

