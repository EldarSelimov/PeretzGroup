//
//  MenuTableViewController.swift
//  PeretzGroupTest
//
//  Created by Eldar on 14.08.2020.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    private var menu: [MenuModel] = []
    
    private let cartManager = CartManager.shared
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak var cartView: CartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor(red: 0.092, green: 0.092, blue: 0.092, alpha: 1)
        tableView.contentInset.bottom = 70 + (UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0)
        
        NetworkManager.shared.getMenu(onSuccess: { [weak self] (menuList) in
            self?.menu = menuList
            self?.tableView.reloadData()
        }) { (error) in
            print(error)
        }
    }
    
}

extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menu.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuTableViewCell
        
        if (cell.responds(to: #selector(setter: UITableViewCell.separatorInset))) {
            cell.separatorInset = UIEdgeInsets.zero
        }
        
        if (cell.responds(to: #selector(setter: UIView.preservesSuperviewLayoutMargins))) {
            cell.preservesSuperviewLayoutMargins = false
        }
        
        if (cell.responds(to: #selector(setter: UIView.layoutMargins))) {
            cell.layoutMargins = UIEdgeInsets.zero
        }
        
        let item = menu[indexPath.row]
        let count = cartManager.getDishCount(by: item.id)
        cell.configure(with: item, count: count, delegate: self)
        
        return cell
    }
}

extension MenuViewController: MenuTableViewCellDelegate {
    
    func orderAdded(_ order: MenuModel) {
        cartView.addOrder(order)
    }
    
    func orderDeleted(_ order: MenuModel) {
        cartView.removeOrder(order)
    }
    
}


