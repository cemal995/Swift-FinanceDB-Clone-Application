//
//  FinanceService.swift
//
//
//  Created by Cemalhan Alptekin on 8.05.2024.
//

import Foundation
import Alamofire

public protocol FinanceServiceProtocol {
    func fetchCoinInformation(completion: @escaping (Result<[Coin], Error>) -> Void)
}

public class FinanceService: FinanceServiceProtocol {

    public init() {}

    public func fetchCoinInformation(completion: @escaping (Result<[Coin], Error>) -> Void) {
        let urlString = "https://psp-merchantpanel-service-sandbox.ozanodeme.com.tr/api/v1/dummy/coins"

        AF.request(urlString).responseData { response in
            switch response.result {
            case .success(let data):
                
                let decoder = JSONDecoder()

                do {
                    let coinResponse = try decoder.decode(CoinResponse.self, from: data)
                    
                    if let coins = coinResponse.data.coins {
                                        completion(.success(coins))
                                    } else {
                                        completion(.success([]))
                                    }
                } catch {
                    print("*********** JSON DECODE ERROR ********")
                    print(error)
                    completion(.failure(error))
                }

            case .failure(let error):
                print("********* Please try again later *********")
                completion(.failure(error))
            }
        }
    }
}

