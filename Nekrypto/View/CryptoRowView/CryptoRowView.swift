//
//  CryptoRowView.swift
//  Nekrypto
//
//  Created by Alan Milke on 20/05/25.
//

import SwiftUI

struct CryptoRowView: View {
    
    @State var crypto: Crypto
    
    var body: some View {
        HStack {
            AsyncImage (url: crypto.safeImageURL) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 48)
                    .padding(.trailing)
            } placeholder: {
                Image("crypto_template")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 48)
                    .padding(.trailing)
            }
            
            

            VStack(alignment: .leading) {

                HStack {
                    Text("\(crypto.name)")
                }
                HStack (alignment: .top) {
                    Text("\(crypto.symbol)")
                        .font(.footnote)
                    Spacer()
                    VStack (alignment: .trailing) {
                        Text("\(crypto.formattedPrice)")
                            .font(.title2)
                        Text("\(crypto.lastUpdated)")
                            .font(.caption)
                    }
                }
            }
        }
    }
}

#Preview {
    List {
        CryptoRowView(crypto: Crypto(data: GeckoService.getMoackDataList(count: 1)[0]))
    }
}
