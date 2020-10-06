//
//  CartViewCoordinator.swift
//  ScanItems
//
//  Created by Amit Singh on 07/10/20.
//  Copyright © 2020 singhamit089. All rights reserved.
//

import UIKit
import RxSwift

class CartViewCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        
        let viewController = CartViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        return Observable.never()
    }
}


