//
//  BeginnerLevel.swift
//  Yogo Watch App
//
//  Created by Whitney Wordlaw on 3/24/25.
//

import SwiftUI

struct IntermediateLevel: View {
    @State private var navigateToSunSalutation: Bool = false
    @State private var navigateToGentleMorningFlow: Bool = false
    @State private var navigateToStrengthAndBalance: Bool = false
    @State private var navigateToHipOpener: Bool = false
    @State private var navigateToWindDown: Bool = false
    
    var body: some View {
        NavigationStack{
            ScrollView{
                Text("Intermediate Flows")
                    .foregroundColor(.darkPink)
                    .fontWeight(.bold)
                Spacer(minLength: 10)
                
                NavigationLink("Energized Morning Flow")
                {
                    SetTime()
                }
                .foregroundColor(.tan)
                
                NavigationLink("Strength & Balance II")
                {
                    SetTime()
                }
                .foregroundColor(.tan)
                
                NavigationLink("Hip Opening & Flexability")
                {
                    SetTime()
                }
                .foregroundColor(.tan)
                
                NavigationLink("Core-Focused Power Flow")
                {
                    SetTime()
                }
                .foregroundColor(.tan)
                
                NavigationLink("Wind Down II")
                {
                    SetTime()
                }
                .foregroundColor(.tan)
            }
        }
    }
}

#Preview {
    IntermediateLevel()
        .environmentObject(AudioManager())
        .environmentObject(CurrentYoga())
}
