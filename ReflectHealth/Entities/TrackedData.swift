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
    var image1: Data
    var image2: Data
    var image3: Data

    var canvas1: Data
    var canvas2: Data
    var canvas3: Data
    
    var notes: String


    init(date: Date = .now, image1: Data, image2: Data, image3: Data, canvas1: Data, canvas2: Data, canvas3: Data, notes: String) {
        self.id = UUID().uuidString
        self.date = date
        self.image1 = image1
        self.image2 = image2
        self.image3 = image3
        self.canvas1 = canvas1
        self.canvas2 = canvas2
        self.canvas3 = canvas3
        self.notes = notes
    }
}

