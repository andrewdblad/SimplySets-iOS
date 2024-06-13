//
//  Workout.swift
//  SimplySetsiOS
//
//  Created by Andrew Blad on 3/22/24.
//
import Firebase
import Foundation

import Foundation

struct Exercise: Identifiable, Codable {
    var id: String
    var name: String
    var sets: [ExerciseSet]?
    
    
    init(name: String) {
        self.id = UUID().uuidString // Generate a random ID
        self.name = name
        self.sets = nil
    }
    
    mutating func addSet(reps: Int, weight: Int) {
        // Ensure sets is initialized before appending to it
        if self.sets == nil {
            self.sets = []
        }
        let exerciseSet = ExerciseSet(reps: reps, weight: weight, date: Date())
        self.sets?.append(exerciseSet)
    }

}


struct ExerciseSet: Identifiable, Codable, Hashable {
    var id: String
    var reps: Int
    var weight: Int
    var date: Date
    
    init(id: String = UUID().uuidString, reps: Int, weight: Int, date: Date) {
        self.id = id
        self.reps = reps
        self.weight = weight
        self.date = date
    }
}







