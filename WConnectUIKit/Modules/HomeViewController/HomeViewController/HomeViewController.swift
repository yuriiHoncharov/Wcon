//
//  HomeViewController.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 16.02.2023.
//

import UIKit

//protocol HomeViewProtocol: AnyObject {
//    init(view: UIViewController)
//}

class HomeViewController: UIViewController {
       
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(HomeCollectionViewCell.self)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(HomeCollectionViewCell.self, indexPath)
        cell.display(title: "title title title title", subtitle: "subtitle", buttonTitle: "button")
        cell.buttonAction = { [weak self] in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                let vc = ServiceSearchViewController.builder.default()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        //         tableView.backgroundColor =  UIColor(named: "backgroundCray")

        cell.backgroundColor =  UIColor(named: "BackgroundGray")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 120)
    }
}
