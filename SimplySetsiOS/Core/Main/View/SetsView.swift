//
//  SetsView.swift
//  SimplySetsiOS
//
//  Created by Andrew Blad on 3/22/24.
//

import SwiftUI

struct SetsView: View {
    var exercise: Exercise
    var body: some View {
        VStack {
            HStack {
                Text(exercise.name)
                    .bold()
                    .font(.system(size: 20))
                Image(systemName: "chevron.down")
                    .bold()
            } .padding(.top, -35)
            
            Spacer()
            

        }
    }
}

#Preview {
    SetsView(exercise: Exercise(name: "Bench Press"))
}

