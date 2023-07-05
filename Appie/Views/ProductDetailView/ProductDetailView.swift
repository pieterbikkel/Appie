//
//  ProductDetailView.swift
//  Appie
//
//  Created by Pieter Bikkel on 04/07/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductDetailView: View {
    
    var product: ProductResponse
    
    var body: some View {
        GeometryReader { reader in
            WebImage(url: URL(string: product.productCard.images.last?.url ?? Constants.backupImage))
                .resizable()
                .frame(width: reader.size.width / 4, height: reader.size.width / 4)
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: Constants.DefaultModels.productResponse)
    }
}
