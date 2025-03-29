import Foundation
import WatchKit

class YogaHapticManager: ObservableObject {
    static let shared = YogaHapticManager()
    
    private var positionChangeTimer: Timer?
    private var isHapticsEnabled = false
    
    private init() {
        print("YogaHapticManager initialized")
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
        print("Playing breathe in haptic")
        WKInterfaceDevice.current().play(.notification)
    }
    
    func playBreatheOutHaptic() {
        guard isHapticsEnabled else { 
            print("Haptics disabled, skipping breathe out")
            return 
        }
        print("Playing breathe out haptic")
        WKInterfaceDevice.current().play(.success)
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
        print("Stopping all haptics")
        isHapticsEnabled = false
        stopPositionChangeHaptic()
    }
} 

