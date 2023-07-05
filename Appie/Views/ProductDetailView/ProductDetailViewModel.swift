//
//  ProductDetailViewModel.swift
//  Appie
//
//  Created by Pieter Bikkel on 05/07/2023.
//

import Foundation
import Combine

class ProductDetailViewModel: ObservableObject {
    @Published var product: ProductResponse = Constants.DefaultModels.productResponse
    @Published var error: Bool = false
    @Published var errorMessage: String = ""
    
    func getProduct(webshopId: Int) {
        self.error = false
        self.errorMessage = ""
        
        NetworkManager.shared.getData(path: "/api/v1/product/\(webshopId)", type: ProductResponse.self) { result in
            switch result {
            case .success(let data):
                self.product = data
            case .failure(let error):
                print(error)
                self.error = true
                self.errorMessage = "We fucked up :/"
            }
        }
    }
}
