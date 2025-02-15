//
//  UICollectionView.swift
//  FinanceDB
//
//  Created by Cemalhan Alptekin on 10.05.2024.
//

import UIKit

// MARK: - UICollectionView Extension

extension UICollectionView {
    
    func register(cellType: UICollectionViewCell.Type) {
        register(cellType.nib, forCellWithReuseIdentifier: cellType.identifier)
    }
    
    func dequeCell<T: UICollectionViewCell>(cellType: T.Type, indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath) as? T else {
            fatalError("error")
        }
        return cell
    }
}
