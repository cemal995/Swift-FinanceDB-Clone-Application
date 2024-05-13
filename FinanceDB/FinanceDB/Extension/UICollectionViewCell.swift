//
//  UICollectionViewCell.swift
//  FinanceDB
//
//  Created by Cemalhan Alptekin on 10.05.2024.
//

import UIKit

// MARK: - UICollectionViewCell Extension

extension UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
}
