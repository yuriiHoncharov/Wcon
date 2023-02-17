//
//  APIService.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 16.02.2023.
//

import Foundation

class ApiService {
    let httpClient: HTTPClientProvider
//    let apiSettings: ApiSettings
    let jsonParser: JSONParserServiceProtocol
    
    init() {
        self.httpClient = HTTPClient.shared
//        self.apiSettings = ApiSettings()
        self.jsonParser = HTTPClient.shared.jsonParser
    }
    
    func handleResponseResult<T: Codable>(result: Result<Data, Error>, responseModel: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        switch result {
        
        case .success(let data):
            self.jsonParser.parseJSON(of: responseModel.self, from: data) { (result) in
                switch result {
                
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
