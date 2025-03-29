import Foundation

class CurrentYoga: ObservableObject {
    @Published var selectedTime: Int = 0
    @Published var currentFlow: String = ""
    @Published var currentLevel: String = ""
    @Published var elapsedTime: TimeInterval = 0
    
    func updateTime(selectedTime: Int) {
        self.selectedTime = selectedTime
    }
    
    func updateFlow(flow: String) {
        self.currentFlow = flow
    }
    
    func updateLevel(level: String) {
        self.currentLevel = level
    }
    
    func setLevel(_ level: String) {
        self.currentLevel = level
    }
    
    func updateElapsedTime(_ time: TimeInterval) {
        self.elapsedTime = time
    }
} 
