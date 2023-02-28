//
//  MainTabBarItems.swift
//  Dogiz
//
//  Created by Yurii Honcharov on 23.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

enum MainTabBarItems: Int, CaseIterable {
    case home = 0
    case orders
    case chats
    case profile
    
    var title: String {
        switch self {
        case .home: return Constants.TabBar.home
        case .orders: return Constants.TabBar.orders
        case .chats: return Constants.TabBar.chats
        case .profile: return Constants.TabBar.profile
        }
    }
    
    var image: UIImage {
        switch self {
        case .home: return UIImage(named: "Home") ?? .add
        case .orders: return UIImage(named: "Orders") ?? .add
        case .chats: return UIImage(named: "Chats") ?? .add
        case .profile: return UIImage(named: "Profile") ?? .add
        }
    }
    
    var selectedImage: UIImage {
        switch self {
        case .home: return UIImage(named: "HomeSelected") ?? .add
        case .orders: return UIImage(named: "OrdersSelected") ?? .add
        case .chats: return UIImage(named: "ChatsSelected") ?? .add
        case .profile: return UIImage(named: "ProfileSelected") ?? .add
        }
    }
    
    var viewController: UIViewController {
        switch self {
        case .home: return HomeViewController.builder.default()
        case .orders: return HomeViewController.builder.default()
        case .chats: return HomeViewController.builder.default()
        case .profile: return HomeViewController.builder.default()
        }
    }
}
