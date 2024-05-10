//
//  ViewController.swift
//  FinanceDB
//
//  Created by Cemalhan Alptekin on 8.05.2024.
//

import UIKit

class ViewController: UIViewController, LoadingShowable {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: ViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.load()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    func setupCollectionView() {
 
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: CoinInformationCell.self)
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberofItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeCell(cellType: CoinInformationCell.self, indexPath: indexPath)
        if let coin = viewModel.coin(index: indexPath.row) {
            cell.configure(coin: coin)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           viewModel.didSelectCoin(at: indexPath.item)
       }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 100)
    }
    
}

extension ViewController: ViewModelDelegate {
    
    func navigateToCoinDetail(at index: Int) {
        
     guard let coin = viewModel.coin(index: index),
              let sparklineValues = coin.sparkline else { print("Failed to retrieve coin or its properties")
            return
        }
        
        if let symbol = coin.symbol {
               print("Coin symbol: \(symbol)")
           } else {
               print("Coin symbol is nil")
           }
           
           if let name = coin.name {
               print("Coin name: \(name)")
           } else {
               print("Coin name is nil")
           }
           
           if let price = coin.price {
               print("Coin price: \(price)")
           } else {
               print("Coin price is nil")
           }
           
           if let change = coin.change {
               print("Coin change: \(change)")
           } else {
               print("Coin change is nil")
           }
           
           print("Sparkline values: \(sparklineValues)")
        
        let sparklineFloatValues = sparklineValues.compactMap { Float($0) }
        
        let detailViewModel = CoinDetailViewModel(coin: coin, sparklineValues: sparklineFloatValues)
                navigateToCoinDetail(with: detailViewModel)
        
        
        /*let detailViewController = CoinDetailViewController()
        let detailViewModel = CoinDetailViewModel(coin: coin, sparklineValues: sparklineFloatValues)
        detailViewController.viewModel = detailViewModel
        
        navigationController?.pushViewController(detailViewController, animated: true)
        detailViewController.loadViewIfNeeded()*/

    }
    
    private func navigateToCoinDetail(with viewModel: CoinDetailViewModel) {
           let detailViewController = CoinDetailViewController()
           detailViewController.viewModel = viewModel
           navigationController?.pushViewController(detailViewController, animated: true)
        detailViewController.loadViewIfNeeded()
          
       }
    
    func didSelectCoin(at index: Int) {
        
        viewModel.didSelectCoin(at: index)
    }
    
    
    func showLoadingView() {
        showLoading()
    }
    
    func hideLoadingView() {
        hideLoading()
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    
}

