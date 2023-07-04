//
//  ProductListItem.swift
//  Appie
//
//  Created by Pieter Bikkel on 28/06/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductListItem: View {
    
    var product: Product
    @EnvironmentObject private var viewModel: HomeViewModel
    var price: Double
    var showAction: Bool = false
    
    init(product: Product) {
        
        self.product = product
        
        if product.isBonus ?? false {
            price = product.currentPrice ?? product.priceBeforeBonus ?? 11.22
        } else {
            price = product.priceBeforeBonus ?? 11.22
        }
        
        if product.isBonus ?? false && (product.bonusMechanism != nil) {
            showAction = true
        }
    }   
    
    var body: some View {
        GeometryReader { reader in
            HStack(alignment: .center, spacing: 20) {
                WebImage(url: URL(string: product.images?.last?.url ?? Constants.backupImage))
                    .resizable()
                    .frame(width: reader.size.width / 4, height: reader.size.width / 4)
                
                VStack(alignment: .leading) {
                    Text(product.title ?? "")
                        .lineLimit(2)
                        .foregroundColor(Color.theme.black)
                    
                    if showAction {
                        
                        Text(product.bonusMechanism ?? "")
                            .padding(6)
                            .lineLimit(2)
                            .foregroundColor(Color.theme.white)
                            .background(Color.theme.orange)
                            .fontWeight(.bold)
                            .cornerRadius(10)
                    } else {
                        Spacer()
                    }
                    
                    HStack {
                        PriceView(price: price)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                        
                        Button {
                            viewModel.addProduct(webshopId: product.webshopID ?? 0, amount: 1)
                        } label: {
                            Image(systemName: "plus")
                                .particleEffect(systemImage: "plus", font: Font.body, status: true, activeTint: Color.theme.white, inActiveTint: Color.theme.gray)
                                .foregroundColor(Color.theme.white)
                                .frame(width: 30, height: 30)
                                .background((product.isBonus ?? false) ? Color.theme.orange : Color.theme.blue )
                                .cornerRadius(15)
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}

struct ProductListItem_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProductListItem(product: Constants.DefaultModels.bonusProduct)
                .frame(height: 200)
                .toolbar(.hidden)
        }.environmentObject(dev.homeVM)
        
    }
}
