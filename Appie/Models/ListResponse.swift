//
//  ListResponse.swift
//  Appie
//
//  Created by Pieter Bikkel on 29/06/2023.
//

import Foundation

// MARK: - ListResponse
struct ListResponse: Codable {
    let list: [ShoppingListItem]
    let total: Double?
    let totalBeforeBonus: Double?
    let bonusAmount: Double?
    let totalPerUser: [TotalPerUser]?
}

// MARK: - List
struct ShoppingListItem: Codable {
    let name: String?
    let priceBeforeBonus, currentPrice: Double?
    let webshopID, amount: Int?
    let images: [ProductImage]?
    let description: String?
    let amountPerUser: [AmountPerUser]?

    enum CodingKeys: String, CodingKey {
        case name
        case webshopID = "webshopId"
        case amount, priceBeforeBonus, currentPrice, images, description, amountPerUser
    }
}

// MARK: - AmountPerUser
struct AmountPerUser: Codable {
    let name: String?
    let amount: Int?
}

struct TotalPerUser: Codable {
    let name: String
    let total: Double
}
