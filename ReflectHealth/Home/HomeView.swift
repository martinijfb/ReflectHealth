//
//  ProfileView.swift
//  ReflectHealth
//
//  Created by Martin on 25/04/2024.
//

import SwiftUI
import PhotosUI
import SwiftData

struct HomeView: View {
    
    @State var vm = HomeViewModel()
    @Binding var selectedTab: Int
    
    @State private var showNavigationBar = true
    
    @Environment(\.modelContext) var modelContext
    @Query(sort: \TrackedData.date, order: .reverse) var trackedDataPieces: [TrackedData]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Gradients.customGradient.ignoresSafeArea()
                ScrollView {
                    VStack(alignment: .leading) {
                        
                        // MARK: - "HEADER"
                        profileHeader
                        
                        // MARK: - BODY
                        Text("Your current routine:")
                            .font(.headline)
                            .padding(.top)
                        routineSection
                        
                        
                        
                        Text("Last time you ckeck your progress:")
                            .font(.headline)
                            .padding(.top)
                        
                        
                        LastProgressTrakcer()
                        
                        
                    }
                    .padding()
                    .toolbar(.hidden, for: .navigationBar)
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            NavigationLink {
                                EditProfileView(vm: $vm)
                            } label: {
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(Gradients.customGradientSheet)
                            }
                        }
                        ToolbarItem(placement: .topBarLeading) {
                            Image("logo-header")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 30)
                                .foregroundStyle(Gradients.customGradientLogo)
                        }
                    }
                }
            }
            .toolbarBackground(.ultraThinMaterial, for: .tabBar)
            .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
        }
    }
}

extension HomeView {
    
    @ViewBuilder
    func ImageLabel(image: UIImage, drawingData: Data) -> some View {
        ZStack {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
            if let drawingImage = UIImage(data: drawingData) {
                Image(uiImage: drawingImage)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
            }
        }
    }
    
    @ViewBuilder
    func LastProgressTrakcer() -> some View {
        
        if let lastTrack = trackedDataPieces.first,
           let image1 = UIImage(data: lastTrack.image1),
           let image2 = UIImage(data: lastTrack.image2),
           let image3 =  UIImage(data: lastTrack.image3),
           let drawingData1 = lastTrack.drawing1,
           let drawingData2 = lastTrack.drawing2,
           let drawingData3 = lastTrack.drawing3 {
            HStack {
                Spacer()
                ZStack(alignment: .top) {
                    TabView {
                        ImageLabel(image: image1, drawingData: drawingData1)
                        ImageLabel(image: image2, drawingData: drawingData2)
                        ImageLabel(image: image3, drawingData: drawingData3)
                    }
                    .frame(width: 300, height: 400)
                    .tabViewStyle(.page)
                    Text(lastTrack.date.formatted(date: .long, time: .shortened))
                        .padding(.horizontal)
                        .padding(.vertical, 4)
                        .background(.ultraThinMaterial)
                        .background(Gradients.customGradientInverse)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.vertical)
                }
                Spacer()
            }
        } else {
            VStack {
                HStack {
                    Image(systemName: "camera.aperture")
                        .foregroundStyle(.black)
                    Text("You haven't tracked your progress")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top)
                Spacer()
                Image(systemName: "person.crop.square.badge.camera")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.gray)
                    .frame(width: 60, height: 60)
                Button("Track", action: { selectedTab = 2 })
                    .buttonStyle(.borderedProminent)
                Spacer()
                
            }
            .frame(height: 200)
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
            .background(Gradients.customGradientInverse)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        
    }
}


extension HomeView {
    internal var profileHeader: some View {
        HStack {
            ProfileImageSelectorView(vm: $vm)
                .padding(.trailing)
            VStack(alignment: .leading) {
                Text(vm.firstName + " " + vm.lastName)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
                Text("@" + vm.username)
                    .font(.headline)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }
            Spacer()
        }
        .padding()
        .background(.ultraThinMaterial)
        .background(Gradients.customGradientSheet)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    internal var routineSection: some View {
        VStack {
            HStack {
                Image(systemName: vm.getSunMoonImage().0)
                    .foregroundStyle(vm.getSunMoonImage().1)
                Text("Find some products for your routine")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)
            Spacer()
            Image(systemName: "waterbottle")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.gray)
                .frame(width: 60, height: 60)
            Button("Add Products", action: { selectedTab = 1 })
                .buttonStyle(.borderedProminent)
            Spacer()
            
        }
        .frame(height: 200)
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
        .background(Gradients.customGradientInverse)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}


#Preview {
    do {
        let previewer = try Previewer()
        
        return HomeView(selectedTab: .constant(0))
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
