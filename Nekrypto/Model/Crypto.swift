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
    var currentPrice: Double
    var marketCap: Double
    
    init(id: String, symbol: String, name: String, image: String, currentPrice: Double, marketCap: Double) {
        self.id = id
        self.symbol = symbol
        self.name = name
        self.image = image
        self.currentPrice = currentPrice
        self.marketCap = marketCap
    }
    
    init(data: GeckoCryptocurrency) {
        self.id = data.id
        self.symbol = data.symbol
        self.name = data.name
        self.image = data.image
        self.currentPrice = data.currentPrice
        self.marketCap = data.marketCap
    }
}
