//
//  ProfileImageSelectorView.swift
//  ReflectHealth
//
//  Created by Martin on 27/04/2024.
//

import SwiftUI
import PhotosUI
import SwiftyCrop

struct ProfileImageSelectorView: View {
    @Binding var vm: HomeViewModel
    var body: some View {
        PhotosPicker(selection: $vm.imageSelection, matching: .images) {
            
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
        .fullScreenCover(isPresented: $vm.showImageCropper) {
           cropView
        }
    }
}

extension ProfileImageSelectorView {
    
    @ViewBuilder
    var cropView: some View {
        if let selectedImage = vm.tempProfileImage {
            SwiftyCropView(
                imageToCrop: selectedImage,
                maskShape: .circle,
                configuration: vm.configuration
            ) { croppedImage in
                vm.user.profileImage = croppedImage
            }
        }
    }
}

#Preview {
    ProfileImageSelectorView(vm: .constant(HomeViewModel(user: User(firstName: "Martin Jose", lastName: "Fernandes Bolaños", dateOfBirth: .now, email: "martin@123.com", username: "martinijfb", fitzpatrick: .I, gender: .preferNotToSay))))
}
