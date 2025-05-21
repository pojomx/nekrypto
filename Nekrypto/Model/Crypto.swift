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
    
    var formattedPrice: String {
        return currentPrice.formatted(.currency(code: "USD"))
    }
    
    var safeImageURL: URL? {
        print("Safe image URL \(id): \(image)")
        return URL(string: image)
    }
    
    init(id: String, symbol: String, name: String, image: String, currentPrice: Decimal, marketCap: Decimal, lastUpdated: String) {
        self.id = id
        self.symbol = symbol
        self.name = name
        self.image = image
        self.currentPrice = currentPrice
        self.marketCap = marketCap
        self.lastUpdated = lastUpdated
    }
    
    init(data: GeckoCryptocurrency) {
        self.id = data.id
        self.symbol = data.symbol
        self.name = data.name
        self.image = data.image ?? ""
        self.currentPrice = data.currentPrice ?? 0
        self.marketCap = data.marketCap ?? 0
        self.lastUpdated = data.lastUpdated ?? ""
    }
}
