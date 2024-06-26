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
            var exerciseWithID = exercise
            exerciseWithID.id = UUID().uuidString
            let encodedExercise = try Firestore.Encoder().encode(exerciseWithID)
            

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
                .document(exercise.id)
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
    
    
    func calcPr() {
        // calculate best weight for each exercise (use on home screen list)
    }
}


