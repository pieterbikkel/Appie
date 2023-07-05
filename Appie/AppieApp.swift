//
//  AppieApp.swift
//  Appie
//
//  Created by Pieter Bikkel on 27/06/2023.
//

import SwiftUI

@main
struct AppieApp: App {
    
    @StateObject private var homeVM = HomeViewModel()
    @StateObject private var shoppingVM = ShoppingCartViewModel()
    
    var body: some Scene {
        WindowGroup {
            Group {
                ContentView()
                    .preferredColorScheme(.light)
            }
            .environmentObject(homeVM)
            .environmentObject(shoppingVM)
        }
    }
}
