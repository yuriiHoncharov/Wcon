//
//  HorizontalTableViewCell.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 24.02.2023.
//

import UIKit

struct TopService {
    let image: UIImage?
    let text: String
}

class HorizontalTableViewCell: UITableViewCell {

    @IBOutlet weak var horizontalCollectionView: UICollectionView!
       private let topService: [TopService] = [
           .init(image: UIImage(named: "MobilePicture01"), text: "1"),
           .init(image: UIImage(named: "MobilePicture02"), text: "2"),
           .init(image: UIImage(named: "MobilePicture03"), text: "3"),
           .init(image: UIImage(named: "MobilePicture04"), text: "4"),
           .init(image: UIImage(named: "MobilePicture05"), text: "5"),
           .init(image: UIImage(named: "MobilePicture06"), text: "6"),
           .init(image: UIImage(named: "MobilePicture07"), text: "7"),
           .init(image: UIImage(named: "MobilePicture08"), text: "8")
       ]
       
       private let images = ["MobilePicture01", "MobilePicture02", "MobilePicture03",  "MobilePicture04", "MobilePicture05", "MobilePicture06", "MobilePicture07", "MobilePicture08"]
       
       private let text = ["1", "2", "3", "4", "5", "6", "7", "8"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollection()
        backgroundColor = UIColor(named: "BackgroundGray")

    }
    
    private func setupCollection() {
          horizontalCollectionView.dataSource = self
          horizontalCollectionView.delegate = self
          horizontalCollectionView.register(HorizontalCollectionViewCell.self)
      }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension HorizontalTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topService.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeue(HorizontalCollectionViewCell.self, indexPath)
        cell.viewImage.image = UIImage(named: images[indexPath.row])
        cell.serviceLabel.text = text[indexPath.row]
        
        //        cell.viewImage.image = UIImage(named: topService[indexPath.row])
        
        //        topService.forEach { entity in
        //            if let image = entity.image[indexPath.row] {
        //                cell.display(serviceImage: image, serviceText: entity.text[indexPath.row])
        //            }
        //        }
        
        //        for service in topService {
        //            cell.display(serviceImage: service.image!,
        //                         serviceText: service.text[indexPath.row])
        //        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 135, height: 180)
    }
}

