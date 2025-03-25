import SwiftUI
import WatchKit

struct SetTime: View {
    @State private var selectedHours = 0
    @State private var selectedMinutes = 0
    @State private var selectedSeconds = 0
    @State private var totalSeconds = 0
    @State private var isRunning = false

    let hoursRange = Array(0...23)
    let minutesRange = Array(0...59)
    let secondsRange = Array(0...59)

    @State private var timer: Timer? = nil

    var body: some View {
      
            VStack {
                if isRunning {
                    Text(formatTime(totalSeconds))
                        .font(.largeTitle)
                        .monospacedDigit()
                        .padding()
                } else {
                    HStack {
                        Picker("Hours", selection: $selectedHours) {
                            ForEach(hoursRange, id: \.self) { hour in
                                Text("\(hour) h").tag(hour)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        
                        Picker("Minutes", selection: $selectedMinutes) {
                            ForEach(minutesRange, id: \.self) { minute in
                                Text("\(minute) m").tag(minute)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        
                        Picker("Seconds", selection: $selectedSeconds) {
                            ForEach(secondsRange, id: \.self) { second in
                                Text("\(second) s").tag(second)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                    }
                }
                
                Button(action: {
                    if isRunning {
                        stopTimer()
                    } else {
                        startTimer()
                    }
                }) {
                    Text("Save")
                        .padding()
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .foregroundColor(.tan)
            }
        }
    
        func startTimer() {
            totalSeconds = (selectedHours * 3600) + (selectedMinutes * 60) + selectedSeconds
            if totalSeconds > 0 {
                isRunning = true
                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                    if totalSeconds > 0 {
                        totalSeconds -= 1
                    } else {
                        stopTimer()
                        WKInterfaceDevice.current().play(.success) // Haptic feedback
                    }
                }
            }
        }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        isRunning = false
    }

    func formatTime(_ seconds: Int) -> String {
        let h = seconds / 3600
        let m = (seconds % 3600) / 60
        let s = seconds % 60
        return String(format: "%02d:%02d:%02d", h, m, s)
    }
    
}

struct TriplePickerTimerView_Previews: PreviewProvider {
    static var previews: some View {
        SetTime()
    }
}
