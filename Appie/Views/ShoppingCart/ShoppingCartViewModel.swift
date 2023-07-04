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
                print(data)
                self.listResponse = data
            case .failure(let error):
                print(error)
                self.error = true
                self.errorMessage = "We fucked up :/"
            }
        }
    }
    
    func deleteItems(at indices: IndexSet) {
        print("Make delete Request")
        let deletedItemIDs: [Int] = indices.compactMap { index in
            guard listResponse.list.indices.contains(index) else { return 0 }
            return listResponse.list[index].webshopID
        }.map { $0! }
        NetworkManager.shared.deleteData(path: "/api/v1/list/\(String(describing: deletedItemIDs.first!))", method: "DELETE", type: ListResponse.self) { result in
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
}
