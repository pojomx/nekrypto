//
//  ContentView.swift
//  Nekrypto
//
//  Created by Alan Milke on 20/05/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var cryptos: [Crypto]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(cryptos) { crypto in
                    NavigationLink {
                        Text("\(crypto.symbol)")
                    } label: {
                        Text("\(crypto.symbol)")
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    Button(action: refreshAction) {
                        // Symbol arrow.clockwise got from SF Symbols App.
                        Label("Add Item", systemImage: "arrow.clockwise")
                    }
                }
            }
            .overlay {
                if cryptos.count == 0 {
                    VStack {
                        Text("No items found.")
                        Text("Tap the refresh button to update the list.")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    
    private func refreshAction() {
        //no-op
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Crypto.self, inMemory: true)
}
