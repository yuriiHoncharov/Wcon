//
//  BlogRequest.swift
//  WConnect
//
//  Created by Yurii Honcharov on 19.09.2022.
//  Copyright © 2022 Lampa. All rights reserved.
//

import Foundation

class BlogRequest: APIService {
    func getBlogs(params: BlogsApiEntity.Request, completion: @escaping RequestHandler<BlogsApiEntity.Response>) {
        let url = APIEndpoints.Blog.search()
        
        httpClient.request(method: .get, url: url, withToken: false, images: nil, params: params) { [weak self] response in
            guard let self = self else { return }
            self.handleResponseResult(result: response, responseModel: BlogsApiEntity.Response.self, completion: completion)
        }
    }
}
