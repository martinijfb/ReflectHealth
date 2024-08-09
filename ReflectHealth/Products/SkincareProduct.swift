//
//  SkincareProduct.swift
//  ReflectHealth
//
//  Created by Martin on 08/08/2024.
//

import Foundation

struct SkincareProduct: Codable, Identifiable {
    var id = UUID()
    let product_name: String
    let product_url: String
    let product_type: String
    let clean_ingreds: [String]
    let price: Float
    
    private enum CodingKeys: String, CodingKey {
        case product_name, product_url, product_type, clean_ingreds, price
    }
}
