//
//  User.swift
//  TryAuth
//
//  Created by Admin on 08.07.2023.
//

import Foundation

struct Pet: Identifiable, Codable {
    let id: String
    let fullName: String
    let Breed: String
    let weight: String
    let age: String
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        
        if let components = formatter.personNameComponents(from: fullName) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        
        return ""
    }
}


extension Pet {
    static var MOCK_PET = Pet(id: NSUUID().uuidString, fullName: "Lucky", Breed: "Siamese", weight: "3.5", age: "1")
}
