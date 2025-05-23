//
//  CryptoRowView.swift
//  Nekrypto
//
//  Created by Alan Milke on 20/05/25.
//

import SwiftUI

struct CryptoRowView: View {
    
    private let crypto: Crypto
    @State private var viewModel: CryptoRowViewModel
    
    init(crypto: Crypto) {
        self.crypto = crypto
        self.viewModel = CryptoRowViewModel(crypto: crypto)
    }
    
    var body: some View {
        HStack {
            VStack {
                if let picture = viewModel.picture {
                    Image(uiImage: UIImage(data: picture)!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 48, height: 48)
                        .padding(.trailing)
                } else {
                    Image(systemName: "cloud.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 48, height: 48)
                        .padding(.trailing)
                }
            }
            VStack(alignment: .leading) {

                HStack {
                    Text("\(crypto.name)")
                }
                HStack (alignment: .top) {
                    Text("\(crypto.symbol)")
                        .font(.footnote)
                        .fontWeight(.bold)
                    Spacer()
                    VStack (alignment: .trailing) {
                        Text("\(crypto.formattedPrice)")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("\(crypto.formattedDate)")
                            .font(.caption)
                            .foregroundColor(.secondary)
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
