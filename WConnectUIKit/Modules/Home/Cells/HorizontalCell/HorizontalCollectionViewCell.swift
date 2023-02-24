//
//  HorizontalCollectionViewCell.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 24.02.2023.
//

import UIKit

class HorizontalCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var viewImage: UIImageView!
    @IBOutlet weak var serviceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func display(serviceImage: UIImage, serviceText: String) {
        
        viewImage.image = serviceImage
        viewImage.layer.cornerRadius = 4
        
        serviceLabel.text = serviceText
        serviceLabel.textColor = UIColor(named: Color.baseWhite)
    }
}
