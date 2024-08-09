//
//  ProductsViewModel.swift
//  ReflectHealth
//
//  Created by Martin on 08/08/2024.
//

import Foundation

@MainActor
class ProductsViewModel: ObservableObject {
    @Published var products: [SkincareProduct] = []
    @Published var suggestedNames: [String] = []
    
    private let apiService = ApiService()
    
    func fetchProducts() async {
        do {
            let products = try await apiService.fetchProducts()
            self.products = products
        } catch {
            print("Failed to fetch products: \(error)")
        }
    }
    
    func fetchProductsByName(_ name: String) async {
        do {
            let products = try await apiService.fetchProductsByName(name)
            self.products = products
        } catch {
            print("Failed to fetch products by name: \(error)")
        }
    }
    
    func fetchProductsByType(_ type: String) async {
        do {
            let products = try await apiService.fetchProductsByType(type)
            self.products = products
        } catch {
            print("Failed to fetch products by type: \(error)")
        }
    }
}
