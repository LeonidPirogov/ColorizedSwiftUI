//
//  TextFieldView.swift
//  ColorizedSwiftUI
//
//  Created by Leonid on 04.11.2025.
//

import SwiftUI

struct TextFieldView: View {
    @Binding var text: String
    
    let action: () -> Void
    
    var body: some View {
        TextField("0", text: $text) { _ in
                withAnimation {
                action()
            }
        }
        .frame(width: 55, alignment: .trailing)
        .multilineTextAlignment(.trailing)
        .textFieldStyle(.roundedBorder)
        .keyboardType(.numberPad)
    }
}

#Preview {
    ZStack {
        Color.background
        TextFieldView(text: .constant("128"), action: {})
    }
}
