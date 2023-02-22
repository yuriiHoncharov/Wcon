//
//  ServiceTableView.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 16.02.2023.
//

import UIKit

class ServiceSearchViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var services: [SearchEntity] = []
    let apiRequest = ServiceRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "STableViewCell", bundle: nil), forCellReuseIdentifier: "STableViewCell")
        
        tableView.backgroundColor =  UIColor(named: "BackgroundGray")
        services = getService() // createService()
        tableView.separatorStyle = .none
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.beginUpdates()
        tableView.endUpdates()
        
    }
    
//    func createService() -> [SearchEntity] {
//        var services: [SearchEntity] = []
//        let service1 = SearchEntity.mock
//        let service2 = SearchEntity.mock
//        let service3 = SearchEntity.mock
//
//        services.append(service1)
//        services.append(service2)
//        services.append(service3)
//
//        return services
//    }
}

extension ServiceSearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let service = services[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "STableViewCell", for: indexPath) as? STableViewCell
        else { return UITableViewCell() }
        
        cell.setService(service: service)
        cell.backgroundColor = UIColor(named: "BackgroundGray")
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            headerView.backgroundColor = UIColor.clear
            return headerView
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    private func getService() -> [SearchEntity] {
        var services: [SearchEntity] = []
        let params = ServiceSearchApiEntity.Request(categories: [],
                                                    subcategories: [],
                                                    clarifications: [],
                                                    city: "",
                                                    district: "",
                                                    text: "",
                                                    page: 20)
        
        apiRequest.search(params: params) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    var specialists: [SearchEntity] = []
                    
                    let items = model.items ?? []
                    items.forEach { item in
                        let specialist = SearchEntityMapper.map(item, dateUtility: DateFormatterUtility())
                        specialists.append(specialist)
                    }
                    services.append(contentsOf: specialists)
                    print("model.items?.first?.id ??")

                    case .failure(let error):
                        print(error.localizedDescription)
                }
            }
        }
        return services
    }
}
