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
    @State var showAddSheet: Bool = false
    @State var showChooseSheet: Bool = false
    @State var selectedSpan: SpanModel = SpanModel(name: "5 Miles", length: 5.0)
   
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    if vm.goalBool == true {
                        goalRow
                            .onLongPressGesture(perform: {
                                showChooseSheet = true
                            })
                            .listRowSeparator(.hidden)
                        
                    } else {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.accentColor)
                            .frame(height: 125)
                            .overlay {
                                VStack {
                                    Text("Welcome!!")
                                        .font(.largeTitle)
                                    Text("Add a goal in the top right corner!")
                                        .font(.headline)
                                }
                                .multilineTextAlignment(.center)
                                .foregroundColor(.green)
                            }
                        
                    }
                    
                   todayRow
                        .listRowSeparator(.hidden)
                        .listRowBackground(rowBackground)
                    weekRow
                        .onTapGesture {
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
                .sheet(isPresented: $showAddSheet, content: {
                    NewGoalSpanView(vm: vm, showAddSheet: $showAddSheet).presentationDetents([.height(350)])
                        .presentationDragIndicator(.visible)
                })
                
                
                .refreshable {
                    vm.fetchAllStats()
                }
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("\(vm.queriesRan)")
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        
                        Menu("Add Goal") {
                            Button {
                                showAddSheet.toggle()
                            } label: {
                                Text("Custom Goal")
                            }
                            
                            Button {
                                showChooseSheet.toggle()
                            } label: {
                                Text("Select a preset goal")
                            }


                        }
                        .tint(.blue)
                    }
                })
            .navigationTitle("Distance")
            }
            .sheet(isPresented: $showChooseSheet) {
                ChooseGoalView(vm: vm, showChooseSheet: $showChooseSheet, selectedSpan: $selectedSpan).presentationDetents([.height(250)])
                    .presentationDragIndicator(.visible)
            }
            }
        
        .onAppear {
            NotificationsManager.instance.requestAuthorization()
            UNUserNotificationCenter.current().setBadgeCount(0)
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
            }
        }
        .cornerRadius(10)
        .frame(maxWidth: .infinity)
        .frame(height: 60)
    }
    
    private var goalRow: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "figure.walk.circle")
                    .resizable()
                    .frame(width: 25, height: 25)
                Text("Selected Goal")
                    .font(.title2)
                Spacer()
                Image(systemName: "xmark")
                    .onTapGesture {
                        vm.goalBool = false
                    }

            }
            .foregroundColor(.green)
            Spacer()
            HStack(alignment:.bottom) {
                Text("\(vm.goalSpan.length.asDistanceWith2Decimals())")
                    .font(.title2)
                Text("Miles")
                    .font(.footnote)
                Spacer()
                Text(vm.goalSpan.name)
            }
            Spacer()
            ProgressView(value: .some(vm.todaysMiles), total: vm.goalSpan.length) {
                HStack {
                    Text("\(vm.todaysMiles.asDistanceWith2Decimals()) Miles")
                    Spacer()
                    Text("\(vm.goalSpan.length.asDistanceWith2Decimals())")
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .tint(.green)
        }
        .cornerRadius(10)
        .frame(maxWidth: .infinity)
        .frame(height: 125)
        .padding(4)
    }
    
    private var rowBackground: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(.accentColor)
            .frame(height: 70)
            .frame(maxWidth: .infinity)
    }
}

