//
//  HomeCategoryTableViewCell.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 01.03.2023.
//

import UIKit

class HomeCategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var homeCategoryCollection: UICollectionView!
    var categoryEntity: [HomeEntity.View.CategoryEntity] = [
        .init(id: "", title: "111", icon: Image.popular),
        .init(id: "", title: "222", icon: Image.popular),
        .init(id: "", title: "333", icon: Image.popular)

    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        homeCategoryCollection.backgroundColor = UIColor(named: Color.primeryGreen100)
        setupCollection()
    }
    
    private func setupCollection() {
        homeCategoryCollection.dataSource = self
        homeCategoryCollection.delegate = self
        homeCategoryCollection.register(HomeCategoryCollectionViewCell.self)
    }
}

extension HomeCategoryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryEntity.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(HomeCategoryCollectionViewCell.self, indexPath)
        categoryEntity.forEach { cells in
            cell.display(categoryEntity: cells) }
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 135, height: 180)
//    }
}
