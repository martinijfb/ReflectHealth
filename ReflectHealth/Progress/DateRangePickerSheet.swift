//
//  TestDateRange.swift
//  ReflectHealth
//
//  Created by Martin on 25/04/2024.
//

import SwiftUI

struct DateRangePickerSheet: View {
    @Binding var startDate: Date
    @Binding var endDate: Date
    @Binding var isPresented: Bool
    
    var body: some View {
        let today = Calendar.current.startOfDay(for: Date())
        
        VStack {
            Text("Select a Date Range")
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.vertical)
            
            DatePicker(
                "Start Date",
                selection: $startDate,
                in: ...Date(), // Limit to today and earlier
                displayedComponents: .date
            )
            .datePickerStyle(.compact) // Adjust style to suit
            .onChange(of: startDate) {
                // Set startDate to the beginning of the selected day
                startDate = Calendar.current.startOfDay(for: startDate)
                print("Start Date:", startDate.formatted(date: .long, time: .shortened))
                
                // If startDate is today, set endDate to the end of today
                if startDate == today {
                    let endOfToday = Calendar.current.date(byAdding: .second, value: 86399, to: today)!
                    endDate = endOfToday
                    print("End Date (end of today):", endDate.formatted(date: .long, time: .shortened))
                }
            }
            
            DatePicker(
                "End Date",
                selection: $endDate,
                in: startDate...Date(), // Ensure end date is not before start date
                displayedComponents: .date
            )
            .datePickerStyle(.compact)
            .onChange(of: endDate) {
                // Set endDate to the end of the selected day
                let endOfDay = Calendar.current.date(byAdding: .second, value: 86399, to: Calendar.current.startOfDay(for: endDate))!
                endDate = endOfDay
                print("End Date:", endDate.formatted(date: .long, time: .shortened))
            }
            
            Spacer()
            
            Button("Done") {
                isPresented = false // Dismiss the sheet
            }
            .padding()
        }
        .padding()
        .background(.ultraThinMaterial)
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
