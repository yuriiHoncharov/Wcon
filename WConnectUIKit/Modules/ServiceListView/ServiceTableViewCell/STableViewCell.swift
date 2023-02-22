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
    
    
    override func layoutSubviews() {
          super.layoutSubviews()
          //set the values for top,left,bottom,right margins
          let margins = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
          contentView.frame = contentView.frame.inset(by: margins)
          contentView.layer.cornerRadius = 8
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
//    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
//
    
    @IBAction func favouriteButton(_ sender: Any) {
        
    }
    
    @IBAction func contactButton(_ sender: Any) {
        
    }
    
    func setService(service: SearchEntity) {
        userImage.backgroundColor = .red
        userNameLabel.text = String("\(service.firstName)  \(service.lastName)")
        serviceLabel.text = service.category
        servicePriceLabel.text = String("\(service.priceFrom) - \(service.priceTo)")
        serviceCommentLabel.text = service.comment
    }
}
