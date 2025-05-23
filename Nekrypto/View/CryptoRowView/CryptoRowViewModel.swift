//
//  CryptoRowViewModel.swift
//  Nekrypto
//
//  Created by Alan Milke on 23/05/25.
//
import Foundation
import Combine

@Observable
class CryptoRowViewModel {
    
    var picture: Data? = nil
    let crypto: Crypto
    
    init (crypto: Crypto) {
        self.crypto = crypto
        Task (priority: .utility) {
            await loadPicture()
        }
    }
    
    func loadPicture() async {
        do {
            picture = try await crypto.downloadPicture()
        } catch {
            print("Error downloading picture for \(crypto.symbol): \(error)")
        }
    }
    
}
