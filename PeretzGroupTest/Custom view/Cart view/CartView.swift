//
//  CartView.swift
//  PeretzGroupTest
//
//  Created by Eldar on 05.09.2020.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit

class CartView: UIView {
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Корзина"
        return label
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var itemsView: CartItemImagesView = {
        let view = CartItemImagesView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var orders: [MenuModel] = [] {
        didSet {
            calculateOrders()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        config()
    }
    
    public func addOrder(_ order: MenuModel) {
        orders.append(order)
        
        if orders.count > 1 {
            if orders.filter({ $0.id == order.id }).count > 1 {
                return
            }
        }
        
        itemsView.setItem(with: order)
    }
    
    public func removeOrder(_ order: MenuModel) {
        if let lastIndex = orders.lastIndex(of: order) {
            if orders.filter({ $0.id == order.id }).count == 1 {
                itemsView.dropItem(order)
            }
            orders.remove(at: lastIndex)
        }
    }
    
}

fileprivate extension CartView {
    
    func config() {
        layer.cornerRadius = bounds.height / 2
        
        setupUI()
    }
    
    
    func setupUI() {
        addSubview(amountLabel)
        addSubview(titleLabel)
        addSubview(countLabel)
        addSubview(itemsView)
        
        NSLayoutConstraint.activate([
            amountLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25),
            amountLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            amountLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 10),
            
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            itemsView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            itemsView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            itemsView.heightAnchor.constraint(equalToConstant: bounds.height - 20),
            itemsView.widthAnchor.constraint(equalToConstant: self.bounds.height * 1.3),
            
            countLabel.leadingAnchor.constraint(equalTo: itemsView.trailingAnchor, constant: 10),
            countLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func calculateOrders() {
        let amount = orders.map { $0.price }.reduce(0, +)
        amountLabel.text = amount.getCurrencyString()
        
        countLabel.text = "\(orders.count)"
    }
    
}
