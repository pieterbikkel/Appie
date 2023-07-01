//
//  ShoppingCartView.swift
//  Appie
//
//  Created by Pieter Bikkel on 27/06/2023.
//

import SwiftUI
import AlertToast

struct ShoppingCartView: View {
    
    @StateObject private var viewModel: ShoppingCartViewModel = ShoppingCartViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.listResponse.list, id: \.webshopID) { item in
                    ShoppingCartItemView(item: item)
                        .frame(height: 80)
                }
                .onDelete(perform: viewModel.deleteItems)
                
                HStack {
                    Text("Totaal:")
                    
                    Spacer()
                    
                    PriceView(price: viewModel.listResponse.total ?? 0.0, normal: true)
                    
                }
                .font(.headline)
            }
            .refreshable {
                viewModel.getShoppingCartItems()
            }
            .onAppear {
                viewModel.getShoppingCartItems()
            }
            
            .navigationTitle("Karretje")
        }
        .toast(isPresenting: Binding(projectedValue: $viewModel.error)) {
            AlertToast(displayMode: .hud, type: .regular, title: viewModel.errorMessage)
        }
    }
}

struct ShoppingCartView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingCartView()
    }
}
