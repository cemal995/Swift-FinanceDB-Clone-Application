//
//  CoinDetailViewModel.swift
//  FinanceDB
//
//  Created by Cemalhan Alptekin on 10.05.2024.
//

import Foundation
import FinanceAPI

class CoinDetailViewModel {
    
    var coin: Coin
    let sparklineValues: [Float]
        
        var highestPrice: Float {
            return sparklineValues.max() ?? 0
        }
        
        var lowestPrice: Float {
            return sparklineValues.min() ?? 0
        }
        
        init(coin: Coin, sparklineValues: [Float]) {
            self.coin = coin
            self.sparklineValues = sparklineValues
        }
    
}
