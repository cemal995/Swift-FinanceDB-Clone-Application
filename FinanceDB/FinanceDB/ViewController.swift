//
//  ViewController.swift
//  FinanceDB
//
//  Created by Cemalhan Alptekin on 8.05.2024.
//

import UIKit
import FinanceAPI

class ViewController: UIViewController, LoadingShowable {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let service: FinanceServiceProtocol = FinanceService()
    var coins = [Coin]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCoins()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    fileprivate func fetchCoins() {
        showLoading()
        service.fetchCoinInformation { [weak self] response in
            
            guard let self else {return}
            
            switch response {
            case .success(let coins):
                hideLoading()
                DispatchQueue.main.async {
                    self.coins = coins
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print("Error:\(error.localizedDescription)")
            }
        }
    }
    
    func setupCollectionView() {
 
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: CoinInformationCell.self)
        //collectionView.register(UINib(nibName: "CoinInformationCell", bundle: nil), forCellWithReuseIdentifier: "CoinInformationCell")
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        coins.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeCell(cellType: CoinInformationCell.self, indexPath: indexPath)
        cell.configure(coin: coins[indexPath.item])
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 100)
    }
}


