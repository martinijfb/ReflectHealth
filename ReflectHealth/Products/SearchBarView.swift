//
//  SearchBarView.swift
//  ReflectHealth
//
//  Created by Martin on 08/08/2024.
//

import SwiftUI

struct SearchBarView: View {
    @State private var searchText = ""
    @State private var searchType = ""
    @ObservedObject var viewModel: ProductsViewModel
    
    var body: some View {
        VStack {
            HStack {
                TextField("Search by name", text: $searchText, onCommit: {
                    Task {
                        await viewModel.fetchProductsByName(searchText)
                    }
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .onChange(of: searchText) { _, newValue in
                    viewModel.suggestedNames = ProductNames.names.filter { $0.lowercased().contains(newValue.lowercased()) }
                }

                
                Button(action: {
                    Task {
                        await viewModel.fetchProductsByName(searchText)
                    }
                }) {
                    Text("Search")
                }
                .padding(.trailing)
            }
            
            if !viewModel.suggestedNames.isEmpty {
                List(viewModel.suggestedNames, id: \.self) { name in
                    Text(name).onTapGesture {
                        searchText = name
                        viewModel.suggestedNames = []
                        Task {
                            await viewModel.fetchProductsByName(searchText)
                        }
                    }
                }
                .frame(maxHeight: 150)
            }
            
            HStack {
                TextField("Search by type", text: $searchType, onCommit: {
                    Task {
                        await viewModel.fetchProductsByType(searchType)
                    }
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                
                Button(action: {
                    Task {
                        await viewModel.fetchProductsByType(searchType)
                    }
                }) {
                    Text("Search")
                }
                .padding(.trailing)
            }
        }
        .padding(.vertical)
    }
}


#Preview {
    MainProductsView()
}
