//
//  SplashViewCoordinator.swift
//  ScanItems
//
//  Created by Amit Singh on 07/10/20.
//  Copyright © 2020 singhamit089. All rights reserved.
//

import UIKit
import RxSwift

class SplashViewCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        
        let previouslyLaunched = UserDefaults.standard.bool(forKey: IdentifyingKeys.firstLaunch.rawValue)
        
        if !previouslyLaunched {
            let viewController = SplashViewController()
            viewController.coordinator = self
            let navigationController = UINavigationController(rootViewController: viewController)
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        } else {
            let rootTabBarCoordinator = RootTabBarCoordinator(window: window)
            return coordinate(to: rootTabBarCoordinator)
        }
        
        
        return Observable.never()
    }
}


