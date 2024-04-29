//
//  HomeViewModel.swift
//  ReflectHealth
//
//  Created by Martin on 26/04/2024.
//

import SwiftUI
import PhotosUI

@Observable
class HomeViewModel {
    
    var user: User
    
    init(user: User) {
        self.user = user
    }
    
    
    func getSunMoonImage() -> (String, Color) {
        let currentTime = Calendar.current.dateComponents([.hour], from: Date()).hour ?? 0
        if currentTime < 12 {
            // Return "sun.max" with yellow color from 00:00 to 11:59
            return ("sun.max.fill", .yellow)

        } else {
            // Return "moon.fill" with blue color for the rest
            return ("moon.fill", .blue)
        }
    }
}
