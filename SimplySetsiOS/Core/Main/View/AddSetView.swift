//
//  AddSetView.swift
//  SimplySetsiOS
//
//  Created by Andrew Blad on 3/27/24.
//

import SwiftUI

struct AddSetView: View {
    @EnvironmentObject var exerciseViewModel: ExerciseViewModel
    @Binding var exercise: Exercise
    @State private var reps = ""
    @State private var weight = ""
    @Binding var isPresented: Bool
    var body: some View {
        VStack {
            HStack {
                Text("Add Set")
                    .bold()
                    .font(.system(size: 20))
                Image(systemName: "chevron.down")
                    .bold()
            }
            .padding(.top, 20)
            
            Spacer()
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Weight")
                        .bold()
                        .font(.system(size: 20))
                    Image(systemName: "chevron.down")
                        .bold()
                }
                
                TextField("Enter weight (lbs)", text: $weight)
                    .padding()
                    .background(Color.secondary.opacity(0.1))
                    .cornerRadius(8)
                    .keyboardType(.numberPad)
                    .foregroundColor(.primary)
                
                HStack {
                    Text("Reps")
                        .bold()
                        .font(.system(size: 20))
                    Image(systemName: "chevron.down")
                        .bold()
                }
                
                TextField("Enter reps", text: $reps)
                    .padding()
                    .background(Color.secondary.opacity(0.1))
                    .cornerRadius(8)
                    .keyboardType(.numberPad)
                    .foregroundColor(.primary)
            }
            .padding()
            .cornerRadius(10)

            Button(action: {
//                var excer = Exercise(name: "Bench Press")
//                excer.addSet(reps: 10, weight: 20)
                
                if let repsInt = Int(reps), let weightInt = Int(weight) {
                    // Both reps and weight are successfully converted to integers
                    exercise.addSet(reps: repsInt, weight: weightInt)
                    Task {
                        await exerciseViewModel.updateExercise(exercise)
                    }
                    exerciseViewModel.fetchExercises()
                    isPresented = false
                } else {
                    // Handle the case where conversion fails
                    print("Invalid input for reps or weight.")
                }
            }, label: {
                Text("Add")
                    .foregroundColor(.white)
                    .frame(width: 150, height: 40)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding()
                    .font(.system(size: 18))
            })
            
            Spacer()
        }
    }
}


