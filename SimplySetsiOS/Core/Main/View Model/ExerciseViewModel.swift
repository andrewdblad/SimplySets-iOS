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
            // Encode the exercise data
            let encodedExercise = try Firestore.Encoder().encode(exercise)
            
            // Set data at the specified collection path
            try await Firestore.firestore()
                .collection("users").document(userUid)
                .collection("exercises") // Nested collection
                .document() // Firestore will generate a unique document ID
                .setData(encodedExercise)
        } catch {
            print("DEBUG: Failed to save exercise with error \(error.localizedDescription)")
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
