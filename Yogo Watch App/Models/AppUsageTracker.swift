import Foundation

class AppUsageTracker: ObservableObject {
    static let shared = AppUsageTracker()
    
    @Published private(set) var usageDates: [Date] = []
    @Published private(set) var firstUse: Date?
    @Published private(set) var dailyUsageTimes: [Date: TimeInterval] = [:]
    @Published var currentStarImage: String = "StarMaybe"
    
    private let defaults = UserDefaults.standard
    private let usageDatesKey = "yogaUsageDates"
    private let firstUseKey = "yogaFirstUse"
    private let dailyUsageTimesKey = "yogaDailyUsageTimes"
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    private init() {
        print("AppUsageTracker: Initializing...")
        loadUsageDates()
        loadFirstUse()
        loadDailyUsageTimes()
        // Initialize first use date if not set
        if firstUse == nil {
            print("AppUsageTracker: No first use date found, initializing...")
            initializeFirstUse()
        }
        determineStarImage()
    }
    
    private func loadUsageDates() {
        print("AppUsageTracker: Loading usage dates...")
        if let savedDates = defaults.array(forKey: usageDatesKey) as? [Date] {
            usageDates = savedDates
            print("AppUsageTracker: Loaded \(usageDates.count) usage dates")
        } else {
            print("AppUsageTracker: No usage dates found")
        }
    }
    
    private func saveUsageDates() {
        print("AppUsageTracker: Saving usage dates...")
        defaults.set(usageDates, forKey: usageDatesKey)
        print("AppUsageTracker: Saved \(usageDates.count) usage dates")
    }
    
    private func loadFirstUse() {
        print("AppUsageTracker: Loading first use date...")
        firstUse = defaults.object(forKey: firstUseKey) as? Date
        if let date = firstUse {
            print("AppUsageTracker: First use date: \(date)")
        } else {
            print("AppUsageTracker: No first use date found")
        }
    }
    
    private func initializeFirstUse() {
        print("AppUsageTracker: Initializing first use date...")
        let today = Date()
        firstUse = today
        defaults.set(today, forKey: firstUseKey)
        print("AppUsageTracker: Set first use date to: \(today)")
    }
    
    private func loadDailyUsageTimes() {
        print("AppUsageTracker: Loading daily usage times...")
        if let savedTimes = defaults.dictionary(forKey: dailyUsageTimesKey) as? [String: TimeInterval] {
            var dateDict: [Date: TimeInterval] = [:]
            for (dateString, duration) in savedTimes {
                if let date = dateFormatter.date(from: dateString) {
                    dateDict[date] = duration
                }
            }
            dailyUsageTimes = dateDict
            print("AppUsageTracker: Loaded \(dailyUsageTimes.count) daily usage times")
        } else {
            print("AppUsageTracker: No daily usage times found")
        }
    }
    
    private func saveDailyUsageTimes() {
        print("AppUsageTracker: Saving daily usage times...")
        var stringDict: [String: TimeInterval] = [:]
        for (date, duration) in dailyUsageTimes {
            stringDict[dateFormatter.string(from: date)] = duration
        }
        defaults.set(stringDict, forKey: dailyUsageTimesKey)
        print("AppUsageTracker: Saved \(dailyUsageTimes.count) daily usage times")
    }
    
    func recordUsage(duration: TimeInterval) {
        print("AppUsageTracker: Recording usage duration: \(duration)")
        let today = Calendar.current.startOfDay(for: Date())
        print("AppUsageTracker: Today's date: \(today)")
        
        // Add the duration to today's total usage
        let currentTotal = dailyUsageTimes[today] ?? 0
        dailyUsageTimes[today] = currentTotal + duration
        print("AppUsageTracker: Updated total for today: \(dailyUsageTimes[today] ?? 0)")
        
        saveDailyUsageTimes()
        
        // If total usage for today reaches or exceeds 5 minutes, record the day
        if dailyUsageTimes[today]! >= 300 {
            print("AppUsageTracker: Usage threshold reached, recording day")
            // Check if we already recorded today
            if !usageDates.contains(where: { Calendar.current.isDate($0, inSameDayAs: today) }) {
                usageDates.append(today)
                saveUsageDates()
                print("AppUsageTracker: Added today to usage dates")
            } else {
                print("AppUsageTracker: Today already recorded")
            }
        }
        
        // Update star image based on usage
        determineStarImage()
    }
    
    func determineStarImage() {
        print("AppUsageTracker: Determining star image...")
        let today = Date()
        
        // Check if we're in the grace period (first 4 days)
        if let firstUse = firstUse {
            let daysSinceFirstUse = Calendar.current.dateComponents([.day], from: firstUse, to: today).day ?? 0
            print("AppUsageTracker: Days since first use: \(daysSinceFirstUse)")
            if daysSinceFirstUse <= 4 {
                print("AppUsageTracker: In grace period, setting StarHappy")
                currentStarImage = "StarHappy"
                return
            }
        }
        
        // Get usage count for last 7 days
        let lastWeek = Calendar.current.date(byAdding: .day, value: -7, to: today)!
        let usageCount = usageDates.filter { date in
            date >= lastWeek && date <= today
        }.count
        print("AppUsageTracker: Usage count for last 7 days: \(usageCount)")
        
        // Return appropriate star based on usage
        switch usageCount {
        case 5...:
            print("AppUsageTracker: Setting StarSuper")
            currentStarImage = "StarSuper"
        case 4:
            print("AppUsageTracker: Setting StarHappy")
            currentStarImage = "StarHappy"
        case 3:
            print("AppUsageTracker: Setting StarMaybe")
            currentStarImage = "StarMaybe"
        default:
            print("AppUsageTracker: Setting StarSad")
            currentStarImage = "StarSad"
        }
    }
    
    func clearData() {
        print("AppUsageTracker: Clearing all data...")
        usageDates.removeAll()
        firstUse = nil
        dailyUsageTimes.removeAll()
        currentStarImage = "StarMaybe"
        defaults.removeObject(forKey: usageDatesKey)
        defaults.removeObject(forKey: firstUseKey)
        defaults.removeObject(forKey: dailyUsageTimesKey)
        print("AppUsageTracker: Data cleared")
    }
} 
