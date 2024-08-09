//
//  IndividualProductView.swift
//  ReflectHealth
//
//  Created by Martin on 08/08/2024.
//

import SwiftUI

struct IndividualProductView: View {
    var product: SkincareProduct
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(product.product_name)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                HStack {
                    Spacer()
                    Image(systemName: "waterbottle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                    Spacer()
                }
                Text("Type: ").fontWeight(.semibold) + Text(product.product_type).fontWeight(.light)
                Text("Price: ").fontWeight(.semibold) + Text("£\(product.price, specifier: "%.2f")").fontWeight(.light)
                HStack {
                    Spacer()
                    Link(destination: URL(string: product.product_url)!, label: {
                        Text("View Product")
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .background(Color.accentColor)
                            .clipShape(Capsule())
                    })
                    Spacer()
                }
                Text("Ingredients: ").fontWeight(.semibold) + Text(product.clean_ingreds.joined(separator: ", "))
                    .fontWeight(.light)
            }
        }
        .padding()
    }
}

#Preview {
    @State var testProduct = SkincareProduct(product_name: "Test", product_url: "test", product_type: "Test Type", clean_ingreds: ["dcqc", "cqecv", "rwfxf", "qrxerxwer"], price: 20.0)
    return IndividualProductView(product: testProduct)
}
