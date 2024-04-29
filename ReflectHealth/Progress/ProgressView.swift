//
//  ProgressView.swift
//  ReflectHealth
//
//  Created by Martin on 24/04/2024.
//

import SwiftUI
import SwiftData
import PencilKit

struct ProgressView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var isDateRangePickerVisible = false
    
    @State private var sortOrder = SortDescriptor(\TrackedData.date, order: .reverse)
    @State private var startDate: Date = Calendar.current.startOfDay(for: Date()).addingTimeInterval(-86400 * 30) // 30 days ago
        @State private var endDate: Date = {
            let today = Calendar.current.startOfDay(for: Date())
            return Calendar.current.date(byAdding: .second, value: 86399, to: today)!
        }()  // End of today
    
    @Binding var selectedTab: Int
    
    var body: some View {
        NavigationStack {
            ProgressListingView(sort: sortOrder, startDate: startDate, endDate: endDate)
                .scrollContentBackground(.hidden)
                .navigationTitle("Your Progress")
                .navigationDestination(for: TrackedData.self) { trackedDataPiece in
                    EditTrackedDataView(trackDataPiece: trackedDataPiece)
                        .navigationBarBackButtonHidden()
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Track Progress", action: addSamples)
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu("Sort", systemImage: "arrow.up.arrow.down") {
                            Picker("Sort", selection: $sortOrder) {
                                Text("Ascending")
                                    .tag(SortDescriptor(\TrackedData.date, order: .forward))
                                Text("Descending")
                                    .tag(SortDescriptor(\TrackedData.date, order: .reverse))
                            }
                            .pickerStyle(.inline)
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            isDateRangePickerVisible = true
                        } label: {
                            Image(systemName: "calendar")
                        }
                    }
                }
                .sheet(isPresented: $isDateRangePickerVisible, content: {
                    DateRangePickerSheet(startDate: $startDate, endDate: $endDate, isPresented: $isDateRangePickerVisible)
                        .presentationDetents([.height(210)])
                        .presentationDragIndicator(.visible)
                })
                .scrollContentBackground(.hidden)
                .background(Gradients.customGradient)
        }
    }
    
    
    
    func addSamples() {
        selectedTab = 2
        let image1 = UIImage(named: "pikachu")!.pngData()!
        let image2 = UIImage(named: "charizard")!.pngData()!
        let image3 = UIImage(named: "rayquaza")!.pngData()!
        
        let notes = "These are sample notes, do not do anything with this dlaubculcxfncfluinh udfhcn xuiewfnxciuhe fiuhfx luie eyfg ihfux."
        
        let sample1 = TrackedData(date: .now.addingTimeInterval(-86400 * 7), image1: image1, image2: image2, image3: image3, notes: notes)
        let sample2 = TrackedData(date: .now.addingTimeInterval(-86400 * 30), image1: image2, image2: image3, image3: image1, notes: notes)
        let sample3 = TrackedData(date: .now.addingTimeInterval(-86400 * 30), image1: image3, image2: image1, image3: image2, notes: notes)
        let sample4 = TrackedData(image1: image3, image2: image1, image3: image2, notes: notes)
        
        modelContext.insert(sample1)
        modelContext.insert(sample2)
        modelContext.insert(sample3)
        modelContext.insert(sample4)
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        return ProgressView(selectedTab: .constant(0))
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
