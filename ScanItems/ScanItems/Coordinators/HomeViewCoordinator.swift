//
//  HomeViewCoordinator.swift
//  ScanItems
//
//  Created by Amit Singh on 06/10/20.
//  Copyright © 2020 singhamit089. All rights reserved.
//

import UIKit
import RxSwift

class HomeViewCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        
        let viewController = HomeViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        return Observable.never()
    }
}

