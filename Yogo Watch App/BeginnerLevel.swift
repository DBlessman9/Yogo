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

                
                Button("Sun Salutation") {
                    navigateToSunSalutation = true
                }
                .foregroundColor(.tan)

                Button("Gentle Morning Flow") {
                    navigateToGentleMorningFlow = true
                }
                .foregroundColor(.tan)

                Button("Strength & Balance") {
                    navigateToStrengthAndBalance = true
                }
                .foregroundColor(.tan)

                Button("Hip Opener") {
                    navigateToHipOpener = true
                }
                .foregroundColor(.tan)

                Button("Wind Down") {
                    navigateToWindDown = true
                }
                .foregroundColor(.tan)

            }
        }
    }
}
#Preview {
    BeginnerLevel()
}
