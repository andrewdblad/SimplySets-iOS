//
//  HomeView.swift
//  SimplySetsiOS
//
//  Created by Andrew Blad on 3/13/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var exerciseViewModel: ExerciseViewModel
    @State private var isAddingExercise = false
    @State private var exerciseName = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    HStack {
                        Image("")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding(.leading, 10)
                        Spacer()
                        
                        Text("Exercises")
                            .bold()
                            .font(.system(size: 20))
                        
                        Image(systemName: "chevron.down")
                            .bold()
                            .onAppear {
                                // Call fetchExercises when the view appears
                                exerciseViewModel.fetchExercises()
                            }
                        
                        Spacer()
                        
                        NavigationLink(destination: ProfileView()) { // Use NavigationLink for navigation
                            Image(systemName: "gear")
                                .resizable()
                                .frame(width: 30, height: 30)
//                                .foregroundStyle(Color(.black))
                        }
                        .padding(.trailing, 10)
                    }
                    
                    Spacer()
                    
                    if exerciseViewModel.exercises.isEmpty {
                        Text("Click the \"Add Exercise\" button to create your first Exercise.")
                            .multilineTextAlignment(.center)
                            .opacity(0.5)
                            .padding(50)
                    } else {
                        // Display the exercises as list items with NavigationLink
                        List {
                            ForEach(exerciseViewModel.exercises) { exercise in
                                NavigationLink(destination: SetsView(exercise: exercise)) {
                                    Text(exercise.name)
                                        .padding(.vertical, 8)
                                }
                            }
                        }
                    }


    
                    Spacer()
                    
                    Button(action: {
                        isAddingExercise = true
                    }, label: {
                        Text("Add Exercise")
                            .foregroundColor(.white)
                            .frame(width: 150, height: 40)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding()
                            .font(.system(size: 18))
                    })
                }
                .alert("", isPresented: $isAddingExercise, actions: {
                    TextField("Exercise name", text: $exerciseName)


                    Button("Add", action: {Task{await addExercise()}})
                    Button("Cancel", role: .cancel, action: {})
                }, message: {
                    Text("Please enter the name of your exercise.")
                })
            }
        }
    }
    
    func addExercise() async {
        let newExercise = Exercise(name: exerciseName.capitalized) // Declare newExercise as var
        await exerciseViewModel.saveExercise(newExercise)
        // Reset exerciseName for next input
        exerciseName = ""
        // Dismiss the alert
        isAddingExercise = false
    }

}
#Preview {
    HomeView()
}
