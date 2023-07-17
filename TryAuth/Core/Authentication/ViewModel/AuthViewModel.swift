//
//  AuthViewModel.swift
//  TryAuth
//
//  Created by Admin on 08.07.2023.
//

import SwiftUI
import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol AutheticationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var pets: [Pet] = []
    @Environment(\.presentationMode) var presentationMode
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
            await fetchPet()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
            await fetchPet()
        } catch {
            print("DEBUG: failed to log in with error \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, password: String, fullName: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullName: fullName, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func registerPet(fullName: String, breed: String, weight: String, age: String) async throws {
        guard let userID = userSession?.uid else {
            print("// No user session available")
            return
        }
        
        let document = Firestore.firestore().collection("users").document(userID).collection("pets").document()
        
        let pet = Pet(id: document.documentID, fullName: fullName, Breed: breed, weight: weight, age: age)
        let encodedPet = try Firestore.Encoder().encode(pet)
        try await document.setData(encodedPet)
        await fetchPet()
        
        print("Pet registered :)")
        
        presentationMode.wrappedValue.dismiss()
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() {
        
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {return}
        self.currentUser = try? snapshot.data(as: User.self)
    }
    
    func fetchPet() async {
        guard let userID = userSession?.uid else {
            print("// No user session available")
            return
        }
        
        do {
            let querySnapshot = try await Firestore.firestore()
                .collection("users")
                .document(userID)
                .collection("pets")
                .getDocuments()
            
            pets = querySnapshot.documents.compactMap { document in
                try? document.data(as: Pet.self)
            }
            
            print("Fetched pet data: \(pets)")
        } catch {
            print("Error fetching pet data: \(error.localizedDescription)")
        }
    }
}
