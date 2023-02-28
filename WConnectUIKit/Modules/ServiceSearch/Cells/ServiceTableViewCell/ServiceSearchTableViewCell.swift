//
//  ServiceSearchTableViewCell.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 27.02.2023.
//

import UIKit

class ServiceSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var styleTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//    }
    func display(countService: Int) {
        countLabel.text = "\(Constants.Search.specialists) \(countService)"
        countLabel.font = .systemFont(ofSize: 10, weight: .medium)
    }
    
    @IBAction func filterNavigation(_ sender: Any) {
        
    }
    
    @IBAction func searchTextField(_ sender: Any) {
   
    }
}
