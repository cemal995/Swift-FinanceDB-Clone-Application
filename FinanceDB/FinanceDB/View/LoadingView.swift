//
//  LoadingView.swift
//  FinanceDB
//
//  Created by Cemalhan Alptekin on 10.05.2024.
//

import UIKit

class LoadingView {
    
    private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    static let shared = LoadingView()
    private var blurView: UIVisualEffectView = UIVisualEffectView()
    private var window: UIWindow?
    
    private init() {
        configure()
    }
    
    private func configure() {
        
        blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        blurView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.center = blurView.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        blurView.contentView.addSubview(activityIndicator)
    }
    
    static func startLoading() {
        
        guard !shared.activityIndicator.isAnimating else { return }
        
        if let windowScene = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first(where: { $0.activationState == .foregroundActive }) {
            
            shared.window = UIWindow(windowScene: windowScene)
            shared.window?.addSubview(shared.blurView)
            shared.window?.makeKeyAndVisible()
            
            shared.activityIndicator.startAnimating()
            
        }
    }
    
    func hideLoading() {
        
        blurView.removeFromSuperview()
        activityIndicator.stopAnimating()
        window = nil
        
    }
}


/* import Foundation
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
}*/
