//
//  ServiceSearchV2ViewController.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 23.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ServiceSearchV2ViewControllerProtocol: AnyObject {
    func configure(_ entities: [ServiceSearchV2Entity.View.SearchItemEntity])
}

class ServiceSearchV2ViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    static let builder = ServiceSearchV2Builder()
    private var interactor: ServiceSearchV2InteractorProtocol!
    private var router: ServiceSearchV2RouterProtocol!
    private var services: [ServiceSearchV2Entity.View.SearchItemEntity] = []
    
    // MARK: - Setup
    
    func initialSetup(interactor: ServiceSearchV2InteractorProtocol, router: ServiceSearchV2RouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        interactor.getData()
        tableView.separatorStyle = .none
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "STableViewCell", bundle: nil), forCellReuseIdentifier: "STableViewCell")
    }
}

extension ServiceSearchV2ViewController: UITableViewDataSource, UITableViewDelegate {
    
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
}


extension ServiceSearchV2ViewController: ServiceSearchV2ViewControllerProtocol {
    func configure(_ entities: [ServiceSearchV2Entity.View.SearchItemEntity]) {
        self.services = entities
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
