//
//  HomeView.swift
//  SimplySetsiOS
//
//  Created by Andrew Blad on 3/13/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
//                Color("")
//                    .ignoresSafeArea()
                VStack {
                    
                    HStack {
                        Text("Exercises")
                            .bold()
                            .font(.system(size: 20))
                        Image(systemName: "chevron.down")
                            .bold()
                    }
                    
                    Spacer()
                    
                        Text("Click the \"Add Exercise\" button to ceate your first Exercise.")
                            .multilineTextAlignment(.center)
                            .opacity(0.5)
                            .padding(50)
    
                    Spacer()
                    
                    Button(action: {
                        
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
            }
        }
    }
}

#Preview {
    HomeView()
}
