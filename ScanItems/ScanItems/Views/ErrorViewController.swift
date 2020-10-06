//
//  ErrorViewController.swift
//  ScanItems
//
//  Created by Amit Singh on 06/10/20.
//  Copyright © 2020 singhamit089. All rights reserved.
//

import UIKit

class ErrorViewController: UIViewController {
    var reloadHandler: () -> Void = {}
    let error: Error

    init(error: Error) {
        self.error = error
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.async {
            self.showAlertWith(title: "Error", message: self.error.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func showAlertWith(title: String, message: String, style: UIAlertController.Style = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)

        let action = UIAlertAction(title: "Retry", style: .default) { _ in
            self.reloadHandler()
        }

        alertController.addAction(action)

        present(alertController, animated: true, completion: nil)
    }
}

