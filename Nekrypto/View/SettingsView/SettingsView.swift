//
//  SettingsView.swift
//  Nekrypto
//
//  Created by Alan Milke on 23/05/25.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @Environment(\.modelContext) private var modelContext
    @State fileprivate var viewModel = SettingsViewModel()

    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        Spacer()
                        VStack (spacing: -6) {
                            Text("Nekrypto")
                                .font(.system(size: 40, weight: .black))
                            Text("Oracle iOS Challenge")
                                .fontWeight(.medium)
                        }
                        Spacer()
                    }
                    .foregroundStyle(
                        LinearGradient(colors: [.orange, .red], startPoint: .top, endPoint: .bottom)
                    )
                    .padding(.top, 8)
                    
                    VStack (spacing: 8) {
                        Text("About the challenge")
                            .font(.title2)
                            .fontWeight(.heavy)
                        Text(" ")
                            .font(.footnote)
                            .bold()
                        Text("Build an iOS application that displays criptocurrencies lates prices and allows the user to consult the dedails of each item.")
                            .font(.footnote)
                            .italic()
                    }
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 10)
                    .frame(maxWidth: .infinity)
                }
                .listRowSeparator(.hidden)
                
                Section {
                       
                        Text("Use CoinGecko API to retrieve the Data.")
                            .font(.footnote)
                            
                        Text("The app should display the first 20 cryptos inside a list or creative layout of your choice.")
                            .font(.footnote)
                            
                        Text("When the user clicks on any list item, the app should navigate to a details screen that displays more information about that item.")
                            .font(.footnote)
                            
                        Text("The app should include a Search bar that filters the items by crypto name.")
                            .font(.footnote)
                            
                        Text("The app main screen should have a way to refresh the information.")
                            .font(.footnote)
                        
                    
                } header: {
                    Text("Requirements!")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .foregroundColor(.pink)
                } footer: {
                    Text("All of these requirements are included in this app.")
                        .font(.footnote)
                }//. Section
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                
                Section {
                    HStack {
                        Spacer()
                        Button(role: .destructive , action: {
                            viewModel.showDeleteConfirmationDialog = true
                        }) {
                            Text("Clear Crypto Data")
                        }
                        .disabled(viewModel.itemsInTheList() == 0)
                        Spacer()
                    }
                } header: {
                    Text("Data")
                } footer: {
                    if viewModel.itemsInTheList() > 0 {
                        Text("All the \(viewModel.itemsInTheList()) records will be removed.")
                            .font(.footnote)
                    } else {
                        Text("No records to delete")
                    }
                }//. Section
            }
        }
        .confirmationDialog("Are you sure?", isPresented: $viewModel.showDeleteConfirmationDialog, titleVisibility: .visible) {
            Button("Delete all the records", role: .destructive) {
                viewModel.deleteAllRecords(modelContext: modelContext)
            }
            Button("Cancel", role: .cancel) {}
        }
        .onAppear() {
            viewModel.modelContext = modelContext
            viewModel.refreshList()
        }

    }
}

#Preview ("No Data") {
    SettingsView()
}


#Preview("Some Data") {
    let container = try! ModelContainer(for: Crypto.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    return SettingsViewModel.makeContainerPreview(container: container, count: 5)
}
