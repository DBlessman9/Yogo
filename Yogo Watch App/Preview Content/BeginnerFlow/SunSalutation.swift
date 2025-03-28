//
//  GentleMorningFlow.swift
//  Yogo Watch App
//
//  Created by Whitney Wordlaw on 3/25/25.
//

import SwiftUI
import HealthKit
import Combine
import AVFoundation

struct SunSalutation: View {
    @EnvironmentObject var currentYoga: CurrentYoga
    @EnvironmentObject var audioManager: AudioManager
    
    var body: some View {
            VStack {
                Text("Sun Salatation A")
                    .font(.headline)
                    .foregroundColor(.darkPink)
                    .padding()
                
                Button(audioManager.isPlaying ? "Pause Audio" : "Play Audio") {
                    audioManager.togglePlayback()
                }
                .foregroundColor(.tan)
            }
            .onAppear {
                audioManager.loadAudio(filename: "SunSalutationA", fileType: "mp3")
            }
        }
    }

#Preview {
    SunSalutation()
        .environmentObject(AudioManager())
        .environmentObject(CurrentYoga())
}
