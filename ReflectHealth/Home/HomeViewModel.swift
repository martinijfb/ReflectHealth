//
//  HomeViewModel.swift
//  ReflectHealth
//
//  Created by Martin on 26/04/2024.
//

import SwiftUI
import PhotosUI
import SwiftyCrop

@Observable
class HomeViewModel {
    
    var user: User
    var showImageCropper: Bool = false
    var tempProfileImage: UIImage? = nil
    
    init(user: User) {
        self.user = user
    }
    
    let configuration = SwiftyCropConfiguration(
        maxMagnificationScale: 4.0,
        maskRadius: 130,
        cropImageCircular: false,
        rotateImage: false
    )
    
    var imageSelection: PhotosPickerItem? = nil {
        didSet {
            setImage(from: imageSelection)
        }
    }
    
    private func setImage(from selection: PhotosPickerItem?) {
        guard let selection else { return }
        Task {
            if let data = try? await selection.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    tempProfileImage = uiImage
                    showImageCropper.toggle()
                    return
                }
            }
        }
    }
    
    func getSunMoonImage() -> (String, Color) {
        let currentTime = Calendar.current.dateComponents([.hour], from: Date()).hour ?? 0
        if currentTime >= 4 && currentTime < 18 {
            // Return "sun.max.fill" with yellow color from 4:00 to 17:59
            return ("sun.max.fill", .yellow)
        } else {
            // Return "moon.fill" with blue color for the rest of the hours
            return ("moon.fill", .blue)
        }
    }
    
}
