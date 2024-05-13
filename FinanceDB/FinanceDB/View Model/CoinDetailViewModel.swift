//
//  CoinDetailViewModel.swift
//  FinanceDB
//
//  Created by Cemalhan Alptekin on 10.05.2024.
//

import Foundation
import FinanceAPI

enum LabelColor {
    case red
    case green
    case black
}

class CoinDetailViewModel {
    
    var coin: Coin
    let sparklineValues: [Float]
    
    var imageURL: String? {
        
           return coin.iconUrl
       }
    
    var formattedCoinPrice: String {
        
        guard let price = Double(coin.price ?? "") else {
                  return "N/A"
              }
        return formatPrice(Float(price))
   
        }
    
    var formattedChange: String {
            guard let change = coin.change, let changeDouble = Double(change) else {
                return "N/A"
            }
            
            let formattedChange = String(format: "%.2f", changeDouble)
            
            if changeDouble > 0 {
                return "+\(formattedChange)%"
            } else if changeDouble < 0 {
                return "\(formattedChange)%"
            } else {
                return "\(formattedChange)%"
            }
        }
    
    var formattedHighestPrice: String {
        let highestPrice = self.highestPrice
        return formatPrice(highestPrice)
    }
    
    var formattedLowestPrice: String {
        let lowestPrice = self.lowestPrice
        return formatPrice(lowestPrice)
    }
    
    var highestPriceLabelColor: LabelColor {
        return .green
    }
    
    var lowestPriceLabelColor: LabelColor {
        return .red
    }
    
    var changeLabelColor: LabelColor {
        
            guard let change = coin.change, let changeDouble = Double(change) else {
                return .black
            }
            
            return changeDouble > 0 ? .green : changeDouble < 0 ? .red : .black
        }
        
        var highestPrice: Float {
            return sparklineValues.max() ?? 0
        }
        
        var lowestPrice: Float {
            return sparklineValues.min() ?? 0
        }
    
    private func formatPrice(_ price: Float) -> String {
        
        let formatter = NumberFormatter()
             formatter.numberStyle = .decimal
             formatter.maximumFractionDigits = 2
             formatter.minimumFractionDigits = 2
             
             if let formattedPrice = formatter.string(from: NSNumber(value: price)) {
                 return "\(formattedPrice)"
             } else {
                 return "N/A"
             }
      }
        
        init(coin: Coin, sparklineValues: [Float]) {
            self.coin = coin
            self.sparklineValues = sparklineValues
        }
    
}
