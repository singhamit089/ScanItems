//
//  HomeViewController.swift
//  ScanItems
//
//  Created by Amit Singh on 06/10/20.
//  Copyright © 2020 singhamit089. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var coordinator: BaseCoordinator<Void>!
    let loadingViewController = LoadingViewController()
    private var tableView = UITableView()
    var safeArea: UILayoutGuide!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        do {
            try DataProvider.sharedInstance.storageManager.fetchedhResultController.performFetch()
            print("COUNT FETCHED FIRST: \(String(describing: DataProvider.sharedInstance.storageManager.fetchedhResultController.sections?[0].numberOfObjects))")
            tableView.reloadData()
        } catch let error {
            print("ERROR: \(error)")
        }
        
    }
    
    override func loadView() {
      super.loadView()
      view.backgroundColor = .white
      safeArea = view.layoutMarginsGuide
      setUpUI()
    }
    
    func setUpUI() {
        
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.allowsSelection = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadProducts() {}
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 100.0
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        if let count = DataProvider.sharedInstance.storageManager.fetchedhResultController.fetchedObjects?.count {
            return count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell") as! ItemTableViewCell

        if let item = DataProvider.sharedInstance.storageManager.fetchedhResultController.object(at: indexPath) as? Item {
            cell.setItemCell(item: item)
        }

        return cell
    }
}
