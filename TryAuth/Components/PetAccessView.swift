//
//  PetAccessView.swift
//  TryAuth
//
//  Created by Admin on 14.07.2023.
//

import SwiftUI

struct PetAccessView: View {
    let initials: String
    let text: String
    var body: some View {
        NavigationLink {
            if initials != "+" {
                PetView()
            } else {
                PetRegistrationView()
            }
        } label: {
            HStack{
                Text(initials)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
                    .background(Color(.systemGray3))
                    .clipShape(Circle())
                
                Text(text)
                    .font(.title3)
            }
        }
    }
}

struct PetAccessView_Previews: PreviewProvider {
    static var previews: some View {
        PetAccessView(initials: "L", text: "Lucky")
    }
}
