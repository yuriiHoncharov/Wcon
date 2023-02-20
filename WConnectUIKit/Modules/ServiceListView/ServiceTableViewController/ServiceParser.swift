//
//  ServiceParser.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 20.02.2023.
//

import Foundation

class ServiceParser {
    private let serviceApi = ServiceRequest()
    
    func search(selectedOrderFilters: OrderFilters?,
                searchText: String?,
                page: Int?,
                completion: @escaping (_ items: [SearchEntity], _ error: HTTPClientError?, _ totalCount: Int?) -> Void) {
        let params = ServiceSearchApiEntity.Request(categories: selectedOrderFilters?.categoryIds,
                                                    subcategories: selectedOrderFilters?.subcategoryIds,
                                                    clarifications: selectedOrderFilters?.clarificationIds,
                                                    city: selectedOrderFilters?.city.first?.title,
                                                    district: selectedOrderFilters?.district.first?.title,
                                                    text: searchText,
                                                    page: page)
        
        serviceApi.search(params: params) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let model):
                    if let error = model.error {
                        completion([], .serverError(message: error), nil)
                    } else {
                        var specialists: [SearchEntity] = []
                        
                        let items = model.items ?? []
                        items.forEach { item in
                            let specialist = SearchEntityMapper.map(item, dateUtility: DateFormatterUtility())
                            specialists.append(specialist)
                        }
                        
                        completion(specialists, nil, model.totalCount)
                    }
                case .failure(let error):
                    completion([], error as? HTTPClientError, nil)
                }
            }
        }
    }
}

class OrderFilters {
    var categories: [OrdersFilterEntity] = []
    var subcategories: [OrdersFilterEntity] = []
    var clarifications: [OrdersFilterEntity] = []
    var city: [OrdersFilterEntity] = []
    var district: [OrdersFilterEntity] = []
    
    var categoryIds: [String] { categories.map { $0.id } }
    var subcategoryIds: [String] { subcategories.map { $0.id } }
    var clarificationIds: [String] { clarifications.map { $0.id } }
    var cityIds: [String] { city.map { $0.id } }
    var districtsIds: [String] { district.map { $0.id } }
    
    var categorySubtitles: [String] { categories.map { $0.title } }
    var subcategorySubtitles: [String] { subcategories.map { $0.title } }
    var clarificationSubtitles: [String] { clarifications.map { $0.title } }
    var citySubtitles: [String] { city.map { $0.title } }
    var districtSubtitles: [String] { district.map { $0.title } }
    
    var allFilters: [OrdersFilterEntity] {
        categories + subcategories + clarifications + city + district
    }
    
    func remove(_ filter: OrdersFilterEntity) {
        categories = categories.filter { $0 != filter }
        subcategories = subcategories.filter { $0 != filter }
        clarifications = clarifications.filter { $0 != filter }
        city = city.filter { $0 != filter }
        district = district.filter { $0 != filter }
    }
    
    func clear() {
        categories.removeAll()
        subcategories.removeAll()
        clarifications.removeAll()
        city.removeAll()
        district.removeAll()
    }
}

struct OrdersFilterEntity: Identifiable, Hashable, Equatable {
    let id: String
    let title: String
    let parentTitle: String?
    let isShowParentTitle: Bool
}
