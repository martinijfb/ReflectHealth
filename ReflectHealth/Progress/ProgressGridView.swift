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
            LazyVGrid(columns: columns, spacing: 24) {
                ForEach(trackedDataPieces, content: gridItem)
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
    private func gridItem(_ trackedDataPiece: TrackedData) -> some View {
        NavigationLink(value: trackedDataPiece) {
            VStack(spacing: 0) {
                if let image = UIImage(data: trackedDataPiece.image3) {
                    ImageLabel(image: image, drawingData: trackedDataPiece.drawing3)
                        .aspectRatio(1, contentMode: .fit)
                }
                dateText(trackedDataPiece.date)
            }
            .background(.lightBlue10)
            .clipShape(RoundedRectangle(cornerRadius: 18))
            .overlay {
                RoundedRectangle(cornerRadius: 18).stroke(.lightBlue8, lineWidth: 1)
            }
        }
    }

    @ViewBuilder
    private func dateText(_ date: Date) -> some View {
        VStack {
            Text(date.formatted(date: .numeric, time: .omitted))
            Text(date.formatted(date: .omitted, time: .shortened))
        }
        .padding(4)
        .foregroundStyle(.black)
        .fontWeight(.light)
        .minimumScaleFactor(0.7)
        .lineLimit(1)
        .frame(maxWidth: .infinity)
    }

    @ViewBuilder
    func ImageLabel(image: UIImage, drawingData: Data?) -> some View {
            ZStack {
                Group {
                    Image(uiImage: image)
                        .resizable()
                        .shadow(radius: 4, x: 4, y: 4)
                    
                    if let safeData = drawingData, let drawingImage = UIImage(data: safeData) {
                        Image(uiImage: drawingImage)
                            .resizable()
                    }
                }
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(8)
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
