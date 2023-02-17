//
//  AppDelegate.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 16.02.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//               window?.rootViewController = UIStoryboard(name: "HomeViewController", bundle: nil).instantiateInitialViewController()
//               window?.makeKeyAndVisible()
        
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//
//           let storyboard = UIStoryboard(name: "HomeViewController", bundle: nil)
//
//        let initialViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
//
//           self.window?.rootViewController = initialViewController
//           self.window?.makeKeyAndVisible()
        
        let mainStoryboard = UIStoryboard(name: "HomeViewController", bundle: nil)
        let rootViewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController")
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.isNavigationBarHidden = true
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()

        return true
    }


}

