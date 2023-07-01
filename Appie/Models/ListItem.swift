//
//  ListItem.swift
//  Appie
//
//  Created by Pieter Bikkel on 29/06/2023.
//

import Foundation

struct ListItem: Codable {
    // Model
    /*
     {
       "webshopId": 386832,
       "amount": 2
     }
     */
    var webshopId: Int
    var amount: Int
}
