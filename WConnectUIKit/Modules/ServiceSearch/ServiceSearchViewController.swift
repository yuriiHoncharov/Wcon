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
    @IBOutlet weak var serviceCountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    // MARK: - Properties
    static let builder = ServiceSearchBuilder()
    private var interactor: ServiceSearchInteractorProtocol!
    private var router: ServiceSearchRouterProtocol!
    private var services: [ServiceSearchEntity.View.SearchItemEntity] = []
    private var isFilterService = false
    private var filterService: [ServiceSearchEntity.View.SearchItemEntity] = []
    private var totalCount: Int = 0
    
    // MARK: - Setup
    
    func initialSetup(interactor: ServiceSearchInteractorProtocol, router: ServiceSearchRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.getData()
        setupTableView()
        setNavigationBar()
        setTopView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(STableViewCell.self)
        tableView.separatorStyle = .none
    }
    
    private func setNavigationBar() {
        title = Constants.Search.listOfService
        self.makeTransparentNavigationBar()
        
    }
    
    private func setTopView() {
        searchTextField.delegate = self
        searchTextFieldPlaceholder()
        serviceCountLabel.text = "\(Constants.Search.specialists) \(filterService.count)"
        serviceCountLabel.font = .systemFont(ofSize: 10, weight: .medium)
        view.backgroundColor = UIColor(named: Color.lightGray)
    }
    
    private func searchTextFieldPlaceholder() {
        searchTextField.textAlignment = .center
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: Image.search)
        attachment.bounds = CGRect(x: 0, y: -3, width: 16, height: 16)
        let attachmentStr = NSAttributedString(attachment: attachment)
        let myString = NSMutableAttributedString(string: "")
        myString.append(attachmentStr)
        let myString1 = NSMutableAttributedString(string: " \(Constants.Search.search)")
        myString.append(myString1)
        searchTextField.attributedPlaceholder = myString
    }
}

extension ServiceSearchViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text {
            filterText(text + string)
        }
        return true
    }
    
    func filterText(_ query: String) {
        filterService.removeAll()
        for service in services {
            if service.category.lowercased().starts(with: query.lowercased()) {
                filterService.append(service)
            }
        }
        tableView.reloadData()
        isFilterService = true
    }
}

extension ServiceSearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !filterService.isEmpty {
            return filterService.count
        }
        return  isFilterService ? 0 : services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(STableViewCell.self, indexPath)
        if filterService.isEmpty == true {
            let service = services[indexPath.row]
            cell.setService(service: service)
        } else {
            let service = filterService[indexPath.row]
            cell.setService(service: service)
        }
        cell.backgroundColor = UIColor(named: Color.backgroundGray)
        cell.favouriteButton = { [weak self] in
            guard let self else { return }
            cell.favouriteStateButton.setImage(UIImage(named: Image.fauvoriteFilled), for: .normal)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
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
