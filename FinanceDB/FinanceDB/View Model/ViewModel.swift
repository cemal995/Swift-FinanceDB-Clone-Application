//
//  ViewModel.swift
//  FinanceDB
//
//  Created by Cemalhan Alptekin on 10.05.2024.
//

import Foundation
import FinanceAPI

// MARK: - FilterOption

/// Enum representing various filter options for sorting coins.

enum FilterOption {
    
    case price
    case marketCap
    case volume24h
    case change
    case listedAt
    
}

// MARK: - ViewModelProtocol

/// Protocol defining methods and properties for the view model.

protocol ViewModelProtocol {
    
    var delegate: ViewModelDelegate? { get set }
    var numberofItems: Int { get }
    func load()
    func coin(index: Int) -> Coin?
    func didSelectCoin(at index: Int)
    func applyFilter(_ filter: FilterOption)
    func applyFilterForSelectedSegment(_ selectedIndex: Int)
    
}

// MARK: - ViewModelDelegate

/// Protocol defining methods for view model delegate.

protocol ViewModelDelegate: AnyObject {
    
    func showLoadingView()
    func hideLoadingView()
    func reloadData()
    func didSelectCoin(at index: Int)
    func navigateToCoinDetail(at index: Int)
    
}

// MARK: - ViewModel

/// View model for handling coin data and interactions.

final class ViewModel {
    
    // MARK: Properties
    
    private var coins = [Coin]()
    let service: FinanceServiceProtocol
    weak var delegate: ViewModelDelegate?
    
    // MARK: Initialization
        
    /// Initializes a new instance of `ViewModel`.
    
    init(service: FinanceServiceProtocol) {
        self.service = service
    }
    
// MARK: Private Methods
    
    fileprivate func fetchCoins() {
        
        self.delegate?.showLoadingView()
        service.fetchCoinInformation { [weak self] response in
            
            guard let self else {return}
            switch response {
            case .success(let coins):
                self.delegate?.hideLoadingView()
                DispatchQueue.main.async {
                    self.coins = coins
                    self.delegate?.reloadData()
                }
                
            case .failure(let error):
                print("Error:\(error.localizedDescription)")
                
            }
        }
    }
    
// MARK: Public Methods
    
    /// Applies a filter to the list of coins based on the selected option.
    /// - Parameter filter: The filter option to apply.
    
    func applyFilterForSelectedSegment(_ selectedIndex: Int) {
        
        var filterOption: FilterOption
        
        switch selectedIndex {
        case 0:
            filterOption = .price
        case 1:
            filterOption = .marketCap
        case 2:
            filterOption = .volume24h
        case 3:
            filterOption = .change
        case 4:
            filterOption = .listedAt
        default:
            return
        }
        
        applyFilter(filterOption)
        
    }
}

// MARK: - ViewModelProtocol Extension

extension ViewModel: ViewModelProtocol {
    
    func applyFilter(_ filter: FilterOption) {
        
        switch filter {
            
        case .price:
            
            coins.sort { (coin1: Coin, coin2: Coin) -> Bool in
                guard let price1 = Double(coin1.price ?? ""),
                      let price2 = Double(coin2.price ?? "") else {
                    return false
                }
                return price1 > price2
            }
            
        case .marketCap:
            
            coins.sort { (coin1: Coin, coin2: Coin) -> Bool in
                guard let marketCap1 = coin1.marketCap,
                      let marketCap2 = coin2.marketCap else {
                    return false
                }
                return marketCap1 > marketCap2
            }
            
        case .volume24h:
            
            coins.sort { (coin1: Coin, coin2: Coin) -> Bool in
                guard let volume24h1 = Double(coin1.the24hVolume ?? ""),
                      let volume24h2 = Double(coin2.the24hVolume ?? "") else {
                    return false
                }
                return volume24h1 > volume24h2
            }
            
        case .change:
            
            coins.sort { (coin1: Coin, coin2: Coin) -> Bool in
                guard let change1 = Float(coin1.change ?? ""),
                      let change2 = Float(coin2.change ?? "") else {
                    return false
                }
                return change1 > change2
            }
            
        case .listedAt:
            
            coins.sort { (coin1: Coin, coin2: Coin) -> Bool in
                guard let listedAt1 = coin1.listedAt,
                      let listedAt2 = coin2.listedAt else {
                    return false
                }
                return listedAt1 > listedAt2
            }
        }
        
        delegate?.reloadData()
    }
    
    func didSelectCoin(at index: Int) {
        
        delegate?.navigateToCoinDetail(at: index)
        
    }
    
    var numberofItems: Int {
        
        coins.count
        
    }
    
    func load() {
        
        fetchCoins()
        
    }
    
    func coin(index: Int) -> FinanceAPI.Coin? {
        
        coins[index]
        
    }
    
}
