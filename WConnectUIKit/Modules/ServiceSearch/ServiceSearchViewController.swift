//
//  ServiceSearchViewController.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 23.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ServiceSearchViewControllerProtocol: AnyObject {
    func configure(_ entities: [ServiceSearchEntity.View.SearchItemEntity])
}

class ServiceSearchViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    static let builder = ServiceSearchBuilder()
    private var interactor: ServiceSearchInteractorProtocol!
    private var router: ServiceSearchRouterProtocol!
    private var services: [ServiceSearchEntity.View.SearchItemEntity] = []
    
    // MARK: - Setup
    
    func initialSetup(interactor: ServiceSearchInteractorProtocol, router: ServiceSearchRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        interactor.getData()
        setNavigationBar()
        tableView.separatorStyle = .none
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(STableViewCell.self)
    }
    
    private func setNavigationBar() {
        self.makeTransparentNavigationBar()
    }
}

extension ServiceSearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let service = services[indexPath.row]
        let cell = tableView.dequeue(STableViewCell.self, indexPath)
        
        cell.setService(service: service)
        cell.backgroundColor = UIColor(named: Color.backgroundGray)
        cell.favouriteButton = { [weak self] in
            guard let self else { return }
            cell.favouriteStateButton.setImage(UIImage(named: Image.fauvoriteFilled), for: .normal)
        }
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

extension ServiceSearchViewController: ServiceSearchViewControllerProtocol {
    func configure(_ entities: [ServiceSearchEntity.View.SearchItemEntity]) {
        self.services = entities
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
