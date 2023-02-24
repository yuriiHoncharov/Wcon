//
//  HomeViewController.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 23.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomeViewControllerProtocol: AnyObject {
    
}

class HomeViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    static let builder = HomeBuilder()
    private var interactor: HomeInteractorProtocol!
    private var router: HomeRouterProtocol!
    
    // MARK: - Setup
    
    func initialSetup(interactor: HomeInteractorProtocol, router: HomeRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(HomeTableViewCell.self)
        tableView.register(HorizontalTableViewCell.self)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeue(HomeTableViewCell.self, indexPath)
//        cell.display()
//        cell.buttonAction = { [weak self] in
//            guard let self = self else { return }
//            let vc = ServiceSearchViewController.builder.default()
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
//        cell.backgroundColor =  UIColor(named: "BackgroundGray")
//        return cell
        
        let cell = tableView.dequeue(HorizontalTableViewCell.self, indexPath)
        return cell
    }
}

extension HomeViewController: HomeViewControllerProtocol {
    
    //    DispatchQueue.main.async {
    //        tableView.reloadData()
    //    }
}
