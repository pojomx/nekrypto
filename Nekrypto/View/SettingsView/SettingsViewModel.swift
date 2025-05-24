//
//  SettingsViewModel.swift
//  Nekrypto
//
//  Created by Alan Milke on 23/05/25.
//

import Foundation
import SwiftData
import SwiftUI
import Combine

@Observable
class SettingsViewModel : ObservableObject {
    
    //This is the Passtrough Subject that will notify the others to refresh after deleting.
    let didRequestRefresh = PassthroughSubject<Void, Never>()
    
    public var modelContext: ModelContext? = nil
    public var showDeleteConfirmationDialog = false
    public var errorMessage: String? = nil
    
    private var cryptoList: [Crypto] = []
    
    public func itemsInTheList() -> Int {
        return cryptoList.count
    }
    
    public func refreshList() {
        guard let modelContext = modelContext else { return }
        do {
            cryptoList = try modelContext.fetch(FetchDescriptor<Crypto>())
        } catch {
            print("Error fetching data: \(error)")
        }
    }
    
    func deleteAllRecords(modelContext: ModelContext) {
        do {
            //Load All
            refreshList()
            for crypto in cryptoList {
                modelContext.delete(crypto)
            }
            try modelContext.save()
            //Clean the list.
            refreshList()
            //This calls for CryptoListViewModel to update the list of Cryptos.
            didRequestRefresh.send()
        } catch {
            errorMessage = "Error deleting the items."
        }
    }
    
    // Container Preview for MockData
    static func makeContainerPreview(container: ModelContainer, count: Int = 100) -> some View {
        let context = ModelContext(container)
        
        GeckoService.getMoackDataList(count: count)
        //GeckoService.getSingleMockData()
            .forEach { item in
            context.insert(Crypto(data: item))
        }

        return SettingsView(viewModel: SettingsViewModel()).modelContext(context)
    }
    
}
