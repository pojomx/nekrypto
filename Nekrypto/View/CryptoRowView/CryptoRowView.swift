//
//  CryptoRowView.swift
//  Nekrypto
//
//  Created by Alan Milke on 20/05/25.
//

import SwiftUI

struct CryptoRowView: View {
    
    @State var crypto: Crypto
    @State var picture: Data? = nil
    
    var body: some View {
        HStack {
            VStack {
                if picture == nil {
                    Image(systemName: "cloud.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 48, height: 48)
                        .padding(.trailing)
                } else {
                    Image(uiImage: UIImage(data: picture!)!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 48, height: 48)
                        .padding(.trailing)
                }
            }.onAppear() {
                Task (priority: .utility) {
                    do {
                        picture = try await crypto.downloadPicture()
                    } catch {
                        print("Image loading failed: \(error)")
                    }
                }
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
