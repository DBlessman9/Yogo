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
                    MorningFlow()
                }
                .foregroundColor(.tan)
                
                NavigationLink("Strength & Balance II")
                {
                    StrengthBalance2()
                }
                .foregroundColor(.tan)
                
                NavigationLink("Hip Opening & Flexability")
                {
                    HipOpener2()
                }
                .foregroundColor(.tan)
                
                NavigationLink("Core-Focused Power Flow")
                {
                    CoreFocusedPower()
                }
                .foregroundColor(.tan)
                
                NavigationLink("Wind Down II")
                {
                    WindDown2()
                }
                .foregroundColor(.tan)
            }
        }
    }
}

#Preview {
    IntermediateLevel()
}
