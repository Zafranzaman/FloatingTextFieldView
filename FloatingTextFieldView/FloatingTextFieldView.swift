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
    var height: CGFloat
    var titleFontWeight: Font.Weight = .semibold
    var textFontSize: CGFloat = 16
    var textFontWeight: Font.Weight = .regular
    var isSecureField: Bool = false
    var showClearButton: Bool = false
    var isDropdownField: Bool = false

    @State private var isSecured: Bool = true
    @State private var isEditing: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            ZStack(alignment: .leading) {
                // Floating label
                Text(title)
                    .font(.caption)
                    .fontWeight(titleFontWeight)
                    .foregroundColor(.tintPrimary50)
                    .background(Color.white.opacity(0.2))
                    .padding(.horizontal, 10)
                    .background(Color.white)
                    .offset(y: (!text.isEmpty || isEditing) ? -18 : 0)
                    .scaleEffect((!text.isEmpty || isEditing) ? 0.8 : 1, anchor: .leading)
                    .animation(.easeInOut(duration: 0.2), value: !text.isEmpty || isEditing)

                HStack {
                    if isDropdownField {
                        // Add dropdown icon or button here
                        Image(systemName: "chevron.down")
                            .foregroundColor(.tintPrimary)
                    }

                    if isSecureField && isSecured {
                        SecureField("", text: $text)
                            .font(.system(size: textFontSize, weight: textFontWeight))
                            .onTapGesture {
                                isEditing = true
                            }
                            .onChange(of: text) { newValue in
                                if newValue.isEmpty {
                                    isEditing = false
                                }
                            }
                    } else {
                        TextField("", text: $text, onEditingChanged: { editing in
                            isEditing = editing
                        })
                        .font(.system(size: textFontSize, weight: textFontWeight))
                        
                    }

                    if isSecureField {
                        Button(action: {
                            isSecured.toggle()
                        }) {
                            Image(systemName: isSecured ? "eye.slash" : "eye")
                                .foregroundColor(.tintPrimary)
                        }
                    }

                    if showClearButton && !text.isEmpty {
                        Button(action: {
                            self.text = ""
                        }) {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(.tintPrimary50)
                        }
                        .padding(.trailing, 10)
                    }
                }
                .frame(height: height) // Use the custom height for the text field
                .padding(EdgeInsets(top: 5, leading: 10, bottom: -6, trailing: 10))
                .background(RoundedRectangle(cornerRadius: 10).stroke(isEditing ? Color.primaryBg : Color.tintPrimary50, lineWidth: 2))
                .background(Color.tintPrimary50.opacity(0.1))
                .cornerRadius(10)
                
            }
        }
        .padding(.vertical, 0)
    }
}

#Preview {
    FloatingTextFieldView(
        text: .constant(""),
        title: "Enter Email",
        height: 50,
        textFontSize: 14,
        textFontWeight: .semibold,
        isSecureField: true,
        showClearButton: true
    )
    .padding(.horizontal)
}
