//
//  ProgressGridView.swift
//  ReflectHealth
//
//  Created by Martin on 30/05/2024.
//

import SwiftUI
import SwiftData

struct ProgressGridView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query(sort: \TrackedData.date, order: .reverse) var trackedDataPieces: [TrackedData]
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(trackedDataPieces) { trackedDataPiece in
                    NavigationLink(value: trackedDataPiece) {
                
                            if let image = UIImage(data: trackedDataPiece.image3) {
                                ImageLabel(image: image, drawingData: trackedDataPiece.drawing3)
                            }
                    }
                }
            }
            .padding()
        }
    }
    
    init(sort: SortDescriptor<TrackedData>, startDate: Date, endDate: Date) {

        
        _trackedDataPieces = Query(filter: #Predicate {
            $0.date >= startDate && $0.date <= endDate
        }, sort: [sort])
    }
    
}

extension ProgressGridView {
    @ViewBuilder
    func ImageLabel(image: UIImage, drawingData: Data?) -> some View {
        ZStack {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
            
            if let safeData = drawingData {
                if let drawingImage = UIImage(data: safeData) {
                    Image(uiImage: drawingImage)
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                }
            }
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        return ProgressView(selectedTab: .constant(0))
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
