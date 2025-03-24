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
                
                Button("Morning Energy Flow") {
                    navigateToSunSalutation = true
                }
                .foregroundColor(.tan)

                Button("Strength & Balance II") {
                    navigateToGentleMorningFlow = true
                }
                .foregroundColor(.tan)

                Button("Hip Openening & Flexibility") {
                    navigateToStrengthAndBalance = true
                }
                .foregroundColor(.tan)

                Button("Core-Focused Power Flow") {
                    navigateToHipOpener = true
                }
                .foregroundColor(.tan)

                Button("Wind Down II") {
                    navigateToWindDown = true
                }
                .foregroundColor(.tan)

            }
        }
    }
}

#Preview {
    IntermediateLevel()
}
