//
//  ProgressView.swift
//  ReflectHealth
//
//  Created by Martin on 24/04/2024.
//

import SwiftUI
import SwiftData
import PencilKit

struct ProgressView: View {
    @Environment(\.modelContext) var modelContext
    @Query var trackedDataPieces: [TrackedData]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(trackedDataPieces) { trackedDataPiece in
                    NavigationLink(value: trackedDataPiece) {
                        HStack {
                            if let image = UIImage(data: trackedDataPiece.image3) {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
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
            .navigationTitle("Your Progress")
            .navigationDestination(for: TrackedData.self) { trackedDataPiece in
                EditTrackedDataView(trackDataPiece: trackedDataPiece)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Samples", action: addSamples)
                }
            }
        }
    }
    
    func deleteTrackDataPiece(_ indexSet: IndexSet) {
        for index in indexSet {
            let trackDataPiece = trackedDataPieces[index]
            modelContext.delete(trackDataPiece)
        }
    }
    
    func addSamples() {
        let image1 = UIImage(named: "pikachu")!.pngData()!
        let image2 = UIImage(named: "charizard")!.pngData()!
        let image3 = UIImage(named: "rayquaza")!.pngData()!

        let notes = "These are sample notes, do not do anything with this dlaubculcxfncfluinh udfhcn xuiewfnxciuhe fiuhfx luie eyfg ihfux."
        
        let sample1 = TrackedData(image1: image1, image2: image2, image3: image3, notes: notes)
        let sample2 = TrackedData(image1: image2, image2: image3, image3: image1, notes: notes)
        let sample3 = TrackedData(image1: image3, image2: image1, image3: image2, notes: notes)
        
        modelContext.insert(sample1)
        modelContext.insert(sample2)
        modelContext.insert(sample3)
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        return ProgressView()
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
