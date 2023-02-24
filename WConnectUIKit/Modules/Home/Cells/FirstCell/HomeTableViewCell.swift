//
//  HomeTableViewCell.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 23.02.2023.
//

import UIKit
//protocol HomeTableViewCellProtocol: AnyObject {
//    buttonAction (() -> Void)?
//}

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var styleButton: UIButton!
    var buttonAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor(named: Color.backgroundGray)
    }
    
    @IBAction func navigationButton(_ sender: Any) {
        buttonAction?()
    }
    
    func display(title: String, subtitle: String, buttonTitle: String) {
        titleLabel.text = title // "Популярные заказы"
        subtitleStyle(subtitle: subtitle)
        buttonStyle(buttonTitle: buttonTitle)
    }
    
    func subtitleStyle(subtitle: String) {
        subtitleLabel.text = subtitle
        subtitleLabel.numberOfLines = 4
        subtitleLabel.textColor = UIColor(named: Color.neutralGrey30)
    }
    
    func buttonStyle(buttonTitle: String) {
        styleButton.setTitleColor(UIColor(named: Color.baseWhite), for: .normal)
        styleButton.setTitle(buttonTitle, for: .normal)
        styleButton.titleLabel?.font = .systemFont(ofSize: 10, weight: .medium)
        styleButton.sizeToFit()
        styleButton.contentEdgeInsets = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12)
        styleButton.backgroundColor = UIColor(named: Color.primeryGreen100)
        styleButton.cornerRadius = 4
    }
}
