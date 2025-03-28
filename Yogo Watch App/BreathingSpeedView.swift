import SwiftUI

struct RotatedSlider: View {
    @Binding var value: Double
    
    var body: some View {
        Slider(value: $value, in: 6...12, step: 1)
            .rotationEffect(.degrees(90))
            .frame(width: 30, height: 100)
            .focusable()
            .digitalCrownRotation($value, from: 6, through: 12, by: 1, sensitivity: .medium, isContinuous: false, isHapticFeedbackEnabled: true)
            .overlay(
                Image(systemName: "minus")
                    .rotationEffect(.degrees(-90))
                    .offset(x: -15)
            )
    }
}

struct BreathingSpeedView: View {
    @Binding var breathingSpeed: Double
    
    var body: some View {
        VStack(spacing: 8) {
            Text("Breathing Speed")
                .font(.headline)
                .foregroundColor(.darkPink)
                .padding(.top, 20)
            
            Spacer()
            
            VStack(spacing: 8) {
                HStack(spacing: 2) {
                    VStack(spacing: 15) {
                        Button(action: {
                            if breathingSpeed < 12 {
                                breathingSpeed += 1
                            }
                        }) {
                            Image(systemName: "chevron.up")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.blue)
                                .contentShape(Rectangle())
                                .padding(4)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Button(action: {
                            if breathingSpeed > 6 {
                                breathingSpeed -= 1
                            }
                        }) {
                            Image(systemName: "chevron.down")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.blue)
                                .contentShape(Rectangle())
                                .padding(4)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.trailing, 15)
                    .focusable()
                    .digitalCrownRotation($breathingSpeed, from: 6, through: 12, by: 1, sensitivity: .medium, isContinuous: false, isHapticFeedbackEnabled: true)
                    
                    Text("\(Int(breathingSpeed))s")
                        .font(.system(.title2, design: .rounded))
                        .foregroundColor(.blue)
                }
            }
            
            Spacer()
            
            Button(action: {}) {
                NavigationLink(destination: SetTime(breathingSpeed: breathingSpeed)) {
                    Text("Continue")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.darkPink)
                        .frame(width: 175)
                        .padding(.vertical, 12)
                        .background(Color.tan)
                        .cornerRadius(30)
                        .scaledToFill()
                }
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.horizontal)
        }
        .padding()
    }
}

#Preview {
    BreathingSpeedView(breathingSpeed: .constant(8.0))
}
