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

extension HomeView {
    internal var reflectTitle: some View {
        Text("Reflect")
            .font(.largeTitle)
            .fontDesign(.serif)
            .fontWeight(.semibold)
            .foregroundStyle(.lightBlue1)
    }
    
    internal var header: some View {
        HStack {
            VStack(alignment: .leading) {
                Group {
                    Text("Hello").fontWeight(.light) + Text(" ") + Text(vm.user.firstName).fontWeight(.semibold)
                }
                .font(.largeTitle)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
                .padding(.trailing)
                
                
                Text("@\(vm.user.username)")
                    .font(.caption)
                    .fontWeight(.light)
            }
            Spacer()
            ZStack(alignment: .bottomTrailing){
                
                if let profileImage = vm.user.profileImage {
                    Image(uiImage: profileImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                }
                else {
                    Image(systemName: "person.circle.fill")
                        .symbolRenderingMode(.multicolor)
                        .resizable()
                        .scaledToFill()
                        .foregroundStyle(Color("light-blue-5"))
                        .frame(width: 100, height: 100)
                }
                
                NavigationLink {
                    EditProfileView(vm: $vm)
                } label: {
                    Image(systemName: vm.user.profileImage != nil ? "person.circle.fill" : "gear.circle.fill")
                        .symbolRenderingMode(.palette)
                        .resizable()
                        .scaledToFill()
                        .foregroundStyle(.white, .accent)
                        .font(.system(size: 12))
                        .frame(width: 30, height: 30)
                }
            }
        }
        .padding()
        
    }
    
    internal var routine: some View {
        VStack {
            HStack {
                Image(systemName: vm.getSunMoonImage().0)
                    .foregroundStyle(vm.getSunMoonImage().1)
                Text("Find some products for your routine")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Spacer()
            }
            .padding()
            Spacer()
            Image(systemName: "waterbottle")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.gray)
                .frame(width: 60, height: 60)
            Spacer()
            Button("Add Products", action: { selectedTab = 1 })
                .buttonStyle(CapsuleButtonStyle())
            Spacer()
        }
        .frame(height: 200)
        .frame(maxWidth: .infinity)
        .background(.lightBlue8)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .padding()
    }
    
    @ViewBuilder
    internal var lastTrack: some View {
        if let lastTrack = trackedDataPieces.first,
           let image1 = UIImage(data: lastTrack.image1),
           let image2 = UIImage(data: lastTrack.image2),
           let image3 =  UIImage(data: lastTrack.image3) {
            
            ZStack(alignment: .top) {
                TabView {
                    ImageLabel(image: image1, drawingData: lastTrack.drawing1)
                    ImageLabel(image: image2, drawingData: lastTrack.drawing2)
                    ImageLabel(image: image3, drawingData: lastTrack.drawing3)
                }
                .frame(width: 350, height: 400)
                .tabViewStyle(.page)
                Text(lastTrack.date.formatted(date: .long, time: .shortened))
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 32))
                    .padding(.vertical)
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(.lightBlue8)
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .padding()
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
                .padding()
                Spacer()
                Image(systemName: "person.crop.square.badge.camera")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.gray)
                    .frame(width: 60, height: 60)
                Spacer()
                Button("Track", action: { selectedTab = 2 })
                    .buttonStyle(CapsuleButtonStyle())
                Spacer()
            }
            .frame(height: 200)
            .frame(maxWidth: .infinity)
            .background(.lightBlue8)
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .padding()
        }
    }
    
    @ViewBuilder
    func ImageLabel(image: UIImage, drawingData: Data?) -> some View {
        ZStack {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 16.0))
            
            if let safeData = drawingData {
                if let drawingImage = UIImage(data: safeData) {
                    Image(uiImage: drawingImage)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 16.0))
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
