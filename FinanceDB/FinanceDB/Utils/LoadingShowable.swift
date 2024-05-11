//
//  LoadingShowable.swift
//  FinanceDB
//
//  Created by Cemalhan Alptekin on 10.05.2024.
//

import Foundation
import UIKit

protocol LoadingShowable where Self: UIViewController {
    func showLoading()
    func hideLoading()
}

extension LoadingShowable {
    
    func showLoading() {
        
        LoadingView.startLoading()
    }
    
    func hideLoading() {
        
        LoadingView.shared.hideLoading()
        
    }
    
}
