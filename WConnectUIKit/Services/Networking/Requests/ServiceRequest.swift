//
//  ServiceRequest.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 20.02.2023.
//

import Foundation
class ServiceRequest: APIService {
    
    func search(params: ServiceSearchApiEntity.Request, completion: @escaping RequestHandler<ServiceSearchApiEntity.Response>) {
        let url = APIEndpoints.Service.search()

        httpClient.request(method: .get, url: url, withToken: true, images: nil, params: params) { [weak self] response in
            guard let self = self else { return }
            self.handleResponseResult(result: response, responseModel: ServiceSearchApiEntity.Response.self, completion: completion)
        }
    }
    
    func guestSearch(params: ServiceSearchApiEntity.Request, completion: @escaping RequestHandler<ServiceSearchApiEntity.Response>) {
        let url = APIEndpoints.Service.anonSearch()
        
        httpClient.request(method: .get, url: url, withToken: false, images: nil, params: params) { [weak self] response in
            guard let self = self else { return }
            self.handleResponseResult(result: response, responseModel: ServiceSearchApiEntity.Response.self, completion: completion)
        }
    }
}
