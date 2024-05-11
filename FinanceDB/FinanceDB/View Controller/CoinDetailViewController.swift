//
//  CoinDetailViewController.swift
//  FinanceDB
//
//  Created by Cemalhan Alptekin on 10.05.2024.
//

import UIKit

class CoinDetailViewController: UIViewController {
    
    @IBOutlet weak var coinSymbolLabel: UILabel!
    @IBOutlet weak var coinNameLabel: UILabel!
    @IBOutlet weak var currentPriceLabel: UILabel!
    @IBOutlet weak var coinPriceLabel: UILabel!
    @IBOutlet weak var coinHighestPriceLabel: UILabel!
    @IBOutlet weak var coinChangeLabel: UILabel!
    @IBOutlet weak var coinLowestPriceLabel: UILabel!
    
    var viewModel: CoinDetailViewModel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureUI()
        
    }
    
    func configureUI() {
        
        guard let viewModel = viewModel else {
            return
        }
        
        coinSymbolLabel.text = viewModel.coin.symbol
        coinNameLabel.text = viewModel.coin.name
        currentPriceLabel.text = "CURRENT PRICE"
        coinPriceLabel.text = viewModel.coin.price
        coinChangeLabel.text = viewModel.coin.change
        coinHighestPriceLabel.text = "\(viewModel.highestPrice)"
        coinLowestPriceLabel.text = "\(viewModel.lowestPrice)"
    }

}
