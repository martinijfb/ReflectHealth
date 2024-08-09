//
//  MainProductsView.swift
//  ReflectHealth
//
//  Created by Martin on 08/08/2024.
//

import SwiftUI

struct MainProductsView: View {
    @StateObject private var viewModel = ProductsViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(viewModel: viewModel)
                List(viewModel.products) { product in
                    VStack(alignment: .leading) {
                        NavigationLink(product.product_name) {
                            IndividualProductView(product: product)
                        }
                        
                    }
                }
                .navigationTitle("Skincare Products")
                .onAppear {
                    Task {
                        await viewModel.fetchProducts()
                    }
                }
            }
        }
    }
}

#Preview {
    MainProductsView()
}
