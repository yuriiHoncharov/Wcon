//
//  HomeCollectionViewCell.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 17.02.2023.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet weak var navigationButton: UIButton!
    @IBOutlet weak var subtitleLabel: UILabel!
        var buttonAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
//    override func prepareForReuse() {
//        titleText
//    }
    
    @IBAction func setupButton(_ sender: Any) {
        buttonAction?()
    }
        
    func display(title: String, subtitle: String, buttonTitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        navigationButton.setTitle(buttonTitle, for: .normal)
        navigationButton.backgroundColor = .green
    }
}
