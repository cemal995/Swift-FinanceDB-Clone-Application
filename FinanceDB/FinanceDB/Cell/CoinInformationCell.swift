//
//  CoinInformationCell.swift
//  FinanceDB
//
//  Created by Cemalhan Alptekin on 9.05.2024.
//

import UIKit
import FinanceAPI
import Kingfisher

class CoinInformationCell: UICollectionViewCell {
    
    @IBOutlet weak var coinPictureImageView: UIImageView!
    @IBOutlet weak var coinChangeLabel: UILabel!
    @IBOutlet weak var coinPriceLabel: UILabel!
    @IBOutlet weak var coinNameLabel: UILabel!
    @IBOutlet weak var coinSymbolLabel: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
        coinPictureImageView.contentMode = .scaleAspectFit
        setupConstraints()
        setupAppearance()
        
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        coinPictureImageView.image = nil
        
    }
    
    func configure(coin: Coin) {
        
        var imageUrlString = coin.iconUrl ?? ""
        imageUrlString = imageUrlString.replacingOccurrences(of: ".svg", with: ".png")
        
        if let url = URL(string: imageUrlString) {
            coinPictureImageView.kf.setImage(with: url)
        }
        
        if let price = coin.price, let priceDouble = Double(price) {
            
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .currency
            numberFormatter.currencySymbol = "$"
            numberFormatter.minimumFractionDigits = 2
            numberFormatter.maximumFractionDigits = 2
            numberFormatter.decimalSeparator = "."
            numberFormatter.groupingSeparator = ","
            
            if let formattedPrice = numberFormatter.string(from: NSNumber(value: priceDouble)) {
                       coinPriceLabel.text = formattedPrice
                   } else {
                       coinPriceLabel.text = "$0.00"
                   }
               } else {
                   coinPriceLabel.text = "$0.00"
               }
        
        if let change = coin.change, !change.isEmpty {
            let floatValue = (change as NSString).floatValue
            let sign = floatValue >= 0 ? "+" : ""
            coinChangeLabel.text = "\(sign)\(change)"
            coinChangeLabel.textColor = floatValue >= 0 ? UIColor.green : UIColor.red
        } else {
            coinChangeLabel.text = nil
        }
        
        coinNameLabel.text = coin.name
        coinSymbolLabel.text = coin.symbol
    }
    
    private func setupConstraints() {
        
        coinPictureImageView.translatesAutoresizingMaskIntoConstraints = false
        coinPictureImageView.widthAnchor.constraint(equalToConstant: 350).isActive = true
        coinPictureImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
    }
    
    private func setupAppearance() {
        
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.layer.borderWidth = 3
        
    }
}
