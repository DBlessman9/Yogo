import WatchKit

class YogaHapticManager: ObservableObject {
    static let shared = YogaHapticManager()
    
    private init() {}
    
    func playBreatheInHaptic() {
        DispatchQueue.main.async {
            WKInterfaceDevice.current().play(.notification)
        }
    }
    
    func playBreatheOutHaptic() {
        DispatchQueue.main.async {
            WKInterfaceDevice.current().play(.notification)
        }
    }
    
    func playPositionChangeHaptic() {
        DispatchQueue.main.async {
            // Play first haptic immediately
            WKInterfaceDevice.current().play(.success)
            
            // Play subsequent haptics with 1-second intervals
            for i in 1...8 {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                    WKInterfaceDevice.current().play(.success)
                }
            }
        }
    }
} 