//
//  StrengthBalance2.swift
//  Yogo Watch App
//
//  Created by Whitney Wordlaw on 3/25/25.
//

import SwiftUI
import HealthKit
import Combine

struct StrengthBalance2: View {
    @EnvironmentObject var currentYoga: CurrentYoga
    @EnvironmentObject var audioManager: AudioManager
    
    var body: some View {
        VStack {
            Text("Strength & Balance II")
                .font(.headline)
                .foregroundColor(.darkPink)
                .padding()
            
            Button(audioManager.isPlaying ? "Pause Audio" : "Play Audio") {
                audioManager.togglePlayback()
            }
            .foregroundColor(.tan)
        }
        .onAppear {
            audioManager.loadAudio(filename: "StrengthBalanceFlow2", fileType: "mp3")
        }
    }
}

#Preview {
    StrengthBalance2()
        .environmentObject(AudioManager())
        .environmentObject(CurrentYoga())}
