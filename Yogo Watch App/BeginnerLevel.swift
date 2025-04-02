//
//  BeginnerLevel.swift
//  Yogo Watch App
//
//  Created by Whitney Wordlaw on 3/24/25.
//

import SwiftUI

struct BeginnerLevel: View {
    @EnvironmentObject var currentYoga: CurrentYoga
    @State private var breathingSpeed: Double = 8.0
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Text("Beginner Flows")
                    .foregroundColor(.darkPink)
                    .fontWeight(.bold)
                Spacer(minLength: 10)
                
                NavigationLink("Sun Salutation") {
                    BreathingSpeedView(breathingSpeed: $breathingSpeed)
                        .onAppear {
                            currentYoga.setLevel("Beginner")
                            currentYoga.updateFlow(flow: "SunSalutation")
                        }
                }
                .foregroundColor(.tan)
                
                NavigationLink("Gentle Morning Flow") {
                    BreathingSpeedView(breathingSpeed: $breathingSpeed)
                        .onAppear {
                            currentYoga.setLevel("Beginner")
                            currentYoga.updateFlow(flow: "GentleMorningFlow")
                        }
                }
                .foregroundColor(.tan)
                
                NavigationLink("Strength & Balance") {
                    BreathingSpeedView(breathingSpeed: $breathingSpeed)
                        .foregroundColor(.darkPink)
                        .onAppear {
                            currentYoga.setLevel("Beginner")
                            currentYoga.updateFlow(flow: "StrengthBalance")
                        }
                }
                .foregroundColor(.tan)
                
                NavigationLink("Hip Opener") {
                    BreathingSpeedView(breathingSpeed: $breathingSpeed)
                        .onAppear {
                            currentYoga.setLevel("Beginner")
                            currentYoga.updateFlow(flow: "HipOpener")
                        }
                }
                .foregroundColor(.tan)
                
                NavigationLink("Wind Down") {
                    BreathingSpeedView(breathingSpeed: $breathingSpeed)
                        .onAppear {
                            currentYoga.setLevel("Beginner")
                            currentYoga.updateFlow(flow: "WindDown")
                        }
                }
                .foregroundColor(.tan)
            }
        }
    }
}

struct BeginnerLevel_Previews: PreviewProvider {
    static var previews: some View {
        BeginnerLevel()
            .environmentObject(CurrentYoga())
    }
}
