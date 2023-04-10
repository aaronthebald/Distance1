//
//  File.swift
//  Distance
//
//  Created by Aaron Wilson on 4/6/23.
//

import Foundation
import HealthKit

class HealthDataService: ObservableObject {
    @Published var totalMiles: Double = 0.rounded(.toNearestOrEven)
    @Published var timeFrame: startOptions = .today
    
    var totalDistance = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!
    let healthStore = HKHealthStore()
    let statistics: HKStatistics? = nil
    let lastWeek = Calendar.current.date(byAdding: .day, value:  -6, to: Date())
    
    enum startOptions {
    case today, thisWeek, thisMonth
    }
    
    private func setTimeFrame(start: startOptions) -> Date {
        switch start {
        case .today :
            return Calendar.current.startOfDay(for: Date())
        case .thisWeek :
            return Calendar.current.date(byAdding: .day, value:  -6, to: Date())!
        case .thisMonth :
            return Calendar.current.date(byAdding: .month, value: -1, to: Date())!
        }
    }
    
    func requestAccess() {
        let read: Set = [
            HKQuantityType(.distanceWalkingRunning)
        ]
        healthStore.requestAuthorization(toShare: .none, read: read) { success, error in
            if let error = error {
                print("There was an error \(error)")
            } else {
                print("There was no error")
            }
        }
        print("test ran")
    }
    
    
    func fetchStats() {
        let now = Date()
        let startOfDay = setTimeFrame(start: timeFrame)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        let query = HKStatisticsQuery(quantityType: totalDistance, quantitySamplePredicate: predicate, options: .cumulativeSum) { (query, result, error) in
            DispatchQueue.main.async {
                if let sum = result?.sumQuantity() {
                    self.totalMiles = sum.doubleValue(for: HKUnit.mile())
                    print("Step count for today: \(self.totalMiles)")
                } else {
                    print("Error fetching step count: \(error?.localizedDescription ?? "Unknown error")")
                }
            }
        }
        healthStore.execute(query)
    }
}
