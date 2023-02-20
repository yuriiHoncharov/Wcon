//
//  ServiceTableViewCell.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 17.02.2023.
//

import UIKit

class ServiceTableViewCell: UITableViewCell {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userOrderLabel: UILabel!
    @IBOutlet weak var userRatingLabel: UILabel!
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

    func setService(service: SearchEntity) {
        userNameLabel.text = service.firstName
        userOrderLabel.text = service.category
        userRatingLabel.text = "wqqwqw"
    }
    
}
 
