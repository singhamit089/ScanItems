//
//  AppCoordinator.swift
//  ScanItems
//
//  Created by Amit Singh on 06/10/20.
//  Copyright © 2020 singhamit089. All rights reserved.
//

import UIKit
import RxSwift

class AppCoordinator: BaseCoordinator<Void> {
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        let rootTabBarCoordinator = RootTabBarCoordinator(window: window)
        return coordinate(to: rootTabBarCoordinator)
    }
}


