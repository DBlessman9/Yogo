import Foundation
import HealthKit
import WatchKit

public class WorkoutManager: ObservableObject {
    public static let shared = WorkoutManager()
    
    private let healthStore = HKHealthStore()
    private var workoutSession: HKWorkoutSession?
    private var workoutBuilder: HKLiveWorkoutBuilder?
    
    @Published public var isWorkoutActive = false
    
    private init() {}
    
    public func startWorkout() {
        let configuration = HKWorkoutConfiguration()
        configuration.activityType = .other
        configuration.locationType = .indoor
        
        do {
            workoutSession = try HKWorkoutSession(healthStore: healthStore, configuration: configuration)
            workoutBuilder = workoutSession?.associatedWorkoutBuilder()
            
            workoutBuilder?.dataSource = HKLiveWorkoutDataSource(healthStore: healthStore, workoutConfiguration: configuration)
            workoutSession?.startActivity(with: Date())
            workoutBuilder?.beginCollection(withStart: Date()) { (success, error) in
                if success {
                    self.isWorkoutActive = true
                }
            }
        } catch {
            print("Failed to start workout: \(error.localizedDescription)")
        }
    }
    
    public func endWorkout() {
        workoutSession?.end()
        workoutBuilder?.endCollection(withEnd: Date()) { (success, error) in
            if success {
                self.isWorkoutActive = false
            }
        }
    }
} 