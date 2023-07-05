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
    var vm: ShoppingCartViewModel
    
    @State private var editAmount = false
    @State private var amount: Int
    @State private var timer: Timer?
    @State private var remainingSeconds = 2
    
    init(item: ShoppingListItem, vm: ShoppingCartViewModel) {
        
        self.item = item
        self.amount = item.amount ?? 0
        self.vm = vm
        
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
                    
                    Spacer(minLength: editAmount ? 20 : 0)
                    
                    Button {
                        withAnimation {
                            editAmount.toggle()
                            startTimer()
                        }
                    } label: {
                        HStack() {
                            Button {
                                if amount > 0 {
                                    amount -= 1
                                    if remainingSeconds < 2 {
                                        remainingSeconds += 1
                                    }
                                }
                            } label: {
                                Image(systemName: "minus")
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(Color.theme.white)
                                    .background(isBonus ? Color.theme.orange : Color.theme.black)
                                    .cornerRadius(13)
                            }
                            .offset(x: editAmount ? 0 : 35)
                            .frame(width: editAmount ? nil : 0)
                            
                            Text("\(amount)")
                                .frame(width: 25)
                                .font(.headline)
                                .foregroundColor(isBonus ? Color.theme.orange : Color.theme.black)
                                .padding(EdgeInsets(top: 4, leading: 20, bottom: 4, trailing: 20))
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(lineWidth: 2)
                                        .foregroundColor(isBonus ? Color.theme.orange : Color.theme.black)
                                )
                                .background(Color.theme.white)
                                .zIndex(2)
                            
                            Button {
                                if amount < 99 {
                                    amount += 1
                                    if remainingSeconds < 2 {
                                        remainingSeconds += 2
                                    }
                                }
                            } label: {
                                Image(systemName: "plus")
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(Color.theme.white)
                                    .background(isBonus ? Color.theme.orange : Color.theme.black)
                                    .cornerRadius(13)
                            }
                            .frame(width: editAmount ? nil : 0)
                            .offset(x: editAmount ? 0 : -35)
                        }
                    }
                }
            }
            .frame(height: 80)
        }
    }
    
    func startTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
        
        remainingSeconds = 2
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if remainingSeconds > 0 {
                remainingSeconds -= 1
            } else {
                stopTimer()
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        
        if amount == 0 {
            vm.deleteItems(webshopId: item.webshopID ?? 0)
        } else {
            vm.updateAmount(webshopId: item.webshopID ?? 0, amount: amount)
        }
        
        withAnimation {
            editAmount.toggle()
        }
        
        timer = nil
    }
}

struct ShoppingCartItemView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ShoppingCartItemView(item: Constants.DefaultModels.shoppingCartItem, vm: dev.shoppingCartVM)
                .padding(.horizontal)
                .toolbar(.hidden)
        }
    }
}
