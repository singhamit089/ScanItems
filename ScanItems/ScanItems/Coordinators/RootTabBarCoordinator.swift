//
//  RootTabBarCoordinator.swift
//  ScanItems
//
//  Created by Amit Singh on 06/10/20.
//  Copyright © 2020 singhamit089. All rights reserved.
//

import UIKit
import RxSwift
import SwiftIconFont

class RootTabBarCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow
    private var selectedIndex = 0
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        
        let tabBarController = UITabBarController()
        tabBarController.selectedIndex = selectedIndex
        
        let homeViewController = HomeViewController()
        homeViewController.coordinator = self
        
        let scannerViewController = ScannerViewController()
        scannerViewController.coordinator = self
        
        let cartViewController = CartViewController()
        cartViewController.coordinator = self
        
        tabBarController.viewControllers = [
            UINavigationController(rootViewController: homeViewController),
            UINavigationController(rootViewController: scannerViewController),
            UINavigationController(rootViewController: cartViewController)
        ]
        
        
        let homeTabbaritem = UITabBarItem()
        homeTabbaritem.icon(from: .ionicon, code: "ios-home", iconColor: UIColor.gray, imageSize: CGSize.init(width: 25, height: 25), ofSize: 25)
        homeTabbaritem.title = "Home"
        
        let scannerTabbaritem = UITabBarItem()
        scannerTabbaritem.icon(from: .ionicon, code: "ios-barcode", iconColor: UIColor.gray, imageSize: CGSize.init(width: 25, height: 25), ofSize: 25)
        scannerTabbaritem.title = "Scanner"

        let cartTabbaritem = UITabBarItem()
        cartTabbaritem.icon(from: .ionicon, code: "ios-cart", iconColor: UIColor.gray, imageSize: CGSize.init(width: 25, height: 25), ofSize: 25)
        cartTabbaritem.title = "Cart"
        
        tabBarController.viewControllers?[0].tabBarItem = homeTabbaritem
        tabBarController.viewControllers?[1].tabBarItem = scannerTabbaritem
        tabBarController.viewControllers?[2].tabBarItem = cartTabbaritem
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = UIColor.white
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        
        return Observable.never()
    }
    
    func setSelectedIndex(itemOnIndex:TabBarItemOnIndex) {
        switch itemOnIndex {
        case .home:
            selectedIndex = 0
        case .barcode:
            selectedIndex = 1
        case .cart:
            selectedIndex = 2
        }
    }
    
}

enum TabBarItemOnIndex {
    case home
    case barcode
    case cart
}

