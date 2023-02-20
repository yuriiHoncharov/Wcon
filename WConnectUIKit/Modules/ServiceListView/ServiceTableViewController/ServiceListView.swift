//
//  ServiceListView.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 16.02.2023.
//

import UIKit

class ServiceListView: UIViewController {
    
    var services: [SearchEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension ServiceListView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let service = services[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "serviceCell", for: indexPath) as! ServiceTableViewCell
        
        cell.setService(service: service)
        return cell
    }
}

