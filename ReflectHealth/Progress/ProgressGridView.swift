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
    
    @State var showAlert: Bool = false
    @State private var itemToDelete: TrackedData?
    
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
        .alert("Delete Progress Item", isPresented: $showAlert, actions: {
            alertActions
        }, message: {
            alertMessages
        })
    }
    
    init(sort: SortDescriptor<TrackedData>, startDate: Date, endDate: Date) {
        _trackedDataPieces = Query(filter: #Predicate {
            $0.date >= startDate && $0.date <= endDate
        }, sort: [sort])
    }
}

extension ProgressGridView {
    
    // MARK: - VIEWS
    @ViewBuilder
    private func gridItem(_ trackedDataPiece: TrackedData) -> some View {
        ZStack(alignment: .topTrailing) {
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
            
            Menu {
                Button("Delete", systemImage: "trash") {
                    itemToDelete = trackedDataPiece
                    showAlert = true
                }
                NavigationLink(value: trackedDataPiece) {
                    LabeledContent {
                        Text("See your progress")
                    } label: {
                        Image(systemName: "person.text.rectangle")
                    }
                    
                }
                
            } label: {
                Image(systemName: "ellipsis.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24)
                    .padding(4)
                    .foregroundStyle(.white, .ultraThinMaterial)
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
    
    // MARK: - ALERT
    func deleteTrackDataPiece(_ trackDataPiece: TrackedData) {
        modelContext.delete(trackDataPiece)
    }
    
    private var alertActions: some View {
        Group {
            Button(role: .destructive) {
                if let itemToDelete = itemToDelete {
                    deleteTrackDataPiece(itemToDelete)
                }
            } label: {
                Text("Delete")
            }
            
            Button(role: .cancel) {
                itemToDelete = nil
            } label: {
                Text("Cancel")
            }
        }
    }
    
    private var alertMessages: some View {
        Text("Are you sure you want to delete this progress item?")
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
