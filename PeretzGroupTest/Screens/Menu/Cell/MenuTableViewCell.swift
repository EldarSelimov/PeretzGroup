//
//  MenuTableViewCell.swift
//  PeretzGroupTest
//
//  Created by Eldar on 14.08.2020.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit
import Kingfisher

protocol MenuTableViewCellDelegate: class {
    func orderAdded(_ order: MenuModel)
    func orderDeleted(_ order: MenuModel)
}

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var menuImageView: UIImageView!
    @IBOutlet weak var newView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    
    private let cartManager = CartManager.shared
    
    private var order: MenuModel?
    
    private var count = 0
    
    private weak var delegate: MenuTableViewCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func configure(with menu: MenuModel, count: Int?, delegate: MenuTableViewCellDelegate) {
        self.order = menu
        self.delegate = delegate
        menuImageView.kf.setImage(with: URL(string: menu.image))
        newView.isHidden = !menu.new
        
        nameLabel.text = menu.name
        descriptionLabel.text = menu.description
        
        priceLabel.text = "\(menu.price) ₽"
        
        if let count = count {
            countLabel.text = String(count)
            self.count = count
        } else {
            minusButton.isHidden = true
            countLabel.isHidden = true
        }
    }
    
    @IBAction func actionMinus(_ sender: Any) {
        guard let order = self.order else { return }
        cartManager.minusDishes(order.id)
        count -= 1
        countLabel.text = String(count)
        if count == 0 {
            minusButton.isHidden = true
            countLabel.isHidden = true
        }
        delegate.orderDeleted(order)
    }
    
    @IBAction func actionPlus(_ sender: Any) {
        guard let order = self.order else { return }
        cartManager.plusDishes(order.id)
        if count == 0 {
            minusButton.isHidden = false
            countLabel.isHidden = false
        }
        count += 1
        countLabel.text = String(count)
        delegate.orderAdded(order)
    }
    
}

