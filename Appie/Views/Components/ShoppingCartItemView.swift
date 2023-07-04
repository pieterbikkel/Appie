//
//  ShoppingCartItemView.swift
//  Appie
//
//  Created by Pieter Bikkel on 29/06/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct ShoppingCartItemView: View {
    
    var item: ShoppingListItem
    var isBonus: Bool
    
    init(item: ShoppingListItem) {
        
        self.item = item
        
        if (item.currentPrice != nil) {
            self.isBonus = true
        } else {
            self.isBonus = false
        }
    }
    
    var body: some View {
        GeometryReader { reader in
            VStack(alignment: .leading) {
                HStack {
                    WebImage(url: URL(string: item.images?.last?.url ?? Constants.backupImage))
                        .resizable()
                        .frame(width: reader.size.width / 4, height: reader.size.width / 4)
                    
                    VStack(alignment: .leading) {
                        Text(item.name ?? "BRO")
                        
                        Spacer()
                        
                        if isBonus {
                            HStack {
                                HStack {
                                    Text(item.priceBeforeBonus?.formattedPriceArray.first ?? "0.") + Text(".") + Text(item.priceBeforeBonus?.formattedPriceArray.last ?? "0")
                                }
                                .strikethrough()
                                
                                HStack {
                                    Text(item.currentPrice?.formattedPriceArray.first ?? "0.") + Text(".") + Text(item.currentPrice?.formattedPriceArray.last ?? "0")
                                }
                                .foregroundColor(Color.theme.orange)
                                .fontWeight(.bold)
                            }
                        } else {
                            Text(item.priceBeforeBonus?.formattedPriceArray.first ?? "0.") + Text(".") + Text(item.priceBeforeBonus?.formattedPriceArray.last ?? "0")
                        }
                        
                    }
                    
                    Spacer()
                    
                    Text("\(item.amount ?? 0)")
                        .font(.headline)
                }
                
                ForEach(item.amountPerUser ?? [], id: \.name) { user in
                    HStack {
                        Text(user.name ?? "wtf")
                            .font(.headline)
                        
                        Spacer()
                        
                        Text("\(user.amount ?? 0)")
                    }
                }
            }.frame(height: 100 + CGFloat(20 * (item.amountPerUser?.count ?? 50)))
        }
    }
}

struct ShoppingCartItemView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingCartItemView(item: Constants.DefaultModels.shoppingCartItem)
    }
}
