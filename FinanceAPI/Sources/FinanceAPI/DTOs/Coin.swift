//
//  Coin.swift
//
//
//  Created by Cemalhan Alptekin on 8.05.2024.
//

// MARK: - CoinResponse

public struct CoinResults: Decodable {
    
    public let status: String?
    public let data: DataClass?
    
}

// MARK: - DataClass,

public struct DataClass: Decodable {
    
    public let stats: Stats?
    public let coins: [Coin]?
    
}

// MARK: - Stats

public struct Stats: Decodable {
    
    public let total, totalCoins, totalMarkets, totalExchanges: Int?
    public let totalMarketCap, total24hVolume: String?
    
}

// MARK: - Coin

public struct Coin: Decodable {
    
    public let uuid, symbol, name: String?
    public let color: String?
    public let iconUrl: String?
    public let marketCap, price: String?
    public let listedAt, tier: Int?
    public let change: String?
    public let rank: Int?
    public let sparkline: [String]?
    public let lowVolume: Bool?
    public let coinrankingUrl: String?
    public let the24hVolume, btcPrice: String?

    private enum CodingKeys: String, CodingKey {
        case uuid, symbol, name, color
        case iconUrl = "iconUrl"
        case marketCap, price, listedAt, tier, change, rank, sparkline, lowVolume
        case coinrankingUrl = "coinrankingUrl"
        case the24hVolume = "24hVolume"
        case btcPrice
    }
}
