import Foundation
import WatchKit
import AVFoundation

class YogaHapticManager: ObservableObject {
    static let shared = YogaHapticManager()
    
    private var positionChangeTimer: Timer?
    private var isHapticsEnabled = false
    private var breatheInPlayer: AVAudioPlayer?
    private var breatheOutPlayer: AVAudioPlayer?
    
    private init() {
        print("YogaHapticManager initialized")
        setupAudioPlayers()
    }
    
    private func setupAudioPlayers() {
        if let breatheInURL = Bundle.main.url(forResource: "breatheIn", withExtension: "mp3") {
            do {
                breatheInPlayer = try AVAudioPlayer(contentsOf: breatheInURL)
                breatheInPlayer?.prepareToPlay()
            } catch {
                print("Error loading breathe in sound: \(error)")
            }
        }
        
        if let breatheOutURL = Bundle.main.url(forResource: "breatheOut", withExtension: "mp3") {
            do {
                breatheOutPlayer = try AVAudioPlayer(contentsOf: breatheOutURL)
                breatheOutPlayer?.prepareToPlay()
            } catch {
                print("Error loading breathe out sound: \(error)")
            }
        }
    }
    
    func startHaptics() {
        print("Starting haptics")
        isHapticsEnabled = true
    }
    
    func playBreatheInHaptic() {
        guard isHapticsEnabled else { 
            print("Haptics disabled, skipping breathe in")
            return 
        }
        print("Playing breathe in haptic and sound")
        WKInterfaceDevice.current().play(.notification)
        breatheInPlayer?.currentTime = 0
        breatheInPlayer?.play()
    }
    
    func playBreatheOutHaptic() {
        guard isHapticsEnabled else { 
            print("Haptics disabled, skipping breathe out")
            return 
        }
        print("Playing breathe out haptic and sound")
        WKInterfaceDevice.current().play(.success)
        breatheOutPlayer?.currentTime = 0
        breatheOutPlayer?.play()
    }
    
    func startPositionChangeHaptic() {
        print("Starting position change haptic")
        // Play initial haptic
        WKInterfaceDevice.current().play(.directionUp)
        
        // Create a timer that repeats the haptic every 0.5 seconds
        positionChangeTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            guard let self = self, self.isHapticsEnabled else { 
                print("Position change timer: haptics disabled")
                return 
            }
            print("Playing position change haptic")
            WKInterfaceDevice.current().play(.directionUp)
        }
    }
    
    func stopPositionChangeHaptic() {
        print("Stopping position change haptic")
        positionChangeTimer?.invalidate()
        positionChangeTimer = nil
    }
    
    func playCompletionHaptic() {
        guard isHapticsEnabled else { 
            print("Haptics disabled, skipping completion")
            return 
        }
        print("Playing completion haptic")
        WKInterfaceDevice.current().play(.success)
    }
    
    func stopAllHaptics() {
        print("Stopping all haptics and sounds")
        isHapticsEnabled = false
        stopPositionChangeHaptic()
        breatheInPlayer?.stop()
        breatheOutPlayer?.stop()
    }
} 

