//
//  HomeTableViewCell.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 23.02.2023.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var styleButton: UIButton!
    var buttonAction: (() -> Void)?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func navigationButton(_ sender: Any) {
        buttonAction?()
    }
    
    func display() {
        titleLabel.text = "Популярные заказы"
        subtitleStyle()
        buttonStyle()
    }
    
    func subtitleStyle() {
        subtitleLabel.text = "Мы готовы помочь вам в решении самых разнообразных задач. Каждый день на нашем сайте появляется более 15 тысяч новых заказов."
        subtitleLabel.numberOfLines = 4
        subtitleLabel.textColor = UIColor(named: "NeutralGrey30")
    }
    
    func buttonStyle() {
        styleButton.setTitleColor(UIColor(named: "BaseWhite"), for: .normal)
        styleButton.setTitle("Смотреть все", for: .normal)
        styleButton.titleLabel?.font = .systemFont(ofSize: 10, weight: .medium)
        styleButton.sizeToFit()
        styleButton.contentEdgeInsets = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12)
        styleButton.backgroundColor = UIColor(named: "PrimeryGreen100")
        styleButton.cornerRadius = 4
    }
}
