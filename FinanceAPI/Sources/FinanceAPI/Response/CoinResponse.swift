//
//  CoinResponse.swift
//
//
//  Created by Cemalhan Alptekin on 8.05.2024.
//

import Foundation

// MARK: - Coin Response

/// Represents the response structure for fetching coin data from the API.

public struct CoinResponse: Decodable {
    
    public let data: DataClass
    
    private enum RootCodingKeys: String, CodingKey {
        case data
    }
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: RootCodingKeys.self)
        self.data = try container.decode(DataClass.self, forKey: .data)
        
    }
    
}


