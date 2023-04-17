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
        NavigationStack {
            List {
               todayRow
                    .listRowSeparator(.hidden)
                    .listRowBackground(rowBackground)
                weekRow
                    .listRowSeparator(.hidden)
                    .listRowBackground(rowBackground)
                monthRow
                    .listRowSeparator(.hidden)
                    .listRowBackground(rowBackground)
                yearRow
                    .listRowSeparator(.hidden)
                    .listRowBackground(rowBackground)
                
                                    
            }
            .navigationTitle("Distance")
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

extension DistanceHomeView {
    
    private var todayRow: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "figure.walk.circle")
                    .resizable()
                    .frame(width: 25)
                Text("Today:")
                    .font(.title2)
                Spacer()
            }
            .foregroundColor(.green)
            Spacer()
            HStack(alignment:.bottom) {
                Text("\(vm.todaysMiles.asDistanceWith2Decimals())")
                    .font(.title2)
                Text("Miles")
                    .font(.footnote)
                Spacer()
                Text(vm.todaysSpan?.name ?? "Error")
                    .font(.subheadline)
            }
            
        }
        .cornerRadius(10)
        .frame(maxWidth: .infinity)
        .frame(height: 60)
    }
    
    
    private var weekRow: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "figure.walk.circle")
                    .resizable()
                    .frame(width: 25)
                Text("This Week:")
                    .font(.title2)
                Spacer()
            }
            .foregroundColor(.green)
            Spacer()
            HStack(alignment:.bottom) {
                Text("\(vm.weekMiles.asDistanceWith2Decimals())")
                    .font(.title2)
                Text("Miles")
                    .font(.footnote)
                Spacer()
                Text(vm.weeksSpan?.name ?? "Error")
                    .font(.subheadline)
            }
            
        }
        .cornerRadius(10)
        .frame(maxWidth: .infinity)
        .frame(height: 60)
    }
    
    private var monthRow: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "figure.walk.circle")
                    .resizable()
                    .frame(width: 25)
                Text("This Month:")
                    .font(.title2)
                Spacer()
            }
            .foregroundColor(.green)
            Spacer()
            HStack(alignment:.bottom) {
                Text("\(vm.monthMiles.asDistanceWith2Decimals())")
                    .font(.title2)
                Text("Miles")
                    .font(.footnote)
                Spacer()
                Text(vm.monthsSpan?.name ?? "Error")
                    .font(.subheadline)
            }
        }
        .cornerRadius(10)
        .frame(maxWidth: .infinity)
        .frame(height: 60)
    }
    
    private var yearRow: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "figure.walk.circle")
                    .resizable()
                    .frame(width: 25)
                Text("This Year:")
                    .font(.title2)
                Spacer()
            }
            .foregroundColor(.green)
            Spacer()
            HStack(alignment:.bottom) {
                Text("\(vm.yearMiles.asDistanceWith2Decimals())")
                    .font(.title2)
                Text("Miles")
                    .font(.footnote)
                Spacer()
                Text(vm.yearsSpan?.name ?? "Error")
                    .font(.subheadline)
            }
        }
        .cornerRadius(10)
        .frame(maxWidth: .infinity)
        .frame(height: 60)
    }
    
    private var rowBackground: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(.white)
            .frame(height: 70)
            .frame(maxWidth: .infinity)
    }
    
    }



//extension DistanceHomeView {
//
//    private var timeStack: some View {
//        VStack(alignment: .leading) {
//            Text("Today: \(vm.todaysMiles.asDistanceWith2Decimals())")
//            Text("This Week: \(vm.weekMiles.asDistanceWith2Decimals())")
//            Text("This Month: \(vm.monthMiles.asDistanceWith2Decimals())")
//            Text("This Year: \(vm.yearMiles.asDistanceWith2Decimals())")
//        }
//    }
//
//    private var spanStack: some View {
//        VStack(alignment: .leading) {
//            VStack(alignment: .leading) {
//                Image(systemName: "compass.drawing")
//                Text(vm.todaysSpan?.name ?? "Error")
//            }
//            VStack(alignment: .leading) {
//                Image(systemName: "compass.drawing")
//                Text(vm.weeksSpan?.name ?? "Error")
//            }
//            VStack(alignment: .leading) {
//                Image(systemName: "compass.drawing")
//                Text(vm.monthsSpan?.name ?? "Error")
//            }
//            VStack(alignment: .leading) {
//                Image(systemName: "compass.drawing")
//                Text(vm.yearsSpan?.name ?? "Error")
//            }
//        }
//    }
//
//    private var todayRow: some View {
//        HStack {
//            Text("Today: \(vm.todaysMiles.asDistanceWith2Decimals())")
//            Spacer()
//            VStack(alignment: .leading) {
//                Image(systemName: "compass.drawing")
//                Text(vm.todaysSpan?.name ?? "Error")
//            }
//        }
//    }
//
//    private var weekRow: some View {
//        HStack {
//            Text("This Week: \(vm.weekMiles.asDistanceWith2Decimals())")
//            Spacer()
//            VStack(alignment: .leading) {
//                Image(systemName: "compass.drawing")
//                Text(vm.weeksSpan?.name ?? "Error")
//            }
//        }
//
//    }
//    private var monthRow: some View {
//        HStack {
//            Text("This Month: \(vm.monthMiles.asDistanceWith2Decimals())")
//            Spacer()
//            VStack(alignment: .leading) {
//                Image(systemName: "compass.drawing")
//                Text(vm.monthsSpan?.name ?? "Error")
//            }
//        }
//    }
//
//    private var yearRow: some View {
//        HStack {
//            Text("This Year: \(vm.yearMiles.asDistanceWith2Decimals())")
//            Spacer()
//            VStack(alignment: .leading) {
//                Image(systemName: "compass.drawing")
//                Text(vm.yearsSpan?.name ?? "Error")
//            }
//        }
//    }
//}
