//
//  Logic.swift
//  Yogo Watch App
//
//  Created by Whitney Wordlaw on 3/25/25.
//
import Combine
import Foundation
import AVFoundation
import HealthKit

// MARK: - CurrentYoga (ObservableObject)
class CurrentYoga: ObservableObject {
    @Published var flow: String
    @Published var time: Int  // Time in seconds
    @Published var flowCount: Int
    @Published var heart: Double
    @Published var calories: Double
    @Published var isIntermediate: Bool

    let healthStore = HKHealthStore()

    init(flow: String = "GentleMorningFlowMP3", time: Int = 600, flowCount: Int = 0, heart: Double = 0, calories: Double = 0, isIntermediate: Bool = false) {
        self.flow = flow
        self.time = time
        self.flowCount = flowCount
        self.heart = heart
        self.calories = calories
        self.isIntermediate = isIntermediate
    }

    func updateTime(selectedTime: Int) {
        self.time = selectedTime
    }

    func updateFlow(newFlow: String) {
        self.flow = newFlow
    }

    func setLevel(isIntermediate: Bool) {
        self.isIntermediate = isIntermediate
    }

    func fetchHealthData() {
        guard HKHealthStore.isHealthDataAvailable() else { return }

        let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate)!
        let energyBurnedType = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!

        let typesToRead: Set = [heartRateType, energyBurnedType]

        healthStore.requestAuthorization(toShare: nil, read: typesToRead) { success, error in
            if success {
                self.getHeartRate()
                self.getCaloriesBurned()
            }
        }
    }

    private func getHeartRate() {
        let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        let query = HKSampleQuery(sampleType: heartRateType, predicate: nil, limit: 1, sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)]) { _, results, _ in
            guard let sample = results?.first as? HKQuantitySample else { return }
            let heartRate = sample.quantity.doubleValue(for: HKUnit(from: "count/min"))
            DispatchQueue.main.async {
                self.heart = heartRate
            }
        }
        healthStore.execute(query)
    }

    private func getCaloriesBurned() {
        let energyBurnedType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
        let query = HKSampleQuery(sampleType: energyBurnedType, predicate: nil, limit: 1, sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)]) { _, results, _ in
            guard let sample = results?.first as? HKQuantitySample else { return }
            let calories = sample.quantity.doubleValue(for: HKUnit.kilocalorie())
            DispatchQueue.main.async {
                self.calories = calories
            }
        }
        healthStore.execute(query)
    }
}
