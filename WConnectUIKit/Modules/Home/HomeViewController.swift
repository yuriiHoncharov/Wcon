//
//  HomeViewController.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 23.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomeViewControllerProtocol: AnyObject {
    func navigateTo()
}

private enum HomeCells: Int, CaseIterable {
//    case search
    case title
    case horizontalScrollWithImage
    case subtitle
//    case horizontalScrollWithCategory
//    case blogs
    
    static func defaultSectionCount() -> Int {
        return 3
    }
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
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(named: Color.backgroundGray)
        tableView.register(HomeTableViewCell.self)
        tableView.register(HorizontalTableViewCell.self)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeue(HomeTableViewCell.self, indexPath)
            cell.display(title: Constants.Home.popularService, subtitle: Constants.Home.homeTitle, buttonTitle: Constants.Home.watchAll)
            cell.buttonAction = { [weak self] in
                guard let self = self else { return }
               // self.router.navigationToServiceSearch()
                let vc = ServiceSearchViewController.builder.default()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeue(HorizontalTableViewCell.self, indexPath)
            return cell
        } else {
            let cell = tableView.dequeue(HomeTableViewCell.self, indexPath)
            cell.display(title: Constants.Home.category, subtitle: "", buttonTitle: Constants.Home.allOrders)
            cell.buttonAction = { [weak self] in
                guard let self = self else { return }
                //TODO: update
               // self.router.navigationToServiceSearch()
                let vc = ServiceSearchViewController.builder.default()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        }
    }
}

extension HomeViewController: HomeViewControllerProtocol {
    func navigateTo() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.router.navigateTo()
        }
    }
}
