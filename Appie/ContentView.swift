//
//  ContentView.swift
//  Appie
//
//  Created by Pieter Bikkel on 27/06/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selection = 0
    
    var body: some View {
        ZStack {
            Color.theme.white
            
            TabView(selection: $selection) {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .tag(0)
                BonusView()
                    .tabItem {
                        Label("Bonus", systemImage: "tag")
                    }.tag(1)
                
                ShoppingCartView()
                    .tabItem {
                        Label("Boodschappen", systemImage: "cart")
                    }.tag(2)
            }
            .accentColor(selection == 1 ? Color.theme.orange : Color.theme.blue)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
