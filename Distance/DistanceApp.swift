//
//  DistanceApp.swift
//  Distance
//
//  Created by Aaron Wilson on 4/6/23.
//

import SwiftUI

@main
struct DistanceApp: App {
//    Commented out because i run the func too many times  I cant remember if this is how i fixed the backgeround query
//    init() {
//        HealthDataService().enableBackgroundDelivery()
//    }
    
    var body: some Scene {
        WindowGroup {
            DistanceHomeView()
        }
    }
}
