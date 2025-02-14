//
//  ContentView.swift
//  FloatingTextFieldView
//
//  Created by Zafran on 02/07/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            Text("Login")
                
                .padding()
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.primaryBg)
            FloatingTextFieldView(
                text: $email,
                title: "Email",
                isSecureField: false
            )
            .padding()
            
            FloatingTextFieldView(
                text: $password,
                title: "New Password",
                isSecureField: true
            )
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
