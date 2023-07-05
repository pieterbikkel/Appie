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
            ScrollView {
                ForEach(viewModel.listResponse.list, id: \.webshopID) { item in
                    let bonus = item.currentPrice != nil
                    
                    // MARK: Aantal per user
                    ForEach(item.amountPerUser ?? [], id: \.name) { user in
                        
                        HStack {
                            Text("\(user.amount)")
                            
                            Text(user.name)
                            
                            Spacer()
                            
                            if bonus {
                                PriceView(price: item.currentPrice ?? 0.0, normal: true)
                            } else {
                                PriceView(price: item.priceBeforeBonus ?? 0.0, normal: true)
                            }
                        }
                    }
                    
                    // MARK: Item
                    ShoppingCartItemView(item: item, vm: viewModel)
                        .frame(height: 80)
                    
                    Divider()
                }
            
                
                // MARK: Totaal bedrag per user
                ForEach(viewModel.listResponse.totalPerUser ?? [], id: \.name) { user in
                    HStack {
                        Text("\(user.name):")
                        
                        Spacer()
                        
                        PriceView(price: user.total, normal: true)
                    }
                }
                
                HStack {
                    Text("Totaal bespaard:")
                    
                    Spacer()
                    
                    PriceView(price: viewModel.listResponse.bonusAmount ?? 0.0, normal: true)
                    
                }
                .foregroundColor(Color.theme.orange)
                .font(.headline)
                
                HStack {
                    Text("Totaal:")
                    
                    Spacer()
                    
                    PriceView(price: viewModel.listResponse.total ?? 0.0, normal: true)
                    
                }
                .font(.headline)
            }
            .padding(.horizontal)
            .refreshable {
                viewModel.getShoppingCartItems()
            }

            .navigationTitle("Karretje")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "ellipsis")
                            .foregroundColor(Color.theme.black)
                    }

                }
            }
        }
        .toast(isPresenting: Binding(projectedValue: $viewModel.error)) {
            AlertToast(displayMode: .hud, type: .regular, title: viewModel.errorMessage)
        }
        .onAppear {
            viewModel.getShoppingCartItems()
        }
    }
}

struct ShoppingCartView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingCartView()
    }
}
