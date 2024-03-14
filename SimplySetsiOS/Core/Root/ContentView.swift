//
//  ContentView.swift
//  SimplySetsiOS
//
//  Created by Andrew Blad on 3/8/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    
    var body: some View {
        Group {
            if authViewModel.userSession != nil {
                RootView()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
