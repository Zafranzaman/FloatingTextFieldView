//
//  FloatingTextFieldView.swift
//  FloatingTextFieldView
//
//  Created by Zafran on 02/07/2024.
//

import SwiftUI

struct FloatingTextFieldView: View {
    @Binding var text: String
    var title: String
    var height: CGFloat = 60
    var titleFontWeight: Font.Weight = .semibold
    var textFontSize: CGFloat = 16
    var textFontWeight: Font.Weight = .semibold
    var isSecureField: Bool = false
    var isDropdownField: Bool = false
    
    @State private var showClearButton: Bool = false
    @State private var isSecured: Bool = false
    @State private var isEditing: Bool = false
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            // Background with stroke and fill
            RoundedRectangle(cornerRadius: 10)
                .stroke(isEditing ? Color.primaryBg : .tintPrimary50.opacity(0.1), lineWidth: 2)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                )
                .frame(height: height)
            
            // Floating label
            Text(title)
                .font(.system(size: isEditing ? 12 : 14, weight: .semibold))
                .foregroundColor(.tintPrimary50)
                .background(Color.clear)
                .padding(.horizontal, isEditing ? 16 : 14)
                .offset(y: (!text.isEmpty || isEditing) ? -height / 2 + 16 : 0)
                .scaleEffect((!text.isEmpty || isEditing) ? 0.857 : 1, anchor: .leading)
                .animation(.easeInOut(duration: 0.2), value: !text.isEmpty || isEditing)
            
            // TextField/SecureField and icons
            HStack {
                if isDropdownField {
                    // Add dropdown icon or button here
                    Image(systemName: "chevron.down")
                        .foregroundColor(.tintPrimary50)
                }
                
                if isSecureField {
                    if isSecured {
                        SecureField("", text: $text)
                            .font(.system(size: textFontSize, weight: .semibold))
                            .focused($isFocused)
                            .padding(.top, (!text.isEmpty || isEditing) ? 10 : 0)
                            .onTapGesture {
                                isEditing = true
                            }
                            .onChange(of: text) { newValue in
                                if newValue.isEmpty {
                                    showClearButton = true
                                    isEditing = false
                                }
                            }
                    } else {
                        TextField("", text: $text, onEditingChanged: { editing in
                            isEditing = editing
                            showClearButton = true
                        })
                        .font(.system(size: textFontSize, weight: .semibold))
                        .focused($isFocused)
                        .padding(.top, (!text.isEmpty || isEditing) ? 10 : 0)
                    }
                } else {
                    TextField("", text: $text, onEditingChanged: { editing in
                        isEditing = editing
                        showClearButton = true
                    })
                    .font(.system(size: textFontSize, weight: .semibold))
                    .focused($isFocused)
                    .padding(.top, (!text.isEmpty || isEditing) ? 10 : 0)
                }
                
                if isSecureField {
                    Button(action: {
                        isSecured.toggle()
                    }) {
                        Image(systemName: isSecured ? "eye.slash" : "eye")
                            .foregroundColor(.tintPrimary50)
                    }
                }
                
                if showClearButton {
                    if !text.isEmpty {
                        Button(action: {
                            showClearButton = false
                            self.text = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.tintPrimary50)
                        }
                    }
                }
            }
            .padding(.horizontal, 14)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

struct FloatingTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        FloatingTextFieldView(
            text: .constant(""),
            title: "New Password",
            isSecureField: true
        )
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
