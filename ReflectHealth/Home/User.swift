//
//  User.swift
//  ReflectHealth
//
//  Created by Martin on 29/04/2024.
//

import SwiftUI
import PhotosUI

@Observable
class User {
    var firstName: String
    var lastName: String
    var dateOfBirth: Date
    var email: String
    var username: String
    var fitzpatrick: Fitzpatrick
    var gender: Gender
    var profileImage: UIImage?
    
    var imageSelection: PhotosPickerItem? = nil {
        didSet {
            setImage(from: imageSelection)
        }
    }

    
    init(firstName: String, lastName: String, dateOfBirth: Date, email: String, username: String, fitzpatrick: Fitzpatrick, gender: Gender) {
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.email = email
        self.username = username
        self.fitzpatrick = fitzpatrick
        self.gender = gender
    }
    
    private func setImage(from selection: PhotosPickerItem?) {
        guard let selection else { return }
        Task {
            if let data = try? await selection.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    profileImage = uiImage
                    return
                }
            }
        }
    }
}
