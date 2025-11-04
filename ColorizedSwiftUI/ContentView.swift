//
//  ContentView.swift
//  ColorizedSwiftUI
//
//  Created by Leonid on 02.11.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var red = Double.random(in: 0...255).rounded()
    @State private var green = Double.random(in: 0...255).rounded()
    @State private var blue = Double.random(in: 0...255).rounded()
    
    @FocusState private var isInputActive: Bool
    
    var body: some View {
        ZStack {
            VStack(spacing: 40) {
                ColorView(red: red, green: green, blue: blue)
                
                VStack {
                    ColorSliderView(value: $red, color: .red)
                    ColorSliderView(value: $green, color: .green)
                    ColorSliderView(value: $blue, color: .blue)
                }
                .frame(height: 150)
                .focused($isInputActive)
                
                Spacer()
            }
        }
        .padding()
        .background(Color.background)
        .onTapGesture {
            isInputActive = false
        }
        
        .safeAreaInset(edge: .bottom) {
            if isInputActive {
                HStack {
                    Spacer()
                    Button("Done") { isInputActive = false }
                        .buttonStyle(.borderedProminent)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 8)
            } else {
                EmptyView()
            }
        }
    }
}

#Preview {
    ContentView()
}
