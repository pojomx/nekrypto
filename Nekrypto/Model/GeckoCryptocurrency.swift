//
//  GeckoCryptocurrency.swift
//  Nekrypto
//
//  Created by Alan Milke on 20/05/25.
//
import Foundation

struct GeckoCryptocurrency : Decodable {
    
    let id: String
    let symbol: String
    let name: String
    let image: String?
    let currentPrice: Decimal?
    let marketCap: Decimal?
    let marketCapRank: Int?
    let fullyDilutedValuation: Decimal?
    let totalVolume: Decimal?
    let high24h: Decimal?
    let low24h: Decimal?
    let priceChange24h: Decimal?
    let priceChangePercentage24h: Decimal?
    let marketCapChange24h: Decimal?
    let marketCapChangePercentage24h: Decimal?
    let circulatingSupply: Decimal?
    let totalSupply: Decimal?
    let maxSupply: Decimal?
    let ath: Decimal?
    let athChangePercentage: Decimal?
    let athDate: String?
    let atl: Decimal?
    let atlChangePercentage: Decimal?
    let atlDate: String?
    let roi: GeckoRoi?
    let lastUpdated: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case name
        case image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24h = "high_24h"
        case low24h = "low_24h"
        case priceChange24h = "price_change_24h"
        case priceChangePercentage24h = "price_change_percentage_24h"
        case marketCapChange24h = "market_cap_change_24h"
        case marketCapChangePercentage24h = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl = "atl"
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case roi
        case lastUpdated = "last_updated"
    }
}
