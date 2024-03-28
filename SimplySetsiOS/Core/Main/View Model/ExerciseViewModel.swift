//
//  ExerciseViewModel.swift
//  SimplySetsiOS
//
//  Created by Andrew Blad on 3/22/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class ExerciseViewModel: ObservableObject {
    @Published var exercises: [Exercise] = []
    private var userUid: String?

    init() {
        // Listen for authentication changes to get the user's UID
        Auth.auth().addStateDidChangeListener { [weak self] (_, user) in
            guard let user = user else { return }
            self?.userUid = user.uid
            self?.fetchExercises()
        }
    }

    // Method to save exercise to Firestore
    func saveExercise(_ exercise: Exercise) async {
        guard let userUid = userUid else { return }
        do {
            var exerciseWithID = exercise // Create a mutable copy of the exercise
            exerciseWithID.id = UUID().uuidString // Set the id explicitly
            let encodedExercise = try Firestore.Encoder().encode(exerciseWithID)
            
            // Set data at the specified collection path with the explicitly set ID
            try await Firestore.firestore()
                .collection("users").document(userUid)
                .collection("exercises")
                .document(exerciseWithID.id)
                .setData(encodedExercise)
        } catch {
            print("DEBUG: Failed to save exercise with error \(error.localizedDescription)")
        }
    }

    func updateExercise(_ exercise: Exercise) async {
        guard let userUid = userUid else { return }
        do {
            let encodedExercise = try Firestore.Encoder().encode(exercise)
            
            // Update the entire document with the modified exercise data
            try await Firestore.firestore()
                .collection("users")
                .document(userUid)
                .collection("exercises")
                .document(exercise.id) // Use the exercise's ID to identify the document
                .setData(encodedExercise)
            fetchExercises()
        } catch {
            print("DEBUG: Failed to update exercise with error \(error.localizedDescription)")
        }
    }


    // Method to fetch exercises from Firestore
    func fetchExercises() {
        guard let userUid = userUid else { return }
        Firestore.firestore().collection("users").document(userUid).collection("exercises").addSnapshotListener { [weak self] (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("DEBUG: Error fetching documents: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            self?.exercises = documents.compactMap { queryDocumentSnapshot in
                try? queryDocumentSnapshot.data(as: Exercise.self)
            }
        }
    }
    
//    func chartDataForExercise(_ exercise: Exercise) -> [(x: Double, y: Double)] {
//         var chartData: [(x: Double, y: Double)] = []
//         
//         // Extract sets data from the exercise
//         guard let sets = exercise.sets else {
//             return chartData
//         }
//         
//         // Sort sets by date
//         let sortedSets = sets.sorted(by: { $0.date < $1.date })
//         
//         // Iterate through sorted sets and add them to chartData
//         for set in sortedSets {
//             let x = Double(set.date.timeIntervalSince1970) // Convert date to Double
//             let y = Double(set.weight) // Assuming weight is what you want to plot
//             chartData.append((x: x, y: y))
//         }
//         
//         return chartData
//     }
    
    func calcPr() {
        // calculate best weight for each exercise (use on home screen list)
    }
}


