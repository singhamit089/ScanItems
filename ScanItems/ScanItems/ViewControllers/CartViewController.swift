//
//  CartViewController.swift
//  ScanItems
//
//  Created by Amit Singh on 07/10/20.
//  Copyright © 2020 singhamit089. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {

    var coordinator: BaseCoordinator<Void>!
    let loadingViewController = LoadingViewController()
    private var tableViewCart = UITableView()
    var safeArea: UILayoutGuide!
    
    var cartArray: [Cart]!
    
    var footerView: CartFooterTableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewCart.delegate = self
        tableViewCart.dataSource = self
        tableViewCart.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemTableViewCell")
        
        
        title = "Shopping Cart"

        NotificationCenter.default.addObserver(self, selector: #selector(cartUpdated), name: NSNotification.Name(IdentifyingKeys.cartUpdated.rawValue), object: nil)

        tableViewCart.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "CartTableViewCell")
        tableViewCart.register(UINib(nibName: "CartFooterTableViewCell", bundle: nil), forCellReuseIdentifier: "CartFooterTableViewCell")

        footerView = tableViewCart.dequeueReusableCell(withIdentifier: "CartFooterTableViewCell") as? CartFooterTableViewCell

        tableViewCart.tableFooterView = footerView.contentView

        cartUpdated()
    }
    
    @objc func cartUpdated() {
        
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
           view.addSubview(tableViewCart)
           tableViewCart.translatesAutoresizingMaskIntoConstraints = false
           tableViewCart.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
           tableViewCart.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
           tableViewCart.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
           tableViewCart.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
           tableViewCart.allowsSelection = false
       }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 80.0
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        if let count = cartArray?.count {
            return count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell") as! CartTableViewCell

        let cart = cartArray[indexPath.row] as Cart

        cell.labelItem.text = cart.items?.title
        cell.labelPrice.text = "\(cart.price)"
        cell.labelQty.text = "x\(cart.quantity)"

        return cell
    }
    
    
}
