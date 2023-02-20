//
//  ServiceTableView.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 16.02.2023.
//

import UIKit

class ServiceTableView: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var services: [SearchEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ServiceTableViewCell", bundle: nil), forCellReuseIdentifier: "ServiceTableViewCell")
        
        services = createService()
        
    }
    
    func createService() -> [SearchEntity] {
        var services: [SearchEntity] = []
        let service1 = SearchEntity.mock
        let service2 = SearchEntity.mock
        let service3 = SearchEntity.mock
        
        services.append(service1)
        services.append(service2)
        services.append(service3)
        
        return services
    }
}

extension ServiceTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let service = services[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceTableViewCell", for: indexPath) as! ServiceTableViewCell
        
        cell.setService(service: service)
        return cell
    }
}
