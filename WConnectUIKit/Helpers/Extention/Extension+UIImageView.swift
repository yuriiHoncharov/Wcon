//
//  Extension+UIImageView.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 24.02.2023.
//

import UIKit

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
}
