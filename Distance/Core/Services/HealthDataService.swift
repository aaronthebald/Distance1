//
//  File.swift
//  Distance
//
//  Created by Aaron Wilson on 4/6/23.
//

import Foundation
import HealthKit
import Combine
import SwiftUI

class HealthDataService: ObservableObject {
    @Published var todaysMiles: Double = 0
    @Published var weekMiles: Double = 0
    @Published var monthMiles: Double = 0
    @Published var yearMiles: Double = 0
    @Published var goalSpan: SpanModel?
    @Published var timeFrame: startOptions = .today
    @Published var weekSF: Bool = false
    @Published var monthSF: Bool = false
    @Published var yearSF: Bool = false
    @Published var spans: [SpanModel] = []
    @Published var todaysSpan: SpanModel?
    @Published var weeksSpan: SpanModel?
    @Published var monthsSpan: SpanModel?
    @Published var yearsSpan: SpanModel?
    @Published var completedSpans: [SpanModel] = []
    @Published var queriesRan: Int = 0
    
    var cancelables = Set<AnyCancellable>()
    @AppStorage("goalName") var goalName: String = ""
    @AppStorage("goalDistance") var goalDistance: String = ""

    
    
    init() {
        spans = SpansServices().getSpans()
        spans.sort(by: { $0.length < $1.length})
        requestAccess()
        print("Init ran")
        fetchGoalSpan()
        observeTodaysMiles()
        print(goalSpan as Any)
    }
    
    var totalDistance = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!
    let healthStore = HKHealthStore()
    
    enum startOptions {
    case today, thisWeekSoFar, thisMonthSoFar, thisYearSoFar, past7Days, pastMonth, PastYear
    }
    
     func fetchGoalSpan() {
        guard let distance = Double(goalDistance)
        else {
            print("Faild to assign double to goal span")
            return
        }
        goalSpan = SpanModel(name: goalName, length: distance)
    }
    
    private func observeTodaysMiles() {
        $todaysMiles
            .sink { [weak self] miles in
                guard let span = self?.goalSpan else {return}
                if miles >= span.length {
                    NotificationsManager.instance.distanceNotification(span: span, timeFrame: "Today")
                    self?.goalSpan = nil
                    self?.goalName = ""
                    self?.goalDistance = ""
                }
            }
            .store(in: &cancelables)
    }
    
