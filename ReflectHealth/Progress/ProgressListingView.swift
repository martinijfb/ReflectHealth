//
//  EditTrackedDataListingView.swift
//  ReflectHealth
//
//  Created by Martin on 25/04/2024.
//

import SwiftUI
import SwiftData

struct ProgressListingView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \TrackedData.date, order: .reverse) var trackedDataPieces: [TrackedData]
    
    var body: some View {
        List {
            ForEach(trackedDataPieces) { trackedDataPiece in
                NavigationLink(value: trackedDataPiece) {
                    HStack {
                        if let image = UIImage(data: trackedDataPiece.image3) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .frame(width: 70, height: 70)
                                
                        }
                        VStack(alignment: .leading) {
                            Text("Progress from:")
                                .fontWeight(.semibold)
                            Text(trackedDataPiece.date.formatted(date: .long, time: .shortened))
                        }
                        Spacer()
                    }
                }
            }
            .onDelete(perform: deleteTrackDataPiece)
        }
    }
    
    init(sort: SortDescriptor<TrackedData>, startDate: Date, endDate: Date) {

        
        _trackedDataPieces = Query(filter: #Predicate {
            $0.date >= startDate && $0.date <= endDate
        }, sort: [sort])
    }
    
    func deleteTrackDataPiece(_ indexSet: IndexSet) {
        for index in indexSet {
            let trackDataPiece = trackedDataPieces[index]
            modelContext.delete(trackDataPiece)
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
