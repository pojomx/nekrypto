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
            HStack {
                AsyncImage (url: crypto.safeImageURL) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 48, height: 48)
                } placeholder: {
                    Image("crypto_template")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 48, height: 48)
                }

                VStack(alignment: .leading) {
                    Text("\(crypto.name)")
                    Text("\(crypto.symbol)")
                        .font(.footnote)
                }
                Spacer()
                VStack (alignment: .trailing) {
                    Text("\(crypto.formattedPrice)")
                    Text("\(crypto.lastUpdated)")
                        .font(.caption)
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
