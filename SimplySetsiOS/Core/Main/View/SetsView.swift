//
//  SetsView.swift
//  SimplySetsiOS
//
//  Created by Andrew Blad on 3/22/24.
//

import SwiftUI
import Charts

struct SetsView: View {
    @EnvironmentObject var exerciseViewModel: ExerciseViewModel
    @State var exercise: Exercise
    @State private var isPresented = false
    let previewData: [PreviewData] = [
        .init(date: Date(), weight: 5),
        .init(date: Date(), weight: 10)
    ]
    var groupedSets: [String: [ExerciseSet]] {
        let sortedSets = (exercise.sets ?? []).sorted(by: { $0.date > $1.date })
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return Dictionary(grouping: sortedSets) { set in
            dateFormatter.string(from: set.date)
        }
    }

    var body: some View {
        VStack {
            HStack {
                Text(exercise.name)
                    .bold()
                    .font(.system(size: 20))
                Image(systemName: "chevron.down")
                    .bold()
            } .padding(.top, -35)
            
            
            if exercise.sets == nil {
                Spacer()
                Text("Click the \"Add Set\" button to create your first set.")
                    .multilineTextAlignment(.center)
                    .opacity(0.5)
                    .padding(50)
                Spacer()
            } else {
                
                Chart {
                    ForEach(exercise.sets ?? []) { exerciseSet in
                        LineMark(x: .value("Month", exerciseSet.date), y: .value("Weight", exerciseSet.weight))
                    }
                }
                List {
                    ForEach(groupedSets.keys.sorted(by: >), id: \.self) { date in
                        Section(header: Text(date)) {
                            ForEach(groupedSets[date] ?? [], id: \.self) { set in
                                LazyVStack {
                                    HStack {
                                        Text("\(set.reps) reps")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        Spacer()
                                        Text("\(set.weight) lbs")
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                    }
                                }
                                .cornerRadius(8)
                                .padding(.horizontal)
                            }
                        }
                    }
                }


            }

            Button(action: {
                isPresented.toggle()
            }, label: {
                Text("Add Set")
                    .foregroundColor(.white)
                    .frame(width: 150, height: 40)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding()
                    .font(.system(size: 18))
                    .onAppear {
                        // Call fetchExercises when the view appears
                        exerciseViewModel.fetchExercises()
                    }
            })
            

        }
        .sheet(isPresented: $isPresented) {
            AddSetView(exercise: $exercise, isPresented: $isPresented)
                .presentationDetents([.medium])
        }
    }
}

struct PreviewData: Identifiable {
    var id = UUID()
    var date: Date
    var weight: Int
}







