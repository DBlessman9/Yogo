import SwiftUI
import WatchKit
import Combine
import HealthKit

struct SetTime: View {
    @EnvironmentObject var currentYoga: CurrentYoga
    @StateObject private var hapticManager = YogaHapticManager.shared
    @StateObject private var workoutManager = WorkoutManager.shared
    let breathingSpeed: Double
    @State private var selectedHours = 0
    @State private var selectedMinutes = 0
    @State private var selectedSeconds = 0
    @State private var isRunning = false
    @State private var isPaused = false
    @State private var timer: AnyCancellable? = nil
    @State private var totalSeconds = 0
    @State private var showStopButton = false
    @State private var showCongrats = false
    @State private var breathingTimer: AnyCancellable? = nil
    @State private var positionChangeTimer: AnyCancellable? = nil
    @State private var breathingCycleCount = 0
    @State private var isPositionChange = false

    let hoursRange = Array(0...23)
    let minutesRange = Array(0...59)
    let secondsRange = Array(0...59)

    var body: some View {
        VStack {
            if isRunning {
                Text(formatTime(totalSeconds))
                    .font(.largeTitle)
                    .monospacedDigit()
                    .padding()
                    .transition(.scale.combined(with: .opacity))
                
                VStack(spacing: 10) {
                    Button {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            if isPaused {
                                resumeTimer()
                            } else {
                                pauseTimer()
                            }
                        }
                    } label: {
                        Text(isPaused ? "Resume" : "Pause")
                            .padding()
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .foregroundColor(isPaused ? .green : .orange)
                    
                    if showStopButton {
                        Button {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                stopTimer()
                                showCongrats = true
                            }
                        } label: {
                            Text("Stop")
                                .padding()
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .foregroundColor(.red)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                    }
                }
                .padding(.top)
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
                .transition(.scale.combined(with: .opacity))

                Button {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        let selectedTimeInSeconds = (selectedHours * 3600) + (selectedMinutes * 60) + selectedSeconds
                        currentYoga.updateTime(selectedTime: selectedTimeInSeconds)
                        startTimer()
                    }
                } label: {
                    Text("Go!")
                        .padding()
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .foregroundColor(.green)
            }
        }
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isRunning)
        .fullScreenCover(isPresented: $showCongrats) {
            CongratsView(showCongrats: $showCongrats)
        }
    }

    func startTimer() {
        totalSeconds = (selectedHours * 3600) + (selectedMinutes * 60) + selectedSeconds
        if totalSeconds > 0 {
            // Start workout session to keep app running in background
            workoutManager.startWorkout()
            
            // Enable battery monitoring to help keep screen active
            WKInterfaceDevice.current().isBatteryMonitoringEnabled = true
            
            // Enable haptics
            hapticManager.startHaptics()
            
            withAnimation(.easeInOut(duration: 0.3)) {
                isRunning = true
                isPaused = false
                showStopButton = true
                breathingCycleCount = 0
                isPositionChange = false
            }
            
            // Cancel any existing timers before starting new ones
            timer?.cancel()
            breathingTimer?.cancel()
            
            // Start the main countdown timer with background execution
            timer = Timer.publish(every: 1, on: .main, in: .common)
                .autoconnect()
                .sink { _ in
                    if totalSeconds > 0 {
                        totalSeconds -= 1
                    } else {
                        cleanupAndShowCongrats()
                    }
                }
            
            // Start breathing haptics after a short delay to ensure proper synchronization
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                startBreathingHaptics()
            }
        }
    }

    func startBreathingHaptics() {
        let breathingCycle = breathingSpeed  // Use the selected breathing speed
        
        breathingTimer?.cancel()
        breathingTimer = Timer.publish(every: breathingCycle, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if !isPositionChange {
                    // Play breathe in haptic
                    hapticManager.playBreatheInHaptic()
                    
                    // Play breathe out haptic after 50% of the cycle (equal inhale and exhale)
                    DispatchQueue.main.asyncAfter(deadline: .now() + (breathingCycle * 0.5)) {
                        hapticManager.playBreatheOutHaptic()
                        
                        // Only increment cycle count after exhale is complete
                        breathingCycleCount += 1
                        
                        // Check if we need to start position change after 3 complete cycles
                        if breathingCycleCount == 3 {
                            // Pause breathing cycle
                            breathingTimer?.cancel()
                            
                            // Add delay before position change (half of breathing cycle)
                            let delayBeforePositionChange = breathingCycle * 0.5
                            DispatchQueue.main.asyncAfter(deadline: .now() + delayBeforePositionChange) {
                                startPositionChange()
                            }
                        }
                    }
                }
            }
    }

    func startPositionChange() {
        isPositionChange = true
        hapticManager.startPositionChangeHaptic()
        
        // Resume breathing after 9 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 9.0) {
            hapticManager.stopPositionChangeHaptic()
            isPositionChange = false
            breathingCycleCount = 0  // Reset to start 3 more cycles
            startBreathingHaptics()  // Restart the breathing cycle
        }
    }

    func pauseTimer() {
        timer?.cancel()
        breathingTimer?.cancel()
        timer = nil
        breathingTimer = nil
        hapticManager.stopAllHaptics()
        isPaused = true
    }

    func resumeTimer() {
        isPaused = false
        // Start the main countdown timer
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if totalSeconds > 0 {
                    totalSeconds -= 1
                } else {
                    cleanupAndShowCongrats()
                }
            }
        
        // Resume breathing haptics after a short delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            startBreathingHaptics()
        }
    }

    func stopTimer() {
        timer?.cancel()
        breathingTimer?.cancel()
        positionChangeTimer?.cancel()
        timer = nil
        breathingTimer = nil
        positionChangeTimer = nil
        hapticManager.stopAllHaptics()
        
        // End workout session
        workoutManager.endWorkout()
        
        // Allow screen to dim when timer is stopped
        WKInterfaceDevice.current().isBatteryMonitoringEnabled = false
        
        withAnimation(.easeInOut(duration: 0.3)) {
            isRunning = false
            isPaused = false
            showStopButton = false
            breathingCycleCount = 0
            isPositionChange = false
        }
        
        // Update elapsed time in CurrentYoga
        let elapsedTime = Double((selectedHours * 3600) + (selectedMinutes * 60) + selectedSeconds - totalSeconds)
        currentYoga.updateElapsedTime(elapsedTime)
    }

    func cleanupAndShowCongrats() {
        // Stop all timers
        timer?.cancel()
        breathingTimer?.cancel()
        positionChangeTimer?.cancel()
        timer = nil
        breathingTimer = nil
        positionChangeTimer = nil
        
        // Stop all haptics
        hapticManager.stopAllHaptics()
        
        // End workout session
        workoutManager.endWorkout()
        
        // Allow screen to dim
        WKInterfaceDevice.current().isBatteryMonitoringEnabled = false
        
        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
            isRunning = false
            isPaused = false
            showStopButton = false
            breathingCycleCount = 0
            isPositionChange = false
            showCongrats = true
        }
        
        // Update elapsed time in CurrentYoga
        let elapsedTime = Double((selectedHours * 3600) + (selectedMinutes * 60) + selectedSeconds)
        currentYoga.updateElapsedTime(elapsedTime)
    }

    func formatTime(_ seconds: Int) -> String {
        let h = seconds / 3600
        let m = (seconds % 3600) / 60
        let s = seconds % 60
        return String(format: "%02d:%02d:%02d", h, m, s)
    }
}

#Preview {
    SetTime(breathingSpeed: 8.0)
        .environmentObject(AudioManager())
        .environmentObject(CurrentYoga())
}
