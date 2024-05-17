//
//  ProfileView.swift
//  ReflectHealth
//
//  Created by Martin on 25/04/2024.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @State var vm = HomeViewModel(user: User(firstName: "Martin Jose", lastName: "Fernandes Bolaños", dateOfBirth: .now, email: "martin@123.com", username: "martinijfb", fitzpatrick: .I, gender: .preferNotToSay))
    @Binding var selectedTab: Int
    
    @Environment(\.modelContext) var modelContext
    
    @Query(sort: \TrackedData.date, order: .reverse) var trackedDataPieces: [TrackedData]
    
    var body: some View {
        NavigationStack {
            GeometryReader { gr in
                ScrollView {
                    VStack {
                        header
                        
                        ZStack {
                                TopRoundedRectangle(cornerRadius: 48)
                                    .fill(.lightBlue10)
                                    .frame(height: .infinity)
           
                            VStack {
                                routine
                                    .padding(.top)
                                
                                lastTrack
                            }
                        }
                        
                    }
                    .frame(minHeight: gr.size.height)
                }
            }
            .scrollBounceBehavior(.basedOnSize)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    reflectTitle
                }
            }
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        return HomeView(selectedTab: .constant(1))
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}

#Preview {
    do {
        let previewer = try NoDataPreviewer()
        return HomeView(selectedTab: .constant(1))
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
