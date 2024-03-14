//
//  LoginView.swift
//  SimplySetsiOS
//
//  Created by Andrew Blad on 3/8/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var showingError = false
    
    var body: some View {
        NavigationStack {
            VStack {
                // image
                Image("LoginImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .padding(.vertical, 32)
                
                // form fields
                VStack(spacing: 24) {
                    InputView(text: $email, title: "Email Address", placeHolder: "name@example.com")
                        .textInputAutocapitalization(.never)
                    
                    InputView(text: $password, title: "Password", placeHolder: "Enter your password", isSecureField: true)
                        .textInputAutocapitalization(.never)
                }
                .padding(.horizontal)
                .padding(.top, 20)
                
                // sign in button
                Button(action: {
                    Task {
                        try await authViewModel.signIn(email: email, password: password)
                        if authViewModel.signInError == true {
                            showingError = true
                        }
                    }
                }, label: {
                    HStack {
                        Text("SIGN IN")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundStyle(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                })
                .background(Color(.systemBlue))
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                .cornerRadius(10)
                .padding(.top, 24)
                .alert("ERROR: Failed to sign in", isPresented: $showingError) {
                    Button("OK", role: .cancel) {}
                }

                
                Spacer()
                
                // sign up button
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3) {
                        Text("Don't have an account?")
                        Text("Sign up")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }

            }
        }
    }
}

extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}
    

#Preview {
    LoginView()
}
