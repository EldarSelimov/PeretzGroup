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

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        cell.configure(with: item, count: count)
        
        return cell
    }
}