    // Function to change start paramiter
    private func setTimeFrame(start: startOptions) -> Date {
        switch start {
        case .today :
            return Calendar.current.startOfDay(for: Date())
        case .thisWeekSoFar :
            let begOfWeek = Date().startOfWeek(using: Calendar.current)
            return begOfWeek

        case .thisMonthSoFar :
            let currentMonth = Calendar.current.component(.month, from: Date())
            let begOfMonth = Calendar.current.nextDate(
                after: .now,
                matching: DateComponents(month: currentMonth, day: 1),
                matchingPolicy: .nextTime,
                direction: .backward
            )
            return begOfMonth!
            
        case .thisYearSoFar :
            let begOfYear = Calendar.current.nextDate(
                after: .now,
                matching: DateComponents(month: 1, day: 1),
                matchingPolicy: .nextTime,
                direction: .backward
            )
            return begOfYear!
        case .past7Days :
            return Calendar.current.date(byAdding: .day, value: -7, to: Date())!
            
        case .pastMonth :
            return Calendar.current.date(byAdding: .month, value: -1, to: Date())!

        case .PastYear :
            return Calendar.current.date(byAdding: .year, value: -1, to: Date())!
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
                
            }
        }
        enableBackgroundDelivery()
    }
    
    // grants permission to moniter healthStore in the background
    func enableBackgroundDelivery() {
        healthStore.enableBackgroundDelivery(for: HKQuantityType(.distanceWalkingRunning), frequency: .immediate) { success, error in
            if let error = error {
                print("there was an error \(error)")
            }
            if success {
                self.backgroundQuery()
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
            DispatchQueue.main.sync {
                self.fetchAllStats()
                self.queriesRan += 1
                print("Observer query detected a change")
            }
            completionHandler()
        }
        healthStore.execute(observerQuery)
    }
    
    // reads the healthStore and updates published varibles
    func fetchAllStats() {
            fetchTodayStats()
            fetchWeekStats()
            fetchMonthStats()
            fetchYearStats()
    }
    
    func fetchTodayStats() {
        let now = Date()
        let startOfDay = setTimeFrame(start: .today)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        let query = HKStatisticsQuery(quantityType: totalDistance, quantitySamplePredicate: predicate, options: .cumulativeSum) { (query, result, error) in
            DispatchQueue.main.async { [self] in
                if let sum = result?.sumQuantity() {
                    self.todaysMiles = sum.doubleValue(for: HKUnit.mile())
                    print("Today Stats ran")
                    if self.todaysSpan != spans.last(where: {$0.length <= todaysMiles}) {
                        getTodaysSpan()
                    }
                } else {
                    print("Error fetching step count: \(error?.localizedDescription ?? "Unknown error")")
                }
            }
        }
        healthStore.execute(query)
    }
    
    func fetchWeekStats() {
        let now = Date()
        let startOfDay = setTimeFrame(start: weekSF ? .thisWeekSoFar : .past7Days)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        let query = HKStatisticsQuery(quantityType: totalDistance, quantitySamplePredicate: predicate, options: .cumulativeSum) { (query, result, error) in
            DispatchQueue.main.async { [self] in
                if let sum = result?.sumQuantity() {
                    self.weekMiles = sum.doubleValue(for: HKUnit.mile())
                    print("Week Stats ran")
                    if self.weeksSpan != spans.last(where: {$0.length <= weekMiles}) {
                        getWeeksSpan()
                    }
                    
                } else {
                    print("Error fetching step count: \(error?.localizedDescription ?? "Unknown error")")
                }
            }
        }
        healthStore.execute(query)
    }
    
    func fetchMonthStats() {
        let now = Date()
        let startOfDay = setTimeFrame(start: monthSF ? .thisMonthSoFar : .pastMonth)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        let query = HKStatisticsQuery(quantityType: totalDistance, quantitySamplePredicate: predicate, options: .cumulativeSum) { (query, result, error) in
            DispatchQueue.main.async { [self] in
                if let sum = result?.sumQuantity() {
                    self.monthMiles = sum.doubleValue(for: HKUnit.mile())
                    print("Month Stats ran")
                    if self.monthsSpan != spans.last(where: {$0.length <= monthMiles}) {
                        getMonthsSpan()
                    }
                } else {
                    print("Error fetching step count: \(error?.localizedDescription ?? "Unknown error")")
                }
            }
        }
        healthStore.execute(query)
    }
    
    func fetchYearStats() {
        let now = Date()
        let startOfDay = setTimeFrame(start: yearSF ? .thisYearSoFar : .PastYear)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        let query = HKStatisticsQuery(quantityType: totalDistance, quantitySamplePredicate: predicate, options: .cumulativeSum) { (query, result, error) in
            DispatchQueue.main.async { [self] in
                if let sum = result?.sumQuantity() {
                    self.yearMiles = sum.doubleValue(for: HKUnit.mile())
                    print("Year Stats ran")
                    if self.yearsSpan != spans.last(where: {$0.length <= yearMiles}) {
                        getYearsSpan()
                    }
                } else {
                    print("Error fetching step count: \(error?.localizedDescription ?? "Unknown error")")
                }
            }
        }
        healthStore.execute(query)
    }


    
    func getTodaysSpan() { 
        if let nearestSpan = spans.last(where: {$0.length <= todaysMiles}) {
            print(nearestSpan.name)
            self.todaysSpan = nearestSpan
        }
    }
    
    func getWeeksSpan() {
        if let nearestSpan = spans.last(where: {$0.length <= weekMiles}) {
            print(nearestSpan.name)
            self.weeksSpan = nearestSpan
        }
    }
    
    
    func getMonthsSpan() {
        if let nearestSpan = spans.last(where: {$0.length <= monthMiles}) {
            print(nearestSpan.name)
            self.monthsSpan = nearestSpan
        }
    }
    
    func getYearsSpan() {
        if let nearestSpan = spans.last(where: {$0.length <= yearMiles}) {
            print(nearestSpan.name)
            self.yearsSpan = nearestSpan
        }
    }
}
