//
//  CryptoListViewModel.swift
//  Nekrypto
//
//  Created by Alan Milke on 20/05/25.
//
import Foundation
import SwiftUI
import SwiftData
import Combine

@Observable
class CryptoListViewModel {
    
    public var modelContext: ModelContext? = nil
    
    
    public var isLoading: Bool = false //Indicates if content is beign downloaded.
    public var errorMessage: String? = nil //Used to share error messages to the view.
    
    public var searchFilter: String = "" // String to filter with
    private var cryptoList: [Crypto] = [] // Array of Cryptos
    
    public var filteredCryptos: [Crypto] { // Array of Filtered Cryptos
        if searchFilter.isEmpty {
            return cryptoList
        } else {
            return cryptoList.filter {
                $0.name.lowercased().contains(searchFilter.lowercased()) || $0.symbol.lowercased().contains(searchFilter.lowercased()) //Interested in Coin Name and Coin Symbol
                
            }
        }
    }

    private var observers: [AnyCancellable] = []
    
    public func refreshList() {
        guard let modelContext = modelContext else { return }
        do {
            var descriptor = FetchDescriptor<Crypto>(
                sortBy: [SortDescriptor(\.currentPrice, order: .reverse)],
            )
            descriptor.fetchLimit = 20
            cryptoList = try modelContext.fetch(descriptor)
        } catch {
            print("Error fetching data: \(error)")
        }
        print(cryptoList.count)
    }
    
    public func fetchData() {
    
        self.isLoading = true
        
        GeckoService.shared.fetchData() //Pulls data from the service, around 100 crypto coins.
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { result in
                    self.isLoading = false
                    switch result {
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                        break
                    case .finished:
                        self.errorMessage = nil
                    }
                },
                receiveValue: { data in
                    data.forEach { cryptoData in
                        guard let modelContext = self.modelContext else { return }
                        
                        let crypto = Crypto(data:cryptoData)
                        self.addCrypto(crypto: crypto, context: modelContext)
                    }
                    self.refreshList()
                })
            .store(in: &observers)
    }
    
    func addCrypto(crypto: Crypto, context: ModelContext) {
        // Search if ID is already registered or not
        let crypto_id = crypto.id
        
        let descriptor = FetchDescriptor<Crypto>(predicate: #Predicate { $0.id == crypto_id })

        if let existing = try? context.fetch(descriptor), !existing.isEmpty {
            if let value = existing.first {
                value.updateValues(data: crypto)
            } else {
                print("Algo raro sucedió.")
            }
            return
        }
        // If it does not exist, add it new
        context.insert(crypto)
    }
    
    // Container Preview for MockData
    static func makeContainerPreview(container: ModelContainer, count: Int = 100) -> some View {
        let context = ModelContext(container)
        
        GeckoService.getMoackDataList(count: count)
        //GeckoService.getSingleMockData()
            .forEach { item in
            context.insert(Crypto(data: item))
        }

        return CryptoListView().modelContext(context)
    }
}
