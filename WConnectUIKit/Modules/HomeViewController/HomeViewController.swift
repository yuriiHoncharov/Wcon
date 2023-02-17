//
//  HomeViewController.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 16.02.2023.
//

import UIKit


class HomeViewController: UIViewController {
    
    @IBOutlet weak var orderButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        searchButtonView()
        
    }
//    private func searchButtonView() {
//        orderButton.setTitle("Смотреть все", for: .normal)
//        view.addSubview(orderButton)
//        orderButton.backgroundColor = .green
//        orderButton.setTitleColor(.white, for: .normal)
//        
//    }

    @IBAction func navigationButton(_ sender: UIButton) {
        let rootVC = OrderListView()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .formSheet
        present(navVC, animated: true)
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        self.navigationController?.isNavigationBarHidden = true
//    }
    
}
