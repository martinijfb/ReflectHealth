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
    
    var firstName: String = "Martin Jose"
    var lastName: String = "Fernandes Bolaños"
    var dateOfBirth: Date = .now
    private(set) var selectedImage: UIImage? = nil
    var imageSelection: PhotosPickerItem? = nil {
        didSet {
            setImage(from: imageSelection)
        }
    }
    var email: String = "martin@123.com"
    var username: String = "martinijfb"
    var fitzpatrick: Fitzpatrick = .I
    var gender: Gender = .preferNotToSay
    
    private func setImage(from selection: PhotosPickerItem?) {
        guard let selection else { return }
        Task {
            if let data = try? await selection.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    selectedImage = uiImage
                    return
                }
            }
        }
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
