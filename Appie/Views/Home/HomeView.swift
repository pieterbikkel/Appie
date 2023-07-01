//
//  HomeView.swift
//  Appie
//
//  Created by Pieter Bikkel on 27/06/2023.
//

import SwiftUI
import AlertToast

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel = HomeViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            List() {
                ForEach(viewModel.products, id: \.webshopID) { product in
                    ProductListItem(product: product, viewModel: viewModel)
                }
            }.listStyle(.plain)
                .searchable(text: $searchText)
                .onChange(of: searchText) { value in
                    Task {
                        if !value.isEmpty && value.count > 1 {
                            viewModel.search(name: value)
                        } else {
                            viewModel.products.removeAll()
                        }
                    }
                }
                .navigationTitle("Appie")
        }
        .toast(isPresenting: Binding(projectedValue: $viewModel.error)) {
            AlertToast(displayMode: .hud, type: .regular, title: viewModel.errorMessage)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
