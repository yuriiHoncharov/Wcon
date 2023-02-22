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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "STableViewCell", bundle: nil), forCellReuseIdentifier: "STableViewCell")
        
        tableView.backgroundColor =  UIColor(named: "BackgroundGray")
        services = createService()
        
//        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//        tableView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.beginUpdates()
        tableView.endUpdates()
        
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

extension ServiceSearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//           return self.services.count
//       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            headerView.backgroundColor = UIColor.clear
            return headerView
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let service = services[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "STableViewCell", for: indexPath) as? STableViewCell
        else { return UITableViewCell() }
        
        cell.setService(service: service)
                
        cell.backgroundColor = UIColor(named: "BaseWhite")
//        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.cornerRadius = 10
//        cell.clipsToBounds = true
        return cell
    }
}
