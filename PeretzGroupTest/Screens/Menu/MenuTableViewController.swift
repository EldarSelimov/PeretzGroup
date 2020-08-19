//
//  MenuTableViewController.swift
//  PeretzGroupTest
//
//  Created by Eldar on 14.08.2020.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit


class MenuTableViewController: UITableViewController {
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.navigationItem.hidesBackButton = true
//    }
    
//    let yourBackImage = UIImage(named: "back-arrow")
//    self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
//    self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
//    self.navigationController?.navigationBar.backItem?.title = "Custom"
//
//    let backImage = UIImage(named: "back-arrow")
//    self.navigationController?.navigationBar.backIndicatorImage = backImage
//    self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
//    /*** If needed Assign Title Here ***/
//    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil
//   
    
    private var menu: [MenuModel] = []
    
    private let cartManager = CartManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let backActionButton = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: navigationController, action: nil)
//        navigationItem.leftBarButtonItem = backActionButton
//        tableView.separatorColor = UIColor.black
//
        NetworkManager.shared.getMenu(onSuccess: { (menuList) in
            self.menu = menuList
            self.tableView.reloadData()
        }) { (error) in
            print(error)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menu.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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


