//
//  SliderView.swift
//  ColorizedSwiftUI
//
//  Created by Leonid on 02.11.2025.
//

import SwiftUI

struct ColorSliderView: View {
    let tint: Color
    
    @Binding var value: Int
    
    @State private var input = ""
    @FocusState private var inputFocused: Bool
    
    var body: some View {
        HStack {
            Text("\(value)")
                .font(.title2)
                .frame(width: 40, alignment: .leading)
                .foregroundStyle(.white)
                
            Slider(
                value: Binding(
                    get: { Double(value) },
                    set: { value = Int($0.rounded()) }
                ),
                in: 0...255,
                step: 1
                )
                .tint(tint)
                .onChange(of: value) {
                    input = String(value)
                }
                .animation(.easeInOut(duration: 0.25), value: value)
                
            TextField("Enter", text: $input)
                .textFieldStyle(.roundedBorder)
                .frame(width: 65, alignment: .trailing)
                .font(.title2)
                .keyboardType(.numberPad)
                .submitLabel(.done)
                .multilineTextAlignment(.trailing)
                .focused($inputFocused)
                .onSubmit { applyTextToValue() }
                
        }
        .padding(.horizontal, 16)
        .contentShape(Rectangle())
        .onAppear { syncTextFromValue() }
        .onChange(of: inputFocused) { _, isFocused in
            if !isFocused { applyTextToValue() }
        }
    }
    
    private func syncTextFromValue() {
        input = String(value)
    }
    
    private func applyTextToValue() {
        let typed = Int(input) ?? value
        let clamped = min(max(typed, 0), 255)
        
        withAnimation(.easeInOut(duration: 0.25)) {
            value = clamped
        }
        input = String(value)
    }
}

#Preview {
    ColorSliderView(tint: .red, value: .constant(128))
}
