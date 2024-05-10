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
        
        coinNameLabel.text = coin.name
        coinPriceLabel.text = coin.price
        coinSymbolLabel.text = coin.symbol
        coinChangeLabel.text = coin.change
        
    }
    
    private func setupConstraints() {
        
        coinPictureImageView.translatesAutoresizingMaskIntoConstraints = false
        coinPictureImageView.widthAnchor.constraint(equalToConstant: 350).isActive = true
        coinPictureImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
    }
    
    private func setupAppearance() {
        
        self.layer.cornerRadius = 10// Adjust as needed
        self.layer.masksToBounds = true
        //self.backgroundColor = UIColor.black
        self.layer.borderWidth = 3
        
        }
}
