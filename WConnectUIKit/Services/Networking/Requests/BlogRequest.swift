//
//  BlogRequest.swift
//  WConnect
//
//  Created by Yurii Honcharov on 19.09.2022.
//  Copyright © 2022 Lampa. All rights reserved.
//

import Foundation

class BlogRequest: ApiService {
    func getBlogs(params: BlogsApiEntity.Request, completion: @escaping (Result<BlogsApiEntity.Response, Error>) -> Void) {
        let params: [String: Any] = params.convertToParameters
        let url =  APIEndpoints.Blog.search()
        
        httpClient.get(url: url, token: nil, params: params) { [weak self] result in
            
            guard let self = self else { return }
            self.handleResponseResult(result: result,
                                      responseModel: BlogsApiEntity.Response.self,
                                      completion: completion)
        }
    }
}
