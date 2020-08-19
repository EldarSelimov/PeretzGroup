//
//  CartManager.swift
//  PeretzGroupTest
//
//  Created by Eldar on 14.08.2020.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation

class CartManager {
    static let shared = CartManager()
    private init() {}
    
    private var dishesIds: [Int: Int] = [:]
    
    func getDishCount(by id: Int) -> Int? {
        return dishesIds[id]
    }
    
    func plusDishes(_ id: Int) {
        if dishesIds[id] != nil {
            dishesIds[id]! += 1
        } else {
            dishesIds[id] = 1
        }
    }
    
    func minusDishes(_ id: Int) {
        if dishesIds[id] != nil {
            dishesIds[id]! -= 1
            
            if dishesIds[id]! == 0 {
                dishesIds[id] = nil
            }
        }
    }
}
