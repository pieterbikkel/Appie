//
//  PriceView.swift
//  Appie
//
//  Created by Pieter Bikkel on 30/06/2023.
//

import SwiftUI

struct PriceView: View {
    
    var price: Double
    var normal: Bool = false
    
    var body: some View {
        HStack(alignment: .top) {
            Text((normal ? "€" : "") + "\(price.formattedPriceArray[0])")
                .font(normal ? .system(size: 16) : .system(size: 30, weight: .bold))
            + Text(".")
                .font(normal ? .system(size: 16) : .system(size: 30, weight: .bold))
            + Text("\(price.formattedPriceArray[1])")
                .font(normal ? .system(size: 16) : .system(size: 20, weight: .bold))
        }
    }
}

struct PriceView_Previews: PreviewProvider {
    static var previews: some View {
        PriceView(price: 12.9891023)
    }
}
