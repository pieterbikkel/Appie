//
//  ProductResponse.swift
//  Appie
//
//  Created by Pieter Bikkel on 04/07/2023.
//


import Foundation

// MARK: - ProductResponse
struct ProductResponse: Codable {
    let productID: Int?
    let productCard: ProductCard
    let tradeItem: TradeItem?
    let properties: Properties?
    let disclaimerText: String?
}

// MARK: - ProductCard
struct ProductCard: Codable {
    let webshopID, hqID: Int?
    let title, salesUnitSize: String?
    let images: [ProductImage]?
    let priceBeforeBonus, currentPrice: Double?
    let orderAvailabilityStatus, mainCategory, subCategory: String?
    let subCategoryID: Int?
    let brand, shopType: String?
    let availableOnline, isPreviouslyBought: Bool?
    let descriptionHighlights: String?
    let propertyIcons: [String]?
    let properties: Properties?
    let nix18, isStapelBonus: Bool?
    let extraDescriptions: [String]?
    let isBonus: Bool?
    let descriptionFull: String?
    let isOrderable, isInfiniteBonus, isSample, isVirtualBundle: Bool?
    let isFavorite: Bool?
}

// MARK: - Properties
struct Properties: Codable {
    let additionalProp1, additionalProp2, additionalProp3: [String]?
}

// MARK: - TradeItem
struct TradeItem: Codable {
    let gln, gtin: String?
    let additionalTradeItemIdentification: [String]?
    let allergenInformation: [AllergenInformation]?
    let certificationInformation: [String]?
    let consumerInstructions: ConsumerInstructions?
    let foodAndBeverageIngredientStatement: String?
    let foodAndBeveragePreparationServing: FoodAndBeveragePreparationServing?
    let gdsnClassification: GdsnClassification?
    let healthRelatedInformation: HealthRelatedInformation?
    let healthWellnessPackagingMarking: HealthWellnessPackagingMarking?
    let marketingInformationModule: MarketingInformationModule?
    let nutritionalInformation: NutritionalInformation?
    let packagingMarking: PackagingMarking?
    let placeOfItemActivity: PlaceOfItemActivity?
    let referencedFileDetailInformation, regulatoryInformation, safetyDataSheetInformation: [String]?
    let contactInformation: [ContactInformation]?
    let description: Description?
    let lifespan: Lifespan?
    let measurements: Measurements?
}

// MARK: - AllergenInformation
struct AllergenInformation: Codable {
    let items: [Item]?
    let statement: String?
}

// MARK: - Item
struct Item: Codable {
    let typeCode, levelOfContainmentCode: ContactTypeCode?
}

// MARK: - ContactTypeCode
struct ContactTypeCode: Codable {
    let value, label: String?
}

// MARK: - ConsumerInstructions
struct ConsumerInstructions: Codable {
    let storageInstructions, usageInstructions: [String]?
    let bacteriaWarningLogoPoultry: Bool?
}

// MARK: - ContactInformation
struct ContactInformation: Codable {
    let contactAddress, contactName: String?
    let targetMarketCommunicationChannel: [TargetMarketCommunicationChannel]?
    let contactTypeCode: ContactTypeCode?
}

// MARK: - TargetMarketCommunicationChannel
struct TargetMarketCommunicationChannel: Codable {
    let communicationChannel: [CommunicationChannel]?
}

// MARK: - CommunicationChannel
struct CommunicationChannel: Codable {
    let code: ContactTypeCode?
    let value: String?
}

// MARK: - Description
struct Description: Codable {
    let regulatedProductName: [String]?
}

// MARK: - FoodAndBeveragePreparationServing
struct FoodAndBeveragePreparationServing: Codable {
    let preparationServing: [String]?
    let servingQuantityInformation: ServingQuantityInformation?
}

// MARK: - ServingQuantityInformation
struct ServingQuantityInformation: Codable {
    let numberOfServingsPerPackage: Int?
}

// MARK: - GdsnClassification
struct GdsnClassification: Codable {
    let additionalTradeItemClassification: [AdditionalTradeItemClassification]?
}

// MARK: - AdditionalTradeItemClassification
struct AdditionalTradeItemClassification: Codable {
    let additionalTradeItemClassificationSystemCode: ContactTypeCode?
}

// MARK: - HealthRelatedInformation
struct HealthRelatedInformation: Codable {
    let compulsoryAdditiveLabelInformation, healthClaimDescription: [String]?
}

// MARK: - HealthWellnessPackagingMarking
struct HealthWellnessPackagingMarking: Codable {
    let packagingMarkedDietAllergenCode, packagingMarkedFreeFromCode: [String]?
}

// MARK: - Lifespan
struct Lifespan: Codable {
    let itemPeriodSafeToUseAfterOpening: [String]?
}

// MARK: - MarketingInformationModule
struct MarketingInformationModule: Codable {
    let tradeItemFeatureBenefit: [String]?
    let tradeItemMarketingMessage: String?
}

// MARK: - Measurements
struct Measurements: Codable {
    let netContent: [NetContent]?
    let weight: Weight?
}

// MARK: - NetContent
struct NetContent: Codable {
    let value: Int?
    let measurementUnitCode: ContactTypeCode?
}

// MARK: - Weight
struct Weight: Codable {
}

// MARK: - NutritionalInformation
struct NutritionalInformation: Codable {
    let nutrientHeaders: [NutrientHeader]?
    let nutritionalClaim: [String]?
}

// MARK: - NutrientHeader
struct NutrientHeader: Codable {
    let dailyValueIntakeReference: [String]?
    let nutrientBasisQuantity: NetContent?
    let nutrientBasisQuantityDescription: [String]?
    let nutrientDetail: [NutrientDetail]?
    let preparationStateCode: ContactTypeCode?
}

// MARK: - NutrientDetail
struct NutrientDetail: Codable {
    let measurementPrecisionCode: ContactTypeCode?
    let nutrientSource: [String]?
    let nutrientTypeCode: ContactTypeCode?
    let quantityContained: [NetContent]?
}

// MARK: - PackagingMarking
struct PackagingMarking: Codable {
    let localPackagingMarkedLabelAccreditationCodeReference: [ContactTypeCode]?
    let labelAccreditationCode: [String]?
}

// MARK: - PlaceOfItemActivity
struct PlaceOfItemActivity: Codable {
    let placeOfProductActivity: PlaceOfProductActivity?
}

// MARK: - PlaceOfProductActivity
struct PlaceOfProductActivity: Codable {
    let productActivityDetails, provenanceStatement: [String]?
}
