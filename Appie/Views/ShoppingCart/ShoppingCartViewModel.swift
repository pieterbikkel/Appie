//
//  ShoppingCartViewModel.swift
//  Appie
//
//  Created by Pieter Bikkel on 27/06/2023.
//

import Foundation
import Combine

class ShoppingCartViewModel: ObservableObject {
    @Published var listResponse: ListResponse = Constants.DefaultModels.listResponse
    @Published var errorMessage = ""
    @Published var error = false
    
    private var cancellable: AnyCancellable?
    private var cancellables = Set<AnyCancellable>()
    
    func getShoppingCartItems() {
        self.error = false
        self.errorMessage = ""
        
        NetworkManager.shared.getData(path: "/api/v1/list", type: ListResponse.self) { result in
            switch result {
            case .success(let data):
                self.listResponse = data
            case .failure(let error):
                print(error)
                self.error = true
                self.errorMessage = "We fucked up :/"
            }
        }
    }
    
    func deleteItems(webshopId: Int) {
        print("Make delete Request")        
        NetworkManager.shared.deleteData(path: "/api/v1/list/\(String(webshopId))", method: "DELETE", type: ListResponse.self) { result in
            switch result {
            case .success(let data):
                self.listResponse = data
            case .failure(let error):
                print(error)
                self.error = true
                self.errorMessage = "We fucked up :/"
            }
        }
    }
    
    func updateAmount(webshopId: Int, amount: Int) {
        self.error = false
        self.errorMessage = ""
        
        let newAmount = ["amount": amount]
        
        NetworkManager.shared.postData(path: "/api/v1/list/\(webshopId)", method: "PATCH", type: ListResponse.self, body: newAmount) { result in
            switch result {
            case .success(let data):
                self.error = true
                self.listResponse = data
                self.errorMessage = "Updated"                
            case .failure(let error):
                print(error)
                self.error = true
                self.errorMessage = "We fucked up :/"
            }
        }
    }
}
