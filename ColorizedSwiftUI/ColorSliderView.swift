//
//  SliderView.swift
//  ColorizedSwiftUI
//
//  Created by Leonid on 02.11.2025.
//

import SwiftUI

struct ColorSliderView: View {
    
    @Binding var value: Double
    let color: Color
    
    @State private var text = ""
    @State private var showAlert = false
    
    var body: some View {
        HStack {
            Text(value.formatted(.number.precision(.fractionLength(0))))
                .frame(width: 40, alignment: .leading)
                .foregroundStyle(.white)
            
            Slider(
                    value: Binding(
                        get: { value },
                        set: { value = $0.rounded() } 
                    ),
                    in: 0...255,
                    step: 1
            )
            .tint(color)
            .onChange(of: value) { _, newValue in
                text = newValue.formatted(.number.precision(.fractionLength(0)))
            }
            
            TextFieldView(text: $text, action: checkValue)
                .alert("Wrong Format", isPresented: $showAlert, actions: {}) {
                    Text("Please enter value from 0 to 255")
                }
        }
        .onAppear {
            text = value.formatted()
        }
    }
    
    private func checkValue() {
        if let intVal = Int(text) {
            let clamped = min(max(intVal, 0), 255)
            value = Double(clamped)
            text = String(clamped)
        } else {
            showAlert = true
            value = 0
            text = "0"
        }
    }
}

#Preview {
    ZStack {
        Color.background
        ColorSliderView(value: .constant(100), color: .red)
    }
}
