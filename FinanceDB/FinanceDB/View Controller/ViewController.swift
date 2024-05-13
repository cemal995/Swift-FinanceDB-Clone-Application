//
//  ViewController.swift
//  FinanceDB
//
//  Created by Cemalhan Alptekin on 8.05.2024.
//

import UIKit

// MARK: - ViewController

/// View controller responsible for displaying a collection view of coin information.

class ViewController: UIViewController, LoadingShowable {
    
    // MARK: Properties
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: ViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    // MARK: View Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        viewModel.load()
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupCollectionView()
        setupSegmentedControl()
    }
    
    // MARK: Setup Methods
    
    /// Sets up the collection view.
    
    func setupCollectionView() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: CoinInformationCell.self)
        
    }
    
    /// Sets up the segmented control in the navigation bar.
    
    private func setupSegmentedControl() {
        
        let segmentedControl = UISegmentedControl(items: ["Price", "Market Cap", "24h Volume", "Change", "Listed At"])
        segmentedControl.selectedSegmentIndex = -1
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        navigationItem.titleView = segmentedControl
        
    }
    
    // MARK: Action Methods
    
    /// Handles the value changed event of the segmented control.
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        
        viewModel.applyFilterForSelectedSegment(sender.selectedSegmentIndex)
    }
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

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

// MARK: - UICollectionViewDelegateFlowLayout

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 350, height: 100)
        
    }
    
}

// MARK: - ViewModelDelegate

extension ViewController: ViewModelDelegate {
    
    func navigateToCoinDetail(at index: Int) {
        
        guard let coin = viewModel.coin(index: index),
              let sparklineValues = coin.sparkline else { print("Failed to retrieve coin or its properties")
            return
            
        }
        
        let sparklineFloatValues = sparklineValues.compactMap { Float($0) }
        
        let detailViewModel = CoinDetailViewModel(coin: coin, sparklineValues: sparklineFloatValues)
        
        navigateToCoinDetail(with: detailViewModel)
    }
    
    private func navigateToCoinDetail(with viewModel: CoinDetailViewModel) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        
        if let detailViewController = storyboard.instantiateViewController(withIdentifier: "CoinDetailViewController") as? CoinDetailViewController {
            
            detailViewController.viewModel = viewModel
            
            navigationController?.pushViewController(detailViewController, animated: true)
            
        } else {
            print("Failed to instantiate CoinDetailViewController from storyboard")
        }
        
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

