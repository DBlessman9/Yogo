import Foundation

class AppUsageTracker: ObservableObject {
    static let shared = AppUsageTracker()
    
    @Published private(set) var usageDates: [Date] = []
    @Published private(set) var firstUse: Date?
    
    private let defaults = UserDefaults.standard
    private let usageDatesKey = "yogaUsageDates"
    private let firstUseKey = "yogaFirstUse"
    
    private init() {
        loadUsageDates()
        loadFirstUse()
        // Initialize first use date if not set
        if firstUse == nil {
            initializeFirstUse()
        }
    }
    
    private func loadUsageDates() {
        if let savedDates = defaults.array(forKey: usageDatesKey) as? [Date] {
            usageDates = savedDates
        }
    }
    
    private func saveUsageDates() {
        defaults.set(usageDates, forKey: usageDatesKey)
    }
    
    private func loadFirstUse() {
        firstUse = defaults.object(forKey: firstUseKey) as? Date
    }
    
    private func initializeFirstUse() {
        let today = Date()
        firstUse = today
        defaults.set(today, forKey: firstUseKey)
    }
    
    func recordUsage(duration: TimeInterval) {
        let today = Calendar.current.startOfDay(for: Date())
        
        // Only record usage if session was 5 minutes or longer
        if duration >= 300 {
            // Check if we already recorded today
            if !usageDates.contains(where: { Calendar.current.isDate($0, inSameDayAs: today) }) {
                usageDates.append(today)
                saveUsageDates()
            }
        }
    }
    
    func determineStarImage() -> String {
        let today = Date()
        
        // Check if we're in the grace period (first 4 days)
        if let firstUse = firstUse {
            let daysSinceFirstUse = Calendar.current.dateComponents([.day], from: firstUse, to: today).day ?? 0
            print("Days since first use: \(daysSinceFirstUse)") // Debug print
            if daysSinceFirstUse < 4 {
                return "StarHappy"
            }
        }
        
        // Get usage count for last 7 days
        let lastWeek = Calendar.current.date(byAdding: .day, value: -7, to: today)!
        let usageCount = usageDates.filter { date in
            date >= lastWeek && date <= today
        }.count
        
        // Return appropriate star based on usage
        switch usageCount {
        case 5...:
            return "StarSuper"
        case 4:
            return "StarHappy"
        case 3:
            return "StarMaybe"
        default:
            return "StarSad"
        }
    }
    
    // Helper method to clear all data (for testing)
    func clearData() {
        usageDates = []
        firstUse = nil
        defaults.removeObject(forKey: usageDatesKey)
        defaults.removeObject(forKey: firstUseKey)
    }
} 
