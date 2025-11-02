//
//  SliderView.swift
//  ColorizedSwiftUI
//
//  Created by Leonid on 02.11.2025.
//

import SwiftUI

struct SliderView: View {
    let tint: Color
    
    @State private var sliderValue = Double.random(in: 0...255)
    @State private var input = ""
    @FocusState private var inputFocused: Bool
    
    var body: some View {
        ZStack {
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    if inputFocused {
                        applyTextToSlider()
                        inputFocused = false
                    }
                }
            
            HStack {
                Text(lround(sliderValue).formatted())
                    .font(.title2)
                    .frame(width: 40, alignment: .leading)
                
                Slider(value: $sliderValue, in: 0...255, step: 1)
                    .tint(tint)
                    .onChange(of: sliderValue) {
                        syncTextFromSlider()
                    }
                
                TextField("Enter", text: $input)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 65, alignment: .trailing)
                    .font(.title2)
                    .keyboardType(.numberPad)
                    .submitLabel(.done)
                    .multilineTextAlignment(.trailing)
                    .focused($inputFocused)
                    .onSubmit { applyTextToSlider() }
                
            }
            .padding()
        }
        .onAppear { syncTextFromSlider() }

        .onChange(of: inputFocused) { _, isFocused in
            if !isFocused { applyTextToSlider() }
        }
        
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    applyTextToSlider()
                    inputFocused = false
                }
            }
        }
    }
    
    private func syncTextFromSlider() {
        input = String(lround(sliderValue))
    }
    
    private func applyTextToSlider() {
        let typed = Int(input) ?? lround(sliderValue)
        let clamped = min(max(typed, 0), 255)
        
        withAnimation(.easeInOut(duration: 0.25)) {
            sliderValue = Double(clamped)
        }
        
        input = String(clamped)
    }
}

#Preview {
    SliderView(tint: .red)
}
