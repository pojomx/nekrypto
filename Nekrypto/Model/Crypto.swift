//
//  Crypto.swift
//  Nekrypto
//
//  Created by Alan Milke on 20/05/25.
//

import Foundation
import SwiftData

@Model
final class Crypto {
    var id: String
    var symbol: String
    var name: String
    var image: String
    var currentPrice: Decimal
    var marketCap: Decimal
    var lastUpdated: String
    
    var totalVolume: Decimal
    var highestPrice: Decimal
    var lowestPrice: Decimal
    var priceChange24h: Decimal
    
    @Attribute(.externalStorage)
    var picture: Data?
    
    var formattedPrice: String {
        return currentPrice.formatted(.currency(code: "USD"))
    }
    
    var formattedHigh: String {
        return highestPrice.formatted(.currency(code: "USD"))
    }
    
    var formattedLow: String {
        return lowestPrice.formatted(.currency(code: "USD"))
    }
    
    
    var safeImageURL: URL? {
        print("Safe image URL \(id): \(image)")
        return URL(string: image)
    }
    
    init(id: String, symbol: String, name: String, image: String, currentPrice: Decimal, marketCap: Decimal, lastUpdated: String, totalVolume: Decimal, highestPrice: Decimal, lowestPrice: Decimal, priceChange24h: Decimal) {
        self.id = id
        self.symbol = symbol
        self.name = name
        self.image = image
        self.currentPrice = currentPrice
        self.marketCap = marketCap
        self.lastUpdated = lastUpdated
        self.totalVolume = totalVolume
        self.highestPrice = highestPrice
        self.lowestPrice = lowestPrice
        self.priceChange24h = priceChange24h
    }
    
    init(data: GeckoCryptocurrency) {
        self.id = data.id
        self.symbol = data.symbol
        self.name = data.name
        self.image = data.image ?? ""
        self.currentPrice = data.currentPrice ?? 0
        self.marketCap = data.marketCap ?? 0
        self.lastUpdated = data.lastUpdated ?? ""
        self.totalVolume = data.totalVolume ?? 0
        self.highestPrice = data.high24h ?? 0
        self.lowestPrice = data.low24h ?? 0
        self.priceChange24h = data.priceChange24h ?? 0
    }
    
    func updateValues(data: Crypto) {
        // The ID wont ever change, the name and symbol is less prone to change, but could happen...
        //self.id = data.id
        self.symbol = data.symbol
        self.name = data.name
        self.image = data.image
        self.currentPrice = data.currentPrice
        self.marketCap = data.marketCap
        self.lastUpdated = data.lastUpdated
        self.totalVolume = data.totalVolume
        self.highestPrice = data.highestPrice
        self.lowestPrice = data.lowestPrice
        self.priceChange24h = data.priceChange24h
    }
}

extension Crypto: Hashable {
    static func == (lhs: Crypto, rhs: Crypto) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

