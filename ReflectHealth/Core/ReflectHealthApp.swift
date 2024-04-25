//
//  ReflectHealthApp.swift
//  ReflectHealth
//
//  Created by Martin on 22/04/2024.
//

import SwiftUI
import SwiftData

@main
struct ReflectHealthApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: TrackedData.self)
    }
}
