//
//  CryptoDetailView.swift
//  Nekrypto
//
//  Created by Alan Milke on 21/05/25.
//

import SwiftUI

struct CryptoDetailView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State var crypto: Crypto

    var body: some View {
        NavigationSplitView {
            VStack {
                AsyncImage (url: crypto.safeImageURL) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                } placeholder: {
                    Image("crypto_template")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                }
                .padding(.vertical)
                
                    Text("\(crypto.name)")
                        .font(.title)
                    Text("\(crypto.symbol)")
                        .font(.title2)
                        .foregroundColor(.secondary)
                List {
                    Section ("Price 24h") {
                        Text("\(crypto.formattedPrice)")
                        Text("\(crypto.lastUpdated)")
                        Text("\(crypto.totalVolume)")
                        Text("\(crypto.highestPrice)")
                        Text("\(crypto.lowestPrice)")
                        Text("\(crypto.priceChange24h)")
                        Text("\(crypto.marketCap)")
                    }
                }
            }
        } detail: {
            Text("Item Selected")
        }
    }
}

#Preview {
    CryptoDetailView(crypto: Crypto(data: GeckoService.getMoackDataList(count: 1)[0]))
}
