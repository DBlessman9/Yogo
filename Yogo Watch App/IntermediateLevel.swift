//
//  BeginnerLevel.swift
//  Yogo Watch App
//
//  Created by Whitney Wordlaw on 3/24/25.
//

import SwiftUI

struct IntermediateLevel: View {
    @EnvironmentObject var currentYoga: CurrentYoga
    @State private var breathingSpeed: Double = 8.0
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Text("Intermediate Flows")
                    .foregroundColor(.darkPink)
                    .fontWeight(.bold)
                Spacer(minLength: 10)
                
                NavigationLink("Energized Morning Flow") {
                    BreathingSpeedView(breathingSpeed: $breathingSpeed)
                        .onAppear {
                            currentYoga.setLevel("Intermediate")
                            currentYoga.updateFlow(flow: "MorningFlow")
                        }
                }
                .foregroundColor(.tan)
                
                NavigationLink("Strength & Balance II") {
                    BreathingSpeedView(breathingSpeed: $breathingSpeed)
                        .onAppear {
                            currentYoga.setLevel("Intermediate")
                            currentYoga.updateFlow(flow: "StrengthBalance2")
                        }
                }
                .foregroundColor(.tan)
                
                NavigationLink("Hip Opening & Flexability") {
                    BreathingSpeedView(breathingSpeed: $breathingSpeed)
                        .onAppear {
                            currentYoga.setLevel("Intermediate")
                            currentYoga.updateFlow(flow: "HipOpener2")
                        }
                }
                .foregroundColor(.tan)
                
                NavigationLink("Core-Focused Power Flow") {
                    BreathingSpeedView(breathingSpeed: $breathingSpeed)
                        .onAppear {
                            currentYoga.setLevel("Intermediate")
                            currentYoga.updateFlow(flow: "CoreFocusedPower")
                        }
                }
                .foregroundColor(.tan)
                
                NavigationLink("Wind Down II") {
                    BreathingSpeedView(breathingSpeed: $breathingSpeed)
                        .onAppear {
                            currentYoga.setLevel("Intermediate")
                            currentYoga.updateFlow(flow: "WindDown2")
                        }
                }
                .foregroundColor(.tan)
            }
        }
    }
}

struct IntermediateLevel_Previews: PreviewProvider {
    static var previews: some View {
        IntermediateLevel()
            .environmentObject(CurrentYoga())
    }
}
