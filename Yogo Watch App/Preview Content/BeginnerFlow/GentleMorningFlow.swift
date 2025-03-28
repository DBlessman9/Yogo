//
//  GentleMorningFlow.swift
//  Yogo Watch App
//
//  Created by Whitney Wordlaw on 3/25/25.
//

import SwiftUI
import HealthKit
import Combine


struct GentleMorningFlow: View {
    @EnvironmentObject var currentYoga: CurrentYoga
    @EnvironmentObject var audioManager: AudioManager

    var body: some View {
        VStack {
            Text("Gentle Morning Flow")
                .font(.headline)
                .foregroundColor(.darkPink)
                .padding()
            
            Button(audioManager.isPlaying ? "Pause Audio" : "Play Audio") {
                audioManager.togglePlayback()
            }
            .foregroundColor(.tan)
        }
        .onAppear {
            audioManager.loadAudio(filename: "GentleMorningFlow", fileType: "mp3")
        }
    }
}

#Preview {
    GentleMorningFlow()
        .environmentObject(AudioManager())
        .environmentObject(CurrentYoga())
}
