//
//  MainView.swift
//  SimplySetsiOS
//
//  Created by Andrew Blad on 3/13/24.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem() {
                    Image(systemName: "house.fill")
                }
            
            ProfileView()
                .tabItem() {
                    Image(systemName: "gear")
                }
        }
    }
}

#Preview {
    RootView()
}
