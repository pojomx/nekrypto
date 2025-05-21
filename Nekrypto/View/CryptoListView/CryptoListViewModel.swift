//
//  CryptoListViewModel.swift
//  Nekrypto
//
//  Created by Alan Milke on 20/05/25.
//
import Foundation
import SwiftUI
import SwiftData

@Observable
class CryptoListViewModel {
                           
    public var cryptoList: [Crypto] = []
    
    public func refreshList(modelContext: ModelContext) {
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
