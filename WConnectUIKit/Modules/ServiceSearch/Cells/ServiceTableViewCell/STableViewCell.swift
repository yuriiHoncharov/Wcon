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

extension UIImageView {
    
    func makeRounded() {
        layer.borderWidth = 0.1
        layer.masksToBounds = false
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
    
    func load(string: String) {
        if let url = URL(string: string) {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
            }
        }
    }
    
//    func scalePreservingAspectRatio(targetSize: CGSize) -> UIImage {
//        // Determine the scale factor that preserves aspect ratio
//        let widthRatio = targetSize.width / size.width
//        let heightRatio = targetSize.height / size.height
//
//        let scaleFactor = min(widthRatio, heightRatio)
//
//        // Compute the new image size that preserves aspect ratio
//        let scaledImageSize = CGSize(
//            width: size.width * scaleFactor,
//            height: size.height * scaleFactor
//        )
//
//        // Draw and return the resized UIImage
//        let renderer = UIGraphicsImageRenderer(
//            size: scaledImageSize
//        )
//
//        let scaledImage = renderer.image { _ in
//            self.draw(in: CGRect(
//                origin: .zero,
//                size: scaledImageSize
//            ))
//        }
//
//        return scaledImage
//    }
}

