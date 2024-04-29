//
//  LastProgressView.swift
//  ReflectHealth
//
//  Created by Martin on 29/04/2024.
//

import SwiftUI
import SwiftData

//struct LastProgressView: View {
//    
//    @Environment(\.modelContext) var modelContext
//    @Query(sort: \TrackedData.date, order: .reverse) var trackedDataPieces: [TrackedData]
//    
//    var body: some View {
//        
//        if let lastTrack = trackedDataPieces.first {
//            Text(lastTrack.date.formatted(date: .long, time: .shortened))
//            let image1 = UIImage(data: lastTrack.image1),
//               let image2 = UIImage(data: lastTrack.image2),
//               let image3 =  UIImage(data: lastTrack.image3){
//                
//                TabView {
//                    Group {
//                        ZStack {
//                            Image(uiImage: image1)
//                                .resizable()
//                            if let drawingData1 = lastTrack.drawing1 {
//                                if let drawingImage1 = UIImage(data: drawingData1) {
//                                    Image(uiImage: drawingImage1)
//                                }
//                            }
//                        }
//                            
//                        
//                        ZStack {
//                            Image(uiImage: image2)
//                                .resizable()
//                            if let drawingData2 = lastTrack.drawing2 {
//                                if let drawingImage2 = UIImage(data: drawingData2) {
//                                    Image(uiImage: drawingImage2)
//                                }
//                            }
//                        }
//                            
//                        
//                        ZStack {
//                            Image(uiImage: image3)
//                                .resizable()
//                            if let drawingData3 = lastTrack.drawing3 {
//                                if let drawingImage3 = UIImage(data: drawingData3) {
//                                    Image(uiImage: drawingImage3)
//                                }
//                            }
//                        }
//                    }
//                    .scaledToFit()
//                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
//                }
//                .frame(maxHeight: 300)
//                .tabViewStyle(.page(indexDisplayMode: .always))
//                
//            } else {
//                Text("Could not load the images")
//            }
//        }
// 
//    }
//}
//
//#Preview {
//    do {
//        let previewer = try Previewer()
//        return LastProgressView()
//            .modelContainer(previewer.container)
//    } catch {
//        return Text("Failed to create preview: \(error.localizedDescription)")
//    }
//}
