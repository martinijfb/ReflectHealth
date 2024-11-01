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
            
            Group {
                HomeView(selectedTab: $selectedTab)
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                    .tag(0)
                
                
                MainProductsView()
                    .tabItem {
                        Image(systemName: "waterbottle.fill")
                        Text("My Products")                }
                    .tag(1)
                
                ScannerView()
                    .tabItem {
                        Image(systemName: "camera.badge.clock.fill")
                        Text("Track")
                    }
                    .tag(2)
                
                ChatView()
                    .tabItem {
                        Image(systemName: "text.bubble.fill")
                        Text("Chat")
                    }
                
                ProgressView(selectedTab: $selectedTab)
                    .tabItem {
                        Image(systemName: "calendar.badge.plus")
                        Text("Progress")
                    }
                    .tag(3)
                
    
            }
            .background(Gradients.customGradient)
        }
    }
}


#Preview {
    do {
        let previewer = try Previewer()
        return ContentView()
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}

#Preview {
    do {
        let previewer = try NoDataPreviewer()
        return ContentView()
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
