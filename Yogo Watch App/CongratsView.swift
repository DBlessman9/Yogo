import SwiftUI
import WatchKit

struct CongratsView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var currentYoga: CurrentYoga
    @EnvironmentObject var appUsageTracker: AppUsageTracker
    @Binding var showCongrats: Bool
    @Binding var navigateToWelcome: Bool
    
    private var congratulatoryMessage: String {
        switch appUsageTracker.currentStarImage {
        case "StarSuper":
            return "Go Super Star!"
        case "StarHappy":
            return "Congratulations!"
        case "StarMaybe":
            return "Keep Going!"
        case "StarSad":
            return "You Got This"
        default:
            return "Congratulations!"
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Image(appUsageTracker.currentStarImage)
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 150)
                .padding(.top, 10)
            
            Text(congratulatoryMessage)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.darkPink)
                .padding(.top, -30)
            
            Text("You completed \(formatTime(currentYoga.elapsedTime)) of yoga!")
                .font(.system(size: 12))
                .foregroundColor(.tan)
                .padding(.bottom, -10)
                .frame(height: 50)
                .frame(maxWidth: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
            
            Button {
                showCongrats = false
                navigateToWelcome = true
            } label: {
                Text("Done")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.tan)
                    .frame(width: 180, height: 30)
                    .padding(.vertical, 12)
                    .background(Color.buttonAccent)
                    .cornerRadius(30)
            }
            .padding(.bottom, 70)
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $navigateToWelcome) {
            ContentView()
        }
        .onAppear {
            WKInterfaceDevice.current().play(.success)
            // Record the usage when the congrats view appears
            appUsageTracker.recordUsage(duration: currentYoga.elapsedTime)
        }
    }
    
    private func formatTime(_ timeInterval: TimeInterval) -> String {
        let hours = Int(timeInterval) / 3600
        let minutes = Int(timeInterval) / 60 % 60
        let seconds = Int(timeInterval) % 60
        
        if hours > 0 {
            return String(format: "%d:%02d:%02d", hours, minutes, seconds)
        } else {
            return String(format: "%02d:%02d", minutes, seconds)
        }
    }
}

#Preview {
    CongratsView(showCongrats: .constant(true), navigateToWelcome: .constant(false))
        .environmentObject(CurrentYoga())
        .environmentObject(AppUsageTracker.shared)
} 
