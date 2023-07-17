//
//  LogInView.swift
//  TryAuth
//
//  Created by Admin on 06.07.2023.
//

import SwiftUI

struct LogInView: View {
    @State private var email = ""
    @State private var password  = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            VStack (spacing: 24) {
                InputView(text: $email, title: "Email Address", placeHolder: "name@example.com")
                    .autocapitalization(.none)
                InputView(text: $password, title: "Password", placeHolder: "Enter your password", isSecureField: true)
                    .autocapitalization(.none)
            }
            .padding(.horizontal)
            .padding(.top, 220)
            
            Button{
                Task {
                    try await viewModel.signIn(withEmail: email, password: password)
                }
            } label: {
                HStack {
                    Text("Sign In")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            }
            .background(Color(.systemBlue))
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0 : 0.5)
            .cornerRadius(10)
            .padding(.top, 34)
            
            Spacer()
            
            NavigationLink {
                RegistrationView()
                    .navigationBarBackButtonHidden(true)
            } label: {
                HStack (spacing: 3) {
                    Text("Don't have an account?")
                    Text("Sign Up")
                        .fontWeight(.bold)
                }
                .font(.system(size: 14))
            }
            
        }
    }
}

extension LogInView: AutheticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
