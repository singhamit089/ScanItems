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
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        
        let tabBarController = UITabBarController()
        
        let homeViewController = HomeViewController()
        let scannerViewController = ScannerViewController()
        
        tabBarController.viewControllers = [
            UINavigationController(rootViewController: homeViewController),
            UINavigationController(rootViewController: scannerViewController)
        ]
        
        
        let homeTabbaritem = UITabBarItem()
        homeTabbaritem.icon(from: .ionicon, code: "ios-home", iconColor: UIColor.gray, imageSize: CGSize.init(width: 25, height: 25), ofSize: 25)
        homeTabbaritem.title = "Home"
        let scannerTabbaritem = UITabBarItem()
        scannerTabbaritem.icon(from: .ionicon, code: "ios-film", iconColor: UIColor.gray, imageSize: CGSize.init(width: 25, height: 25), ofSize: 25)
        scannerTabbaritem.title = "Scanner"

        
        tabBarController.viewControllers?[0].tabBarItem = homeTabbaritem
        tabBarController.viewControllers?[1].tabBarItem = scannerTabbaritem
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = UIColor.white
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        
        return Observable.never()
    }
    
}


