//
//  BeginnerLevel.swift
//  Yogo Watch App
//
//  Created by Whitney Wordlaw on 3/24/25.
//

import SwiftUI

struct BeginnerLevel: View {
    @EnvironmentObject var currentYoga: CurrentYoga

    @State private var navigateToSunSalutation: Bool = false
    @State private var navigateToGentleMorningFlow: Bool = false
    @State private var navigateToStrengthAndBalance: Bool = false
    @State private var navigateToHipOpener: Bool = false
    @State private var navigateToWindDown: Bool = false
    
    var body: some View {
        NavigationStack{
            ScrollView{
                Text("Beginner Flows")
                    .foregroundColor(.darkPink)
                    .fontWeight(.bold)
                Spacer(minLength: 10)

                
                NavigationLink("Sun Salutation")
                {
                    SetTime()
                }
                .foregroundColor(.tan)
                
                NavigationLink("Gentle Morning Flow")
                {
                    SetTime()
                }
                .foregroundColor(.tan)
                
                NavigationLink("Strength & Balance")
                {
                    SetTime()
                }
                .foregroundColor(.tan)
                
                NavigationLink("Hip Opener")
                {
                    SetTime()
                }
                .foregroundColor(.tan)
                
                NavigationLink("Wind Down")
                {
                    SetTime()
                }
                .foregroundColor(.tan)
            }
        }
    }
}
#Preview {
    BeginnerLevel()
        .environmentObject(AudioManager())
        .environmentObject(CurrentYoga())
}
