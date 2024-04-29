//
//  ProfileImageSelectorView.swift
//  ReflectHealth
//
//  Created by Martin on 27/04/2024.
//

import SwiftUI
import PhotosUI

struct ProfileImageSelectorView: View {
    @Binding var vm: HomeViewModel
    var body: some View {
        PhotosPicker(selection: $vm.user.imageSelection, matching: .images) {
            
            if let image = vm.user.profileImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
            } else {
                
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Color(uiColor: .systemGray6))
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
            }
        }
    }
}

#Preview {
    ProfileImageSelectorView(vm: .constant(HomeViewModel(user: User(firstName: "Martin Jose", lastName: "Fernandes Bolaños", dateOfBirth: .now, email: "martin@123.com", username: "martinijfb", fitzpatrick: .I, gender: .preferNotToSay))))
}
