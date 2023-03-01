//
//  CategoryRequest.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 28.02.2023.
//

import Foundation

class CategoryRequest: APIService {
    
    func getAllCategories(params: HomeEntity.Request, completion: @escaping RequestHandler<HomeEntity.Response>) {
        let url = APIEndpoints.Category.category()
        
        httpClient.request(method: .get, url: url, withToken: true, images: nil, params: params) { [weak self] response in
            guard let self = self else { return }
            self.handleResponseResult(result: response, responseModel: HomeEntity.Response.self, completion: completion)
        }
    }
    
//    func getAllSubcategories(params: SubcategoriesApiEntity.Request? = nil, completion: @escaping RequestHandler<SubcategoriesApiEntity.Response>) {
//        let url = APIEndpoints.Category.subcategory()
//
//        httpClient.request(method: .get, url: url, withToken: true, images: nil, params: params) { [weak self] response in
//            guard let self = self else { return }
//            self.handleResponseResult(result: response, responseModel: SubcategoriesApiEntity.Response.self, completion: completion)
//        }
//    }
    
//    func getAllClarifications(params: ClarificationsApiEntity.Request? = nil, completion: @escaping RequestHandler<ClarificationsApiEntity.Response>) {
//        let url = APIEndpoints.Category.clarification()
//        
//        httpClient.request(method: .get, url: url, withToken: true, images: nil, params: params) { [weak self] response in
//            guard let self = self else { return }
//            self.handleResponseResult(result: response, responseModel: ClarificationsApiEntity.Response.self, completion: completion)
//        }
//    }
}
