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
        PhotosPicker(selection: $vm.imageSelection, matching: .images) {
            
            if let image = vm.selectedImage {
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
    ProfileImageSelectorView(vm: .constant(HomeViewModel()))
}
