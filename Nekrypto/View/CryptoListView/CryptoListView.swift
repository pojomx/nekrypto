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
    @State fileprivate var viewModel = CryptoListViewModel()

    var body: some View {
        NavigationSplitView {
            if viewModel.errorMessage != nil {
                HStack {
                    Button {
                        viewModel.resetErrorMessage()
                    } label: {
                        Text("Error: \(viewModel.errorMessage!)")
                            .font(.system(.headline, design: .rounded))
                            .fontWeight(.bold)
                    }//: BUTTON
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                    .controlSize(.mini)
                }
            }
            List (viewModel.filteredCryptos, selection: $viewModel.selected) { crypto in
                NavigationLink(value: crypto) {
                    CryptoRowView(crypto: crypto)
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
                
                ToolbarItem {
                    Button {
                        viewModel.displaySettings.toggle()
                    } label: {
                        Label("Settings", systemImage: "gear")
                    }
                    .sheet(isPresented: $viewModel.displaySettings) {
                        SettingsView()
                            .presentationDragIndicator(.visible)
                            .presentationDetents([.medium, .large])
                    }
                }
                
            }
            .searchable(text: $viewModel.searchFilter, prompt: "Search Crypto")
            .refreshable(action: {
                viewModel.fetchData()
            })
            .navigationTitle("Cryptocurrencies")
            .overlay {
                if viewModel.filteredCryptos.count == 0 && viewModel.searchFilter.isEmpty {
                    VStack {
                        Text("No items found.")
                        Text("Tap the refresh button to update the list.")
                    }
                } else if viewModel.filteredCryptos.count == 0 && !viewModel.searchFilter.isEmpty {
                    VStack {
                        Text("No items found.")
                        Text("No items found, try searching something else.")
                    }
                }
            }
        } detail: {
            if let selected = viewModel.selected {
                    CryptoDetailView(crypto: selected)
            } else {
                Text("Select a crypto")
                    .foregroundColor(.secondary)
            }
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
