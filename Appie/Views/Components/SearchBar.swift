//
//  SearchBar.swift
//  Appie
//
//  Created by Pieter Bikkel on 01/07/2023.
//

import SwiftUI

struct SearchBar: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ?
                    Color.theme.gray : Color.theme.black
                )
            
            TextField("Search", text: $searchText)
                .foregroundColor(Color.theme.black)
                .disableAutocorrection(true)
                .padding(.trailing, 30)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundColor(Color.theme.black)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                    ,alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.white)
                .shadow(
                    color: Color.theme.black.opacity(0.15),
                    radius: 10, x: 0, y: 0)
        )
        .padding()
    }
}

struct SearchBar_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationStack {
            SearchBar(searchText: .constant(""))
                .toolbar(.hidden)
        }.environmentObject(dev.homeVM)
    }
}
