//
//  LoadingView.swift
//  FinanceDB
//
//  Created by Cemalhan Alptekin on 10.05.2024.
//

import Foundation
import UIKit

class LoadingView {
    
    var activityIndictor: UIActivityIndicatorView = UIActivityIndicatorView()
    static let shared = LoadingView()
    var blurView: UIVisualEffectView = UIVisualEffectView()
    
    private init() {
        configure()
    }
    
    func configure() {
        
        blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.frame = UIWindow(frame: UIScreen.main.bounds).frame
        activityIndictor.center = blurView.center
        activityIndictor.hidesWhenStopped = true
        activityIndictor.style = .large
        blurView.contentView.addSubview(activityIndictor)
    }
    
    func startLoading() {
        UIApplication.shared.windows.first?.addSubview(blurView)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        activityIndictor.startAnimating()
    }
    
    func hideLoading() {
        blurView.removeFromSuperview()
        activityIndictor.stopAnimating()
    }
}
