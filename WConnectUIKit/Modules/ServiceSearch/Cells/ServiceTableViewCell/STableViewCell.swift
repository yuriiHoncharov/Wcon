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
    @IBOutlet weak var contactButton: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var favouriteStateButton: UIButton!
    @IBOutlet weak var popularImage: UIImageView!
    
    var favouriteButton: (() -> Void)?
    var contactButtonHandler: (() -> Void)?
    
    
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
        contactButtonHandler?()
    }
    
    func setService(service: ServiceSearchEntity.View.SearchItemEntity) {
        // MARK: popularImage
        if service.isPopular {
            popularImage.image = UIImage(named: Image.popular)
        }
        // MARK: background
        backgroundImage.cornerRadius = 10
        backgroundImage.backgroundColor = UIColor(named: Color.baseWhite)
        // MARK: contactButton
        contactButton.setTitle(Constants.Search.inviteToWork, for: .normal)
        contactButton.tintColor = UIColor(named: Color.baseBlack)
        contactButton.backgroundColor = .clear
        contactButton.layer.cornerRadius = 4
        contactButton.layer.borderWidth = 1
        contactButton.layer.borderColor = UIColor(named: Color.primeryGreen100)?.cgColor
        // MARK: userImage
        userImage.load(string: service.avatar)
        userImage.contentMode = .scaleAspectFill
        userImage.makeRounded()
        // MARK: serviceLabel
        serviceLabel.text = service.category
        // MARK: userNameLabel
        userNameLabel.text = String("\(service.name)  \(service.surname)")
        // MARK: servicePriceLabel
        servicePriceLabel.text = String("\(service.priceFrom) - \(service.priceTo)")
        // MARK: serviceCommentLabel
        serviceCommentLabel.text = service.comment
    }
}
