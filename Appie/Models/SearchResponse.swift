//
//  SearchProduct.swift
//  Appie
//
//  Created by Pieter Bikkel on 27/06/2023.
//

import Foundation

struct SearchResponse: Codable {
    let page: Page?
    var products: [Product]
//    let links: Links?
//    let filters: [Filter]?
//    let sortOn: [String]?
//    let configuration: Configuration?
//    let ads, taxonomyNodes: [String]?
}

// MARK: - Configuration
struct Configuration: Codable {
    let googleBanners: GoogleBanners?
}

// MARK: - GoogleBanners
struct GoogleBanners: Codable {
    let adUnitMainPath, adUnitSecondaryPath, customTemplateID, divGPTAd: String?

    enum CodingKeys: String, CodingKey {
        case adUnitMainPath, adUnitSecondaryPath
        case customTemplateID = "customTemplateId"
        case divGPTAd = "divGptAd"
    }
}

// MARK: - Filter
struct Filter: Codable {
    let id, label: String?
    let options: [Option]?
    let type: String?
    let booleanFilter: Bool?
}

// MARK: - Option
struct Option: Codable {
    let id, label: String?
    let count: Int?
    let display: Bool?
}

// MARK: - Links
struct Links: Codable {
    let first, current, next, last: Current?
}

// MARK: - Current
struct Current: Codable {
    let href: String?
}

// MARK: - Page
struct Page: Codable {
    let size, totalElements, totalPages, number: Int?
}

// MARK: - Product
struct Product: Codable {
    let webshopID, hqID: Int?
    let title, salesUnitSize, unitPriceDescription: String?
    let images: [ProductImage]?
    let bonusStartDate, bonusEndDate, discountType, segmentType: String?
    let promotionType, bonusMechanism: String?
    let currentPrice: Double?
    let priceBeforeBonus: Double?
    let orderAvailabilityStatus, mainCategory, subCategory, brand: String?
    let shopType: String?
    let availableOnline, isPreviouslyBought: Bool?
    let descriptionHighlights: String?
    let propertyIcons: [String]?
    let nix18, isStapelBonus: Bool?
    let extraDescriptions: [String]?
    let bonusSegmentID: Int?
    let bonusSegmentDescription: String?
    let isBonus, hasListPrice: Bool?
    let descriptionFull: String?
    let isOrderable, isInfiniteBonus, isSample, isBonusPrice: Bool?
    let isSponsored, isVirtualBundle: Bool?
    let productCount: Int?
    let multipleItemPromotion: Bool?
    let bonusPeriodDescription: String?
    let virtualBundleItems: [VirtualBundleItem]?

    enum CodingKeys: String, CodingKey {
        case webshopID = "webshopId"
        case hqID = "hqId"
        case title, salesUnitSize, unitPriceDescription, images, bonusStartDate, bonusEndDate, discountType, segmentType, promotionType, bonusMechanism, currentPrice, priceBeforeBonus, orderAvailabilityStatus, mainCategory, subCategory, brand, shopType, availableOnline, isPreviouslyBought, descriptionHighlights, propertyIcons, nix18, isStapelBonus, extraDescriptions
        case bonusSegmentID = "bonusSegmentId"
        case bonusSegmentDescription, isBonus, hasListPrice, descriptionFull, isOrderable, isInfiniteBonus, isSample, isBonusPrice, isSponsored, isVirtualBundle, productCount, multipleItemPromotion, bonusPeriodDescription, virtualBundleItems
    }
}

// MARK: - Image
struct ProductImage: Codable {
    let width, height: Int?
    let url: String?
}

// MARK: - VirtualBundleItem
struct VirtualBundleItem: Codable {
    let productID, quantity: Int?

    enum CodingKeys: String, CodingKey {
        case productID = "productId"
        case quantity
    }
}

