//
//  HomeCategoryCollectionViewCell.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 01.03.2023.
//

import UIKit

class HomeCategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func display(categoryEntity: HomeEntity.View.CategoryEntity) {
        categoryLabel.text = categoryEntity.title
        categoryImage.load(string: categoryEntity.icon)
    }

}
