//
//  File.swift
//  
//
//  Created by Cemalhan Alptekin on 8.05.2024.
//

import Foundation

public enum Decoders {
    
    static let dateDecoder: JSONDecoder = {
        
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
        
    }()
    
}
