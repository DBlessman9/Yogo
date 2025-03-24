//
//  ContentView.swift
//  Yogo Watch App
//
//  Created by Derald Blessman on 3/19/25.
//

import SwiftUI


struct ContentView: View {
    
    @State private var navigateToBeginner = false
    @State private var navigateToIntermediate = false

    
    var body: some View {
            NavigationStack{
                VStack {
                        Text("Select your Vinyasa Yoga Level?")
                            .frame(width: 200, height: 70)
                            .foregroundColor(.darkPink)
                            .fontWeight(.bold)
                    
                    Button("Beginner") {
                        navigateToBeginner = true
                    }
                    .foregroundColor(.tan)
                    
                    Button("Intermediate") {
                        navigateToIntermediate = true
                    }
                    .foregroundColor(.tan)

                }
                .padding()
            }
        }
    }

#Preview {
    ContentView()
}
