//
//  EditProfileView.swift
//  ReflectHealth
//
//  Created by Martin on 27/04/2024.
//

import SwiftUI



// Main view for editing profile with reusable components
struct EditProfileView: View {
    @Binding var vm: HomeViewModel
    let formSpacing: CGFloat = 150
    
    var body: some View {
        NavigationStack {
            ZStack {
                Gradients.customGradient.ignoresSafeArea()
                Form {
                    Section("Profile Picture and Account") {
                    
                            ZStack {
                                if let image = vm.user.profileImage {
                                    Image(uiImage: image)
                                        .blur(radius: 10.0)
                                }
                                ProfileImageSelectorView(vm: $vm)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 120)
                            
                        formField(label: "Username", text: $vm.user.username, formSpacing: formSpacing, textContentType: .username)
                   
                    }
                    
                    Section("Personal Information") {
                     
                        formField(label: "First Name", text: $vm.user.firstName, formSpacing: formSpacing, textContentType: .givenName)
                        formField(label: "Surname", text: $vm.user.lastName, formSpacing: formSpacing, textContentType: .familyName)
                        formField(label: "Email", text: $vm.user.email, formSpacing: formSpacing, textContentType: .emailAddress, keyboardType: .emailAddress)
                            
                        DatePicker("Birthday", selection: $vm.user.dateOfBirth, displayedComponents: .date)
                            
                        Picker("Select Gender", selection: $vm.user.gender) {
                                ForEach(Gender.allCases, id: \.self) { gender in
                                    Text(gender.rawValue).tag(gender)
                                }
                            }
                            .pickerStyle(.navigationLink)
                        
                    }
                    
                    Section("Fitzpatrick") {
                        fitzpatrickSection  // Use the view variable
                    }
                }
                .scrollContentBackground(.hidden)
                .navigationTitle("Profile")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

extension EditProfileView {
    // Function to create a text field with customizable attributes
    func formField(label: String, text: Binding<String>, formSpacing: CGFloat, textContentType: UITextContentType? = nil, keyboardType: UIKeyboardType = .default, submitLabel: SubmitLabel = .done) -> some View {
        HStack {
            Text(label)
                .frame(width: formSpacing, alignment: .leading)
            TextField(label, text: text)
                .textContentType(textContentType)
                .keyboardType(keyboardType)
                .submitLabel(submitLabel)
        }
    }

    // View variable for Fitzpatrick picker
    internal var fitzpatrickSection: some View {
        Picker("Fitzpatrick", selection: $vm.user.fitzpatrick) {  // Picker to set gender
            ForEach(Fitzpatrick.allCases, id: \.self) { scale in  // Iterate over all cases
                HStack {
                    Rectangle()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(Color(scale.rawValue))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    Text(scale.rawValue)
                        .tag(scale)
                }  // Set tag to the enum case
            }
        }
        .pickerStyle(.navigationLink)
    }
}


#Preview {
    EditProfileView(vm: .constant(HomeViewModel(user: User(firstName: "Martin Jose", lastName: "Fernandes Bolaños", dateOfBirth: .now, email: "martin@123.com", username: "martinijfb", fitzpatrick: .I, gender: .preferNotToSay))))
}
