//
//  CryptoDetailView.swift
//  Nekrypto
//
//  Created by Alan Milke on 21/05/25.
//

import SwiftUI

struct CryptoDetailView: View {
    @Environment(\.modelContext) private var modelContext
    
    let crypto: Crypto

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    //MARK: - HEADER
                    VStack {
                        HStack {
                            Spacer()
                            if crypto.picture == nil {
                                Image("crypto_template")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 150, height: 150)
                                    .padding(.vertical)
                            } else {
                                Image(uiImage: UIImage(data: crypto.picture!)!)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 150, height: 150)
                                    .padding(.vertical)
                            }
                            Spacer()
                        }
                        Text("\(crypto.name)")
                            .font(.title)
                        Text("\(crypto.symbol)")
                            .font(.title2)
                            .foregroundColor(.secondary)
                        
                        Text("\(crypto.formattedPrice)")
                            .font(.largeTitle)
                        
                        Text("\(crypto.priceChange24h < 0 ? "" : "+")\(crypto.priceChange24h.formatted(.number))")
                            .foregroundColor(crypto.priceChange24h < 0 ? .red : .green)
                            .fontWeight(.bold)
                    }
                    .listRowSeparator(.hidden)
                    
                    HStack {
                        Spacer()
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.green)
                                Image(systemName: "chart.line.uptrend.xyaxis")
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                    .font(.footnote)
                            }
                            
                            Text("\(crypto.formattedHigh)")
                                .tint(.pink)
                                .fontWeight(.light)
                                .font(.caption)
                        }
                        
                        
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.red)
                                Image(systemName: "chart.line.downtrend.xyaxis")
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                    .font(.footnote)
                            }
                            
                            Text("\(crypto.formattedLow)")
                                .tint(.pink)
                                .fontWeight(.light)
                                .font(.caption)
                        }
                        Spacer()
                    }
                    
                    //MARK: - DETAILS
                    
                    Section ("Price 24h | Updated: \(crypto.lastUpdated)") {
                        CustomListRowView(
                            rowContent: "\(crypto.formattedPrice)",
                            rowLabel: "Current Price",
                            rowIcon: "bitcoinsign.bank.building",
                            rowTintColor: Color.orange)
                        .id(crypto.id)
                        
                        CustomListRowView(
                            rowContent: "\(crypto.priceChange24h < 0 ? "" : "+")\(crypto.priceChange24h.formatted())",
                            rowLabel: "Price Change",
                            rowIcon: crypto.priceChange24h > 0 ? "chart.line.uptrend.xyaxis.circle" : "chart.line.downtrend.xyaxis.circle",
                            rowTintColor: crypto.priceChange24h > 0 ? .green : .red)
                        .id(crypto.id)
                        
                        CustomListRowView(
                            rowContent: "\(crypto.formattedHigh)",
                            rowLabel: "Highest Price",
                            rowIcon: "chart.line.uptrend.xyaxis",
                            rowTintColor: .green)
                        .id(crypto.id)
                        
                        CustomListRowView(
                            rowContent: "\(crypto.formattedLow)",
                            rowLabel: "Lowest Price",
                            rowIcon: "chart.line.downtrend.xyaxis",
                            rowTintColor: .red)
                        .id(crypto.id)
                        
                        CustomListRowView(
                            rowContent: "\(crypto.totalVolume.formatted(.number))",
                            rowLabel: "Total Volume",
                            rowIcon: "bitcoinsign.bank.building.fill",
                            rowTintColor: .accent)
                        .id(crypto.id)
                        
                        CustomListRowView(
                            rowContent: "\(crypto.marketCap.formatted(.number))",
                            rowLabel: "Market Cap",
                            rowIcon: "bitcoinsign.bank.building.fill",
                            rowTintColor: .accent)
                        .id(crypto.id)
                    }
                }
            }
        }
        .navigationTitle("\(crypto.symbol) - \(crypto.name)")
    }
}

#Preview {
    CryptoDetailView(crypto: Crypto(data: GeckoService.getMoackDataList(count: 1)[0]))
}
