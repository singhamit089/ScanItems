//
//  SplashViewController.swift
//  ScanItems
//
//  Created by Amit Singh on 07/10/20.
//  Copyright © 2020 singhamit089. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    var coordinator: BaseCoordinator<Void>!
    let loadingViewController = LoadingViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        add(loadingViewController)
        
        // We call API just once
        DataProvider.sharedInstance.getProductList { result in
            switch result {
            case .Success:
                self.loadingViewController.remove()
                let previouslyLaunched = UserDefaults.standard.bool(forKey: IdentifyingKeys.firstLaunch.rawValue)
                if !previouslyLaunched {
                    UserDefaults.standard.set(true, forKey: IdentifyingKeys.firstLaunch.rawValue)
                }
                _ = self.coordinator.start()
            case let .Error(error):
                print("API Error")
                self.loadingViewController.remove()

                let errorViewController = ErrorViewController(error: error)
                self.add(errorViewController)
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
