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
    @IBOutlet weak var userPriceLabel: UILabel!
    @IBOutlet weak var userCommentLabel: UILabel!
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//    }
    @IBAction func fauvoriteButton(_ sender: Any) {
        
    }
    
    func setService(service: SearchEntity) {
        userImageView.backgroundColor = .red
        userNameLabel.text = service.firstName
        userOrderLabel.text = service.category
        userPriceLabel.text = String("\(service.priceFrom) - \(service.priceTo)")
        userCommentLabel.text = "service.comment lkdfijdnf fninviirviufd mimdivjdfiovidf mdivovjdi mudfojivdiof joigoivdjoij oijdiofv"
    }
}

