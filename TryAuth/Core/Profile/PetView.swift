//
//  PetView.swift
//  TryAuth
//
//  Created by Admin on 13.07.2023.
//

import SwiftUI

struct PetView: View {
    var body: some View {
        List {
            Section ("Pet Info") {
                HStack {
                    VStack {
                        Text(Pet.MOCK_PET.initials)
                            .font(.system(size: 70))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 100, height: 100)
                            .background(Color(.systemGray3))
                            .clipShape(Circle())
                        
                        Text(Pet.MOCK_PET.fullName)
                            .fontWeight(.semibold)
                            .font(.title)
    
                    }
                    .padding(.top, 30)
                    
                    VStack (alignment: .leading) {
                        Text("Weight: \(Pet.MOCK_PET.weight) kg")
                            .fontWeight(.semibold)
                        Text("Age: \(Pet.MOCK_PET.age) years")
                            .fontWeight(.semibold)
                        Text(Pet.MOCK_PET.Breed)
                            .fontWeight(.semibold)
                    }
                    .padding(.leading, 15)
                }
            }
            
            Spacer()
            
            Section ("Edit") {
                Button {
                    print("Deleting..")
                } label: {
                    SettingsRowView(imageName: "xmark.circle.fill", title: "Delete Pet", tintColor: Color(.red))
                }
            }
        }
    }
}

struct PetView_Previews: PreviewProvider {
    static var previews: some View {
        PetView()
    }
}
