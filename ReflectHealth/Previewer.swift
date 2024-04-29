//
//  Previewer.swift
//  ReflectHealth
//
//  Created by Martin on 24/04/2024.
//

import SwiftUI
import SwiftData
import PencilKit

@MainActor
@Observable
class Previewer {
    // MARK: - PROGRESS SECTION
    let container: ModelContainer
    let trackDataPiece: TrackedData
    let trackDataPiece2: TrackedData
    let image1 = UIImage(named: "pikachu")!.pngData()!
    let image2 = UIImage(named: "charizard")!.pngData()!
    let image3 = UIImage(named: "rayquaza")!.pngData()!

    let notes = "These are sample notes, do not do anything with this dlaubculcxfncfluinh udfhcn xuiewfnxciuhe fiuhfx luie eyfg ihfux."
    
    
    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: TrackedData.self, configurations: config)
        
        trackDataPiece = TrackedData(image1: image1, image2: image2, image3: image3, notes: notes)
        trackDataPiece2 = TrackedData(date: .now.addingTimeInterval(-86400 * 7), image1: image1, image2: image2, image3: image3, notes: notes)
        container.mainContext.insert(trackDataPiece)
        container.mainContext.insert(trackDataPiece2)
    }
}
