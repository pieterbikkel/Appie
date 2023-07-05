//
//  ProductDetailView.swift
//  Appie
//
//  Created by Pieter Bikkel on 04/07/2023.
//

import SwiftUI
import SDWebImageSwiftUI
import AlertToast

struct ProductDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var homeVM: HomeViewModel
    @StateObject private var vm: ProductDetailViewModel = ProductDetailViewModel()
    
    var webshopId: Int
    var currentPrice: Double
    var priceBeforeBonus: Double
    var isBonus: Bool
    
    @State private var amount: Int = 0
    @State private var addAmount = false
    
    private var accentColor: Color
    
    let maxSeconds = 2
    @State private var remainingSeconds = 2
    @State private var timer: Timer?
    
    init(webshopId: Int, currentPrice: Double, priceBeforeBonus: Double, isBonus: Bool) {
        self.webshopId = webshopId
        if currentPrice == 0.0 {
            self.currentPrice = priceBeforeBonus
        } else {
            self.currentPrice = currentPrice
        }
        self.priceBeforeBonus = priceBeforeBonus
        self.accentColor = isBonus && self.currentPrice != self.priceBeforeBonus ? Color.theme.orange : Color.theme.black
        self.isBonus = isBonus
    }
    
    var body: some View {
        GeometryReader { reader in
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                
                            Text("Terug")
                        }
                        .foregroundColor(Color.theme.black)
                        .fontWeight(.medium)
                        }
                    
                    WebImage(url: URL(string: vm.product.productCard.images.last?.url ?? Constants.noImage))
                        .resizable()
                        .frame(width: reader.size.width, height: reader.size.width)
                    
                    price
                    
                    Text(vm.product.productCard.title ?? "Bro")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 3)
                    
                    Text(vm.product.productCard.salesUnitSize ?? "Bro")
                        .foregroundColor(Color.theme.gray)
                    
                    addButton
                }
            }
            
        }
        .padding(.horizontal)
        .onAppear {
            vm.getProduct(webshopId: webshopId)
        }
        .navigationBarBackButtonHidden()
        
    }
    
    @ViewBuilder
    var price: some View {
        HStack {
            if isBonus && currentPrice != priceBeforeBonus {
                HStack {
                    Text(priceBeforeBonus.formattedPriceArray[0])
                    +
                    Text(".")
                    +
                    Text(priceBeforeBonus.formattedPriceArray[1])
                }
                .foregroundColor(Color.theme.black)
                .fontWeight(.regular)
                .strikethrough()
            }
            
            if isBonus && currentPrice == 0.0 {
                Text(priceBeforeBonus.formattedPriceArray[0])
                +
                Text(".")
                +
                Text(priceBeforeBonus.formattedPriceArray[1])
                    .font(.title2)
            } else {
                Text(currentPrice.formattedPriceArray[0])
                +
                Text(".")
                +
                Text(currentPrice.formattedPriceArray[1])
                    .font(.title2)
            }
        }
        .foregroundColor(accentColor)
        .font(.title)
        .fontWeight(.bold)
    }
    
    @ViewBuilder
    var addButton: some View {
        
        HStack(spacing: 0) {
            
            if addAmount {
                
                Button {
                    if amount > 0 {
                        amount -= 1
                        if remainingSeconds < maxSeconds {
                            remainingSeconds += 1
                        }
                    }
                } label: {
                    Image(systemName: "minus")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(width: 40, height: 40)
                        .background(accentColor)
                        .cornerRadius(20)
                }
                
                Spacer()
            }
            
            
                
            Button {
                withAnimation {
                    addAmount.toggle()
                    startTimer()
                }
            } label: {
                Text(addAmount ? "\(amount)" : "Voeg toe")
                    .foregroundColor(addAmount ? accentColor : Color.theme.white)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(maxWidth: addAmount ? 80 : .infinity)
                    .background(
                        roundedRectBG
                    )
                    .cornerRadius(20)
            }
            .padding(.top, 3)

            
            if addAmount {
                
                Spacer()
                
                Button {
                    if amount < 99 {
                        amount += 1
                        if remainingSeconds < maxSeconds {
                            remainingSeconds += 1
                        }
                    }
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(width: 40, height: 40)
                        .background(accentColor)
                        .cornerRadius(20)
                }
            }
        }
        .toast(isPresenting: Binding(projectedValue: $vm.error)) {
            AlertToast(displayMode: .hud, type: .regular, title: vm.errorMessage)
        }
        .toast(isPresenting: Binding(projectedValue: $homeVM.error)) {
            AlertToast(displayMode: .hud, type: .regular, title: homeVM.errorMessage)
        }
    }
    
    @ViewBuilder
    var roundedRectBG: some View {
        if addAmount {
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 3)
                .foregroundColor(accentColor)
                .frame(width: 77, height: 46)
        } else {
            accentColor
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
        if amount > 0 {
            homeVM.addProduct(webshopId: webshopId, amount: amount)
        }
        withAnimation {
            addAmount.toggle()
        }
        timer = nil
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProductDetailView(webshopId: 4117, currentPrice: 13.48, priceBeforeBonus: 17.98, isBonus: false)
                .toolbar(.hidden)
        }.environmentObject(dev.homeVM)
    }
}
