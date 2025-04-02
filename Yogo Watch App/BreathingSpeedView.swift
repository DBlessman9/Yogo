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
                .bold()
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
                                .foregroundColor(.tan)
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
                                .foregroundColor(.tan)
                                .contentShape(Rectangle())
                                .padding(.top, 4)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.trailing, 15)
                    .focusable()
                    .digitalCrownRotation($breathingSpeed, from: 6, through: 12, by: 1, sensitivity: .medium, isContinuous: false, isHapticFeedbackEnabled: true)
                    
                    Text("\(Int(breathingSpeed))s")
                        .font(.system(size:50, weight:.semibold))
                        .foregroundColor(.tan)
                }
                .padding(-5)
            }
            
            Spacer()
            
                NavigationLink(destination: SetTime(breathingSpeed: breathingSpeed)) {
                    Text("Continue")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.tan)
                        .frame(width: 175)
                        .padding(.vertical, 12)
                        .background(.buttonAccent)
                        .cornerRadius(30)
                        .scaledToFill()
                }
           .buttonStyle(PlainButtonStyle())
            .padding(.horizontal)
            .padding(.bottom, 15)
           .foregroundColor(.tan)
           
        }
        .foregroundColor(.tan)
        .padding()
    }
}

#Preview {
    BreathingSpeedView(breathingSpeed: .constant(8.0))
}
