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
                height: 55,
                textFontSize: 14,
                textFontWeight: .semibold,
                isSecureField: false,
                showClearButton: true
            )
            .padding()
            
            FloatingTextFieldView(
                text: $password,
                title: "Password",
                height: 55,
                textFontSize: 18,
                textFontWeight: .medium,
                isSecureField: true,
                showClearButton: true
            )
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
