//
//  DistanceHomeView.swift
//  Distance
//
//  Created by Aaron Wilson on 4/6/23.
//

import SwiftUI
import HealthKit

struct DistanceHomeView: View {
    @StateObject var vm: HealthDataService = HealthDataService()
    
    var body: some View {
        VStack {
            Text("Queries ran:")
            Text("\(vm.queriesRan)")
            Text("Miles walked:")
            Text(vm.totalMiles.asDistanceWith2Decimals())
            Button {
                vm.fetchStats()
            } label: {
                Text("Click here")
            }
            
            Button {
                NotificationsManager.instance.scheduleNotification(miles: vm.totalMiles)
            } label: {
                Text("Schedule Notification")
            }
            ForEach(vm.completedSpans, id: \.self) { span in
                Text("\(span.name): \(span.length.asDistanceWith2Decimals())")
            }

        }
        .onAppear {
            NotificationsManager.instance.requestAuthorization()
        }
        
    }
}

struct DistanceHomeView_Previews: PreviewProvider {
    static var previews: some View {
        DistanceHomeView()
    }
}
