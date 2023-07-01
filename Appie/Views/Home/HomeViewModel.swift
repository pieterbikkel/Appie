//
//  HomeViewModel.swift
//  Appie
//
//  Created by Pieter Bikkel on 27/06/2023.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var searchText = ""
    @Published var errorMessage = ""
    @Published var error = false
    
    private var cancellable: AnyCancellable?
    private var cancellables = Set<AnyCancellable>()
    
    func search(name: String) {
        self.error = false
        self.errorMessage = ""
        
        guard let safeSearchTerm = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        NetworkManager.shared.getData(path: "/api/v1/search/\(safeSearchTerm)", type: SearchResponse.self) { result in
            switch result {
            case .success(let data):
                self.products = data.products
            case .failure(let error):
                print(error)
                self.error = true
                self.errorMessage = "We fucked up :/"
            }
        }
    }
    
    func addProduct(webshopId: Int, amount: Int) {
        self.error = false
        self.errorMessage = ""
        
        let listItem = ["webshopId": webshopId, "amount": amount]
        
        NetworkManager.shared.postData(path: "/api/v1/list", method: "POST", type: ListResponse.self, body: listItem) { result in
            switch result {
            case .success(_):
                self.error = true
                self.errorMessage = "Added!"
            case .failure(let error):
                print(error)
                self.error = true
                self.errorMessage = "We fucked up :/"
            }
        }
    }
}


