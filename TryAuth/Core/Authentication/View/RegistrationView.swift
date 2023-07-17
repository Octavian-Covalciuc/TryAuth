//
//  RegistrationView.swift
//  TryAuth
//
//  Created by Admin on 06.07.2023.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var fullName  = ""
    @State private var password  = ""
    @State private var confirmPassword  = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            
            Spacer()
            
            VStack (spacing: 24) {
                InputView(text: $email, title: "Email Address", placeHolder: "name@example.com")
                    .autocapitalization(.none)
                
                InputView(text: $fullName, title: "Full Name", placeHolder: "Enter your Name")
                    .autocapitalization(.none)
                
                InputView(text: $password, title: "Password", placeHolder: "Enter your password", isSecureField: true)
                    .autocapitalization(.none)
                
                ZStack (alignment: .trailing) {
                    InputView(text: $confirmPassword, title: "Confirm Password", placeHolder: "Confirm your password", isSecureField: true)
                        .autocapitalization(.none)
                    if !password.isEmpty {
                        if password == confirmPassword {
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemGreen))
                        } else {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemRed))
                        }
                    }
                }
            }
            .padding(.horizontal)
            
            Button{
                Task {
                    try await viewModel.createUser(withEmail: email, password: password, fullName: fullName)
                }
            } label: {
                HStack {
                    Text("Sign Up")
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
            
            Button {
                dismiss()
            } label: {
                HStack (spacing: 3) {
                    Text("Already have an acctount?")
                    Text("Sign In")
                        .fontWeight(.bold)
                }
                .font(.system(size: 14))
            }
        }
    }
}

extension RegistrationView: AutheticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && !fullName.isEmpty
        && confirmPassword == password
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
