//
//  ContentView.swift
//  Yogo Watch App
//
//  Created by Derald Blessman on 3/19/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var audioManager = AudioManager()
    @StateObject private var currentYoga = CurrentYoga()
    @State private var breathingSpeed: Double = 8.0
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Text("Welcome to YoGo!")
                    .foregroundColor(.darkPink)
                    .fontWeight(.bold)
                Spacer(minLength: 10)
                
                NavigationLink("Beginner") {
                    BeginnerLevel()
                }
                .foregroundColor(.tan)
                
                NavigationLink("Intermediate") {
                    IntermediateLevel()
                }
                .foregroundColor(.tan)
            }
        }
        .environmentObject(audioManager)
        .environmentObject(currentYoga)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

