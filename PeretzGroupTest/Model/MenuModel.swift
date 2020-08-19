//
//  MenuModel.swift
//  PeretzGroupTest
//
//  Created by Eldar on 14.08.2020.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation

struct MenuModel: Codable {
    let id: Int
    let name: String
    let description: String
    let new: Bool
    let price: Int
    let image: String
}
