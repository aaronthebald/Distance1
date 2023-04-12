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
    @Published var spans: [SpanModel] = []
    @Published var nearestSpan: SpanModel?
    
    init() {
        spans = SpansServices().getSpans()
        spans.sort(by: { $0.length < $1.length})
        print(spans.description)
        requestAccess()
        fetchStats()
        backgroundQuery()
    }
    
    var totalDistance = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!
    let healthStore = HKHealthStore()
    
    enum startOptions {
    case today, thisWeek, thisMonth
    }
    
    
    // Function to change start paramiter
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
    
    // requests access to the healthStore
    func requestAccess() {
        let read: Set = [
            HKQuantityType(.distanceWalkingRunning)
        ]
        healthStore.requestAuthorization(toShare: .none, read: read) { success, error in
            if let error = error {
                print("There was an error \(error)")
            } else {
                print("Access to healthStore granted")
            }
        }
        enableBackgroundDelivery()
    }
    
    // reads the healthStore and updates published varibles
    func fetchStats() {
        let now = Date()
        let startOfDay = setTimeFrame(start: timeFrame)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        let query = HKStatisticsQuery(quantityType: totalDistance, quantitySamplePredicate: predicate, options: .cumulativeSum) { (query, result, error) in
            DispatchQueue.main.async {
                if let sum = result?.sumQuantity() {
                    self.totalMiles = sum.doubleValue(for: HKUnit.mile())
                    print("Fetch Stats ran")
                } else {
                    print("Error fetching step count: \(error?.localizedDescription ?? "Unknown error")")
                }
            }
        }
        healthStore.execute(query)
    }
    
    // grants permission to moniter healthStore in the background
    func enableBackgroundDelivery() {
        healthStore.enableBackgroundDelivery(for: HKQuantityType(.distanceWalkingRunning), frequency: .hourly) { success, error in
            if let error = error {
                print("there was an error \(error)")
            }
            if success {
                print("Permission for background queries granted")
            }
        }
    }
    
    // Moniters healthStore for changes to the HKQuanttyType distanceWalkingRunning
    func backgroundQuery() {
        let typeToRead = HKQuantityType(.distanceWalkingRunning)
        let newPredicate = HKQuery.predicateForObjects(from: .default())
        

        let observerQuery = HKObserverQuery(sampleType: typeToRead, predicate: newPredicate) { (query, completionHandler, errorOrNil) in
            guard errorOrNil == nil else {
                print("Error: \(errorOrNil!.localizedDescription)")
                return
            }
            // Perform any necessary actions when the observer query detects a change
            self.fetchStats()
            self.getNearestSpan()
            print("Observer query detected a change")
            completionHandler()
        }
        healthStore.execute(observerQuery)
    }
    
    // Itterates over the array of spans to find the closest one to the totalMiles var and schedules notification with that info
    func getNearestSpan() {
        if let nearestSpan = spans.last(where: {$0.length <= totalMiles}) {
            print(nearestSpan.name)
            NotificationsManager.instance.distanceNotification(span: nearestSpan)
        } else {
            print("You havent walked enough to get a notification yet...")
        }
    }
}
