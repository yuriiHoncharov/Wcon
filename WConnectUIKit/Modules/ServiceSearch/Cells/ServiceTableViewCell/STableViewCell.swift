//
//  STableViewCell.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 22.02.2023.
//

import UIKit

class STableViewCell: UITableViewCell {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var servicePriceLabel: UILabel!
    @IBOutlet weak var serviceCommentLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var favouriteStateButton: UIButton!
    var favouriteButton: (() -> Void)?
    var contactButton: (() -> Void)?
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let margins = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        contentView.frame = contentView.frame.inset(by: margins)
        contentView.layer.cornerRadius = 8
    }
    
    @IBAction func favouriteButton(_ sender: Any) {
        favouriteButton?()
    }
    
    @IBAction func contactButton(_ sender: Any) {
        contactButton?()
    }
    
    func setService(service: ServiceSearchEntity.View.SearchItemEntity) {
        backgroundImage.cornerRadius = 10
        backgroundImage.backgroundColor = UIColor(named: Color.baseWhite)
        
        userImage.load(string: service.avatar)
        userImage.contentMode = .scaleAspectFill
        userImage.makeRounded()
        
        userNameLabel.text = String("\(service.name)  \(service.surname)")
    }
}
