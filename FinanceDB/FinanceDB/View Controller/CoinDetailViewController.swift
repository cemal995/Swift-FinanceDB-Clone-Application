//
//  CoinDetailViewController.swift
//  FinanceDB
//
//  Created by Cemalhan Alptekin on 10.05.2024.
//

import UIKit
import Kingfisher

class CoinDetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var coinSymbolLabel: UILabel!
    @IBOutlet weak var coinNameLabel: UILabel!
    @IBOutlet weak var currentPriceLabel: UILabel!
    @IBOutlet weak var coinPriceLabel: UILabel!
    @IBOutlet weak var coinHighestPriceLabel: UILabel!
    @IBOutlet weak var coinChangeLabel: UILabel!
    @IBOutlet weak var coinLowestPriceLabel: UILabel!
    @IBOutlet weak var coinPictureImageView: UIImageView!
    @IBOutlet weak var SparklineGraphView: SparklineGraphView!
    
    // MARK: - Properties
    
    var viewModel: CoinDetailViewModel!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureUI()
        
    }
    
    // MARK: - UI Configuration
    
    func configureUI() {
        
        guard let viewModel = viewModel else {
            return
        }
        
        coinSymbolLabel.text = viewModel.coin.symbol
        coinNameLabel.text = viewModel.coin.name
        currentPriceLabel.text = "CURRENT PRICE"
        coinPriceLabel.text = viewModel.formattedCoinPrice
        coinChangeLabel.text = viewModel.formattedChange
        coinHighestPriceLabel.text = "High: \(viewModel.formattedHighestPrice)"
        coinLowestPriceLabel.text = "Low: \(viewModel.formattedLowestPrice)"
        
        switch viewModel.changeLabelColor {
            
        case .red:
            coinChangeLabel.textColor = .red
            coinLowestPriceLabel.textColor = .red
            coinHighestPriceLabel.textColor = .green
        case .green:
            coinChangeLabel.textColor = .green
            coinLowestPriceLabel.textColor = .red
            coinHighestPriceLabel.textColor = .green
        case .black:
            coinChangeLabel.textColor = .black
            coinLowestPriceLabel.textColor = .red
            coinHighestPriceLabel.textColor = .green
        }
        
        SparklineGraphView.sparklineValues = viewModel.sparklineValues
        
    }

}
