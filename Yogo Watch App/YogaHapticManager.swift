import Foundation
import WatchKit

class YogaHapticManager: ObservableObject {
    static let shared = YogaHapticManager()
    
    private var positionChangeTimer: Timer?
    private var isHapticsEnabled = false
    
    private init() {}
    
    func startHaptics() {
        isHapticsEnabled = true
    }
    
    func playBreatheInHaptic() {
        guard isHapticsEnabled else { return }
        WKInterfaceDevice.current().play(.notification)
    }
    
    func playBreatheOutHaptic() {
        guard isHapticsEnabled else { return }
        WKInterfaceDevice.current().play(.success)
    }
    
    func startPositionChangeHaptic() {
        // Play initial haptic
        WKInterfaceDevice.current().play(.directionUp)
        
        // Create a timer that repeats the haptic every 0.5 seconds
        positionChangeTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            guard let self = self, self.isHapticsEnabled else { return }
            WKInterfaceDevice.current().play(.directionUp)
        }
    }
    
    func stopPositionChangeHaptic() {
        positionChangeTimer?.invalidate()
        positionChangeTimer = nil
    }
    
    func playCompletionHaptic() {
        guard isHapticsEnabled else { return }
        WKInterfaceDevice.current().play(.success)
    }
    
    func stopAllHaptics() {
        isHapticsEnabled = false
        stopPositionChangeHaptic()
    }
} 

