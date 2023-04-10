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
            HStack {
                Button {
                    vm.timeFrame = .thisMonth
                } label: {
                    Text("This month")
                }
                
                Button {
                    vm.timeFrame = .thisWeek
                } label: {
                    Text("This week")
                }
                
                Button {
                    vm.timeFrame = .today
                } label: {
                    Text("Today")
                }
            }
            .onAppear {
                vm.requestAccess()
                print("OnAppear ran")
            }

            
            Text("Miles walked:")
            Text(vm.totalMiles.asDistanceWith2Decimals())
            Button {
                vm.fetchStats()
            } label: {
                Text("Click here")
            }
        }
        
    }
}

struct DistanceHomeView_Previews: PreviewProvider {
    static var previews: some View {
        DistanceHomeView()
    }
}
