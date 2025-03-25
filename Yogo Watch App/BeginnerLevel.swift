//
//  BeginnerLevel.swift
//  Yogo Watch App
//
//  Created by Whitney Wordlaw on 3/24/25.
//

import SwiftUI

struct BeginnerLevel: View {
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
                    SunSalutation()
                }
                .foregroundColor(.tan)
                
                NavigationLink("Gentle Morning Flow")
                {
                    GentleMorningFlow()
                }
                .foregroundColor(.tan)
                
                NavigationLink("Strength & Balance")
                {
                    StrengthBalance()
                }
                .foregroundColor(.tan)
                
                NavigationLink("Hip Opener")
                {
                    HipOpener()
                }
                .foregroundColor(.tan)
                
                NavigationLink("Wind Down")
                {
                    WindDown()
                }
                .foregroundColor(.tan)
            }
        }
    }
}
#Preview {
    BeginnerLevel()
}
