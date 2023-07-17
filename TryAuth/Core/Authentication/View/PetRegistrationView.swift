//
//  PetRegistrationView.swift
//  TryAuth
//
//  Created by Admin on 13.07.2023.
//

import SwiftUI

struct PetRegistrationView: View {
    @State private var fullName = ""
    @State private var breed  = ""
    @State private var weight  = ""
    @State private var age  = ""
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            Text("Register A New Pet")
                .fontWeight(.bold)
                .font(.largeTitle)
                .padding(.top, 50)
            
            Spacer()
            
            VStack (spacing: 24) {
                InputView(text: $fullName, title: "Full Name", placeHolder: "Enter Pet Name")
                    .autocapitalization(.none)
                
                InputView(text: $breed, title: "Breed", placeHolder: "Enter Pet Breed")
                    .autocapitalization(.none)
                
                InputView(text: $weight, title: "Weight", placeHolder: "Enter Pet Weight")
                    .autocapitalization(.none)
                
                InputView(text: $age, title: "Age", placeHolder: "Enter Pet's Age")
            }
            .padding(.horizontal)
            
            Spacer()
            
            Button{
                Task {
                    try await viewModel.registerPet(fullName: fullName, breed: breed, weight: weight, age: age)
                }
            } label: {
                HStack {
                    Text("Add Pet")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            }
            .background(Color(.systemBlue))
            .cornerRadius(10)
            .padding(.top, 34)
            .padding(.bottom, 60)
            
        }
    }
}

struct PetRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        PetRegistrationView()
    }
}
