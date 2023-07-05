//
//  HomeView.swift
//  Appie
//
//  Created by Pieter Bikkel on 27/06/2023.
//

import SwiftUI
import AlertToast

struct HomeView: View {
    @EnvironmentObject private var viewModel: HomeViewModel
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        NavigationStack {
            GeometryReader {
                let size = $0.size
                let safeArea = $0.safeAreaInsets
                
                HeaderView(size: size, safeArea: safeArea)
                    .ignoresSafeArea(.all, edges: .top)
                
                    .toast(isPresenting: Binding(projectedValue: $viewModel.error)) {
                        AlertToast(displayMode: .hud, type: .regular, title: viewModel.errorMessage)
                    }
            }
            .ignoresSafeArea(.keyboard)
            .background(Color.theme.white)
            .toolbar(.hidden)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView()
                .toolbar(.hidden)
        }.environmentObject(dev.homeVM)
    }
}
