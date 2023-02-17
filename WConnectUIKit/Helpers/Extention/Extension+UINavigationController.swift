//
//  Extension+UINavigationController.swift
//  Dogiz
//
//  Created by Maksym Vitovych on 9/8/21.
//  Copyright © 2021 Lampa. All rights reserved.
//

import UIKit

extension UINavigationController {
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
            popToViewController(vc, animated: animated)
        }
    }
    
    func popViewControllers(count: Int) {
        let viewControllers: [UIViewController] = self.viewControllers
        var newCount: Int = count
        
        if self.viewControllers.count < count {
            newCount = self.viewControllers.count
        }
        
        self.popToViewController(viewControllers[viewControllers.count - newCount], animated: true)
    }
    
    func removeViewController(_ controller: UIViewController.Type) {
        if let viewController = viewControllers.first(where: { $0.isKind(of: controller.self) }) {
            viewController.removeFromParent()
        }
    }
}
