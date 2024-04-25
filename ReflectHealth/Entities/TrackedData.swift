//
//  TrackData.swift
//  ReflectHealth
//
//  Created by Martin on 24/04/2024.
//

import SwiftData
import SwiftUI

@Model
class TrackedData {
    @Attribute(.unique) var id: String
    var date: Date
    @Attribute(.externalStorage) var image1: Data
    @Attribute(.externalStorage) var image2: Data
    @Attribute(.externalStorage) var image3: Data

    @Attribute(.externalStorage) var drawing1: Data?
    @Attribute(.externalStorage) var drawing2: Data?
    @Attribute(.externalStorage) var drawing3: Data?
    
    var notes: String


    init(date: Date = .now, image1: Data, image2: Data, image3: Data, drawing1: Data? = nil, drawing2: Data? = nil, drawing3: Data? = nil, notes: String) {
        self.id = UUID().uuidString
        self.date = date
        self.image1 = image1
        self.image2 = image2
        self.image3 = image3
        self.drawing1 = drawing1
        self.drawing2 = drawing2
        self.drawing3 = drawing3
        self.notes = notes
    }
}

