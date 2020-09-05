//
//  Int+Ext.swift
//  PeretzGroupTest
//
//  Created by Eldar on 05.09.2020.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation

public extension Int {
    
    func getCurrencyString() -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.allowsFloats = false
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale(identifier: "ru_RU")
        numberFormatter.generatesDecimalNumbers = false
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter.string(from: NSNumber(integerLiteral: self))
    }
    
}
