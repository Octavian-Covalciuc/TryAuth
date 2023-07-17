//
//  TryAuthApp.swift
//  TryAuth
//
//  Created by Admin on 06.07.2023.
//

import SwiftUI
import Firebase

@main
struct TryAuthApp: App {
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
 
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
