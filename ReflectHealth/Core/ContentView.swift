//
//  ContentView.swift
//  ReflectHealth
//
//  Created by Martin on 22/04/2024.
//

import SwiftUI

struct ContentView: View {
    @State var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab){
            
            ContentUnavailableView("This content is not available", systemImage: "waterbottle.fill", description: Text("Sorry, at the moment the data could not be loaded"))
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
            
           
            ContentUnavailableView("This content is not available", systemImage: "waterbottle.fill", description: Text("Sorry, at the moment the data could not be loaded"))
                .tabItem {
                    Image(systemName: "waterbottle.fill")
                    Text("My Products")                }
                .tag(1)
            
            LabelView()
                .tabItem {
                    Image(systemName: "camera.badge.clock.fill")
                    Text("Track")
                }
                .tag(2)
            
            ContentUnavailableView("This content is not available", systemImage: "waterbottle.fill", description: Text("Sorry, at the moment the data could not be loaded"))
                .tabItem {
                    Image(systemName: "calendar.badge.plus")
                    Text("Progress")
                }
                .tag(3)
            
            
            ContentUnavailableView("This content is not available", systemImage: "waterbottle.fill", description: Text("Sorry, at the moment the data could not be loaded"))
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(4)
        }
    }
}


#Preview {
    ContentView()
}