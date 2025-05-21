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
                        Text("\(crypto.symbol)")
                    } label: {
                        CryptoRowView(crypto: crypto)
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        viewModel.refreshList(modelContext: modelContext)
                    } label: {
                        // Symbol arrow.clockwise got from SF Symbols App.
                        Label("Add Item", systemImage: "arrow.clockwise")
                    }
                }
            }
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
            viewModel.refreshList(modelContext: modelContext)
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
