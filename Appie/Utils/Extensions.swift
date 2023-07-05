//
//  Extensions.swift
//  Appie
//
//  Created by Pieter Bikkel on 28/06/2023.
//

import Foundation
import SwiftUI

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

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}

extension View {
    func iOS16navBarAdapter(_ colorScheme: ColorScheme) -> some View {
        if #available(iOS 16, *) {
            return self
                .toolbarBackground(Color.theme.black, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarColorScheme(colorScheme, for: .navigationBar)
        } else {
            return self
        }
    }
}

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}

class DeveloperPreview {
    static let instance = DeveloperPreview()
    
    private init() {}
    
    let homeVM = HomeViewModel()
    let shoppingCartVM = ShoppingCartViewModel()
}
