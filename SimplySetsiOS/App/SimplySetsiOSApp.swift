//
//  SimplySetsiOSApp.swift
//  SimplySetsiOS
//
//  Created by Andrew Blad on 3/8/24.
//

import SwiftUI
import Firebase

@main
struct SimplySetsiOSApp: App {
    @StateObject var authViewModel = AuthViewModel()
    @StateObject var exerciseViewModel = ExerciseViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
                .environmentObject(exerciseViewModel)
        }
    }
}
