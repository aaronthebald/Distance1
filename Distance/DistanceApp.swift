//
//  DistanceApp.swift
//  Distance
//
//  Created by Aaron Wilson on 4/6/23.
//

import SwiftUI

@main
struct DistanceApp: App {
    
    init() {
        HealthDataService().enableBackgroundDelivery()
    }
    
    var body: some Scene {
        WindowGroup {
            DistanceHomeView()
        }
    }
}
