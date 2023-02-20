//
//  ServiceRequest.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 20.02.2023.
//

import Foundation
class ServiceRequest: ApiService {
    func search(params: ServiceSearchApiEntity.Request, completion: @escaping (Result<ServiceSearchApiEntity.Response, Error>) -> Void) {
        let params: [String: Any] = params.convertToParameters
        let url =  APIEndpoints.Service.search()
        
        httpClient.get(url: url, token: nil, params: params) { [weak self] result in
            
            guard let self = self else { return }
            self.handleResponseResult(result: result,
                                      responseModel: ServiceSearchApiEntity.Response.self,
                                      completion: completion)
        }
    }
    
//    func search(params: ServiceSearchApiEntity.Request, completion: @escaping Result<ServiceSearchApiEntity.Response, Error>) -> Void {
//        let params: [String: Any] = params.convertToParameters
//        let url = APIEndpoints.Service.search()
//        httpClient.get(url: url, token: nil, params: params) { [weak self] result in
//            guard let self = self else { return }
//
//            self.handleResponseResult(result: result,
//                                      responseModel: ServiceSearchApiEntity.Response.self,
//                                      completion: completion)
        
//        httpClient.request(method: .get, url: url, withToken: true, images: nil, params: params) { [weak self] response in
//            guard let self = self else { return }
//            self.handleResponseResult(result: response, responseModel: ServiceSearchApiEntity.Response.self, completion: completion)
//        }
//    }
    
}
