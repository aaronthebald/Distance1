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
                    .onTapGesture {
                        print("tap regestured")
                        vm.weekSF.toggle()
                        vm.fetchWeekStats()
                        
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(rowBackground)
                monthRow
                    .onTapGesture {
                        vm.monthSF.toggle()
                        vm.fetchMonthStats()
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(rowBackground)
                yearRow
                    .onTapGesture {
                        print("tapped")
                        vm.yearSF.toggle()
                        vm.fetchYearStats()
                        print(vm.yearMiles)
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(rowBackground)
                
                                    
            }
            .refreshable {
                vm.fetchAllStats()
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
                Text(vm.todaysSpan?.name ?? "")
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
                Text(vm.weekSF ? "This Week So Far:" : "The Past Week:")
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
                Text(vm.weeksSpan?.name ?? "")
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
                Text(vm.monthSF ? "This Month So Far:" : "The Past Month:")
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
                Text(vm.monthsSpan?.name ?? "")
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
                Text(vm.yearSF ? "This Year So Far:" : "The Past Year:")
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
                Text(vm.yearsSpan?.name ?? "")
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

