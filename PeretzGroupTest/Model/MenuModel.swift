//
//  MenuModel.swift
//  PeretzGroupTest
//
//  Created by Eldar on 14.08.2020.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation

struct MenuModel: Codable, Equatable, Hashable {
    let id: Int
    let name: String
    let description: String
    let new: Bool
    let price: Int
    let image: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: MenuModel, rhs: MenuModel) -> Bool {
        return lhs.id == rhs.id
    }
    
}
