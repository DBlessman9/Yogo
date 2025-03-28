//
//  AudioManager.swift
//  Yogo
//
//  Created by Whitney Wordlaw on 3/27/25.
//


//
//  Logic.swift
//  Yogo Watch App
//
//  Created by Whitney Wordlaw on 3/25/25.
//

import Foundation
import AVFoundation

class AudioManager: ObservableObject {
    @Published var isPlaying: Bool = false
    private var audioPlayer: AVAudioPlayer?

    func loadAudio(filename: String, fileType: String) {
        guard let path = Bundle.main.path(forResource: filename, ofType: fileType) else {
            print("Audio file \(filename).\(fileType) not found")
            return
        }

        let url = URL(fileURLWithPath: path)

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
        } catch {
            print("Error loading audio: \(error.localizedDescription)")
        }
    }

    func togglePlayback() {
        guard let player = audioPlayer else {
            print("No audio loaded")
            return
        }

        if player.isPlaying {
            player.pause()
            isPlaying = false
        } else {
            player.play()
            isPlaying = true
        }
    }
}
