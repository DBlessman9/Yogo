import SwiftUI
import WatchKit

struct CongratsView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var currentYoga: CurrentYoga
    @StateObject private var appUsageTracker = AppUsageTracker.shared
    @Binding var showCongrats: Bool
    @State private var navigateToContentView = false
    
    private var congratulatoryMessage: String {
        let starImage = appUsageTracker.determineStarImage()
        switch starImage {
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
        NavigationStack {
            VStack(spacing: 0) {
                Image(appUsageTracker.determineStarImage())
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .padding(.top, -20)
                
                Text(congratulatoryMessage)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.darkPink)
                    .padding(.top, -30)
                
                Text("You completed \(formatTime(currentYoga.elapsedTime)) of yoga!")
                    .font(.system(size: 12))
                    .foregroundColor(.tan)
                    .padding(.top, 2)
                    .frame(height: 60)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .multilineTextAlignment(.center)
                
                Button {
                    showCongrats = false
                    navigateToContentView = true
                } label: {
                    Text("Done")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.pink)
                        .frame(width: 175)
                        .padding(.vertical, 12)
                        .background(Color.tan)
                        .cornerRadius(30)
                }
                .padding(.bottom, 40)
            }
            .onAppear {
                WKInterfaceDevice.current().play(.success)
                // Record the usage when the congrats view appears
                appUsageTracker.recordUsage(duration: currentYoga.elapsedTime)
            }
            .navigationDestination(isPresented: $navigateToContentView) {
                ContentView()
            }
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
    CongratsView(showCongrats: .constant(true))
        .environmentObject(CurrentYoga())
} 
