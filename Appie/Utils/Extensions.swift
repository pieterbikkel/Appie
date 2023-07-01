//
//  Extensions.swift
//  Appie
//
//  Created by Pieter Bikkel on 28/06/2023.
//

import Foundation

extension Double {
    var formattedPriceArray: [String] {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "en_US")
        let formattedString = formatter.string(from: NSNumber(value: self)) ?? ""
        let components = formattedString.components(separatedBy: ".")
        
        if components.count > 1 {
            let integerPart = components[0]
            let decimalPart = components[1]
            
            if decimalPart.count <= 2 {
                return [integerPart, decimalPart]
            } else {
                let index = decimalPart.index(decimalPart.startIndex, offsetBy: 2)
                let truncatedDecimalPart = String(decimalPart[..<index])
                return [integerPart, truncatedDecimalPart]
            }
        } else {
            return [formattedString, "00"]
        }
    }
}
