//
//  CryptoListView.swift
//  Nekrypto
//
//  Created by Alan Milke on 20/05/25.
//

import SwiftUI
import SwiftData

struct CryptoListView: View {

    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = CryptoListViewModel()

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(viewModel.cryptoList) { crypto in
                    NavigationLink {
                        CryptoDetailView(crypto: crypto)
                    } label: {
                        CryptoRowView(crypto: crypto)
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        viewModel.fetchData()
                    } label: {
                        // Symbol arrow.clockwise got from SF Symbols App.
                        if viewModel.isLoading {
                            ProgressView()
                        } else {
                            Label("Add Item", systemImage: "arrow.clockwise")
                        }
                    }
                }
            }
            .refreshable(action: {
                viewModel.fetchData()
            })
            .overlay {
                if viewModel.cryptoList.count == 0 {
                    VStack {
                        Text("No items found.")
                        Text("Tap the refresh button to update the list.")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
        .onAppear() {
            viewModel.modelContext = modelContext
            viewModel.refreshList()
        }
    }
}

#Preview("No Data") {
    
    CryptoListView()
        .modelContainer(for: Crypto.self, inMemory: true)
}
    
#Preview("Some Data") {
    let container = try! ModelContainer(for: Crypto.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    
    return CryptoListViewModel.makeContainerPreview(container: container, count: 5)
}
