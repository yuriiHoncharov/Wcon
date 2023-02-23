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
    
    override func layoutSubviews() {
          super.layoutSubviews()
          let margins = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
          contentView.frame = contentView.frame.inset(by: margins)
          contentView.layer.cornerRadius = 8
    }
    
//    override func layoutSubviews() {
//    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
//
    
    @IBAction func favouriteButton(_ sender: Any) {
        
    }
    
    @IBAction func contactButton(_ sender: Any) {
        
    }
    
    func setService(service: ServiceSearchV2Entity.View.SearchItemEntity) {
        backgroundImage.cornerRadius = 10
        backgroundImage.backgroundColor = UIColor(named: "BaseWhite")
        userImage.backgroundColor = .red
        userNameLabel.text = String("\(service.name)  \(service.surname)")
//        serviceLabel.text = service.category
//        servicePriceLabel.text = String("\(service.priceFrom) - \(service.priceTo)")
//        serviceCommentLabel.text = service.comment
    }
}
