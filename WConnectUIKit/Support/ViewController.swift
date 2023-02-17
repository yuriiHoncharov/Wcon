//
//  ViewController.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 16.02.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchButtonView()
    }

    private func searchButtonView() {
        searchButton.setTitle("", for: .normal)
        view.addSubview(searchButton)
        searchButton.backgroundColor = .clear
        searchButton.setTitleColor(.white, for: .normal)
        
    }

    @IBAction func navigationButton(_ sender: UIButton) {
        let vc = HomeViewController.fromStoryboard
        self.navigationController?.pushViewController(vc, animated: true)
        
//        let rootVC = HomeViewController()
//        let navVC = UINavigationController(rootViewController: rootVC)
//        navVC.modalPresentationStyle = .formSheet
//        present(navVC, animated: true)
    }
}

