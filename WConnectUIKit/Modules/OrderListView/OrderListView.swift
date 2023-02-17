//
//  OrderListView.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 16.02.2023.
//

import UIKit

class OrderListView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "DISMIS",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(removeSelectVC))
        
    }
    
    
   @objc private func removeSelectVC() {
        dismiss(animated: true)
//        navigationController?.removeViewController(HomeViewController.self)
    }
}
