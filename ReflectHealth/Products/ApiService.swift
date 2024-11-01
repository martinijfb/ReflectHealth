//
//  ApiService.swift
//  ReflectHealth
//
//  Created by Martin on 08/08/2024.
//

import Foundation

class ApiService {
    // Replace this with the local IP address of your machine running the FastAPI server
    let baseURL = "IP_ADDRESS"
    
    func fetchProducts() async throws -> [SkincareProduct] {
        guard let url = URL(string: "\(baseURL)/products") else { throw URLError(.badURL) }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let products = try JSONDecoder().decode([SkincareProduct].self, from: data)
        
        return products
    }
    
    func fetchProductsByName(_ name: String) async throws -> [SkincareProduct] {
        let urlString = "\(baseURL)/products/\(name)"
        guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else { throw URLError(.badURL) }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let products = try JSONDecoder().decode([SkincareProduct].self, from: data)
        
        return products
    }
    
    func fetchProductsByType(_ type: String) async throws -> [SkincareProduct] {
        let urlString = "\(baseURL)/products/type/\(type)"
        guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else { throw URLError(.badURL) }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let products = try JSONDecoder().decode([SkincareProduct].self, from: data)
        
        return products
    }
}

