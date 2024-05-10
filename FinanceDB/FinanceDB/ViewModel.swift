//
//  ViewModel.swift
//  FinanceDB
//
//  Created by Cemalhan Alptekin on 10.05.2024.
//

import Foundation
import FinanceAPI

protocol ViewModelProtocol {
    var delegate: ViewModelDelegate? { get set }
    var numberofItems: Int { get }
    func load()
    func coin(index: Int) -> Coin?
    
}

protocol ViewModelDelegate: AnyObject {
    func showLoadingView()
    func hideLoadingView()
    func reloadData()
}

final class ViewModel {
    
    private var coins = [Coin]()
    let service: FinanceServiceProtocol
    weak var delegate: ViewModelDelegate?
    
    init(service: FinanceServiceProtocol) {
        self.service = service
    }
    
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
}

extension ViewModel: ViewModelProtocol {
    
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
