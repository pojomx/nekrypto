//
//  GeckoService.swift
//  Nekrypto
//
//  Created by Alan Milke on 20/05/25.
//

import Foundation
import Combine

class GeckoService : ObservableObject {
    
    static let shared = GeckoService()
    
    private init () {
        // Private for the singleton
        // set-up? Gecko Service
    }
    
    let httpURLString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd"
    
    func fetchData() -> Future<[GeckoCryptocurrency], GeckoError> {
        
        return Future { promise in
            
            guard let url = URL(string: self.httpURLString) else {
                    promise(.failure(.invalidURL))
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    promise(.failure(.unexpected(error)))
                    return
                }
                
                guard let data = data else {
                    promise(.failure(.noData))
                    return
                }

                do {
                    let decodeData = try JSONDecoder().decode([GeckoCryptocurrency].self, from: data)
                    promise(.success(decodeData))
                } catch {
                    promise(.failure(.decodingError(error)))
                }
                
            }.resume()
        }
    }
}
