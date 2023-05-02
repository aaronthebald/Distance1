//
//  NewGoalSpanView.swift
//  Distance
//
//  Created by Aaron Wilson on 4/26/23.
//

import SwiftUI

struct NewGoalSpanView: View {
    @ObservedObject var vm: HealthDataService
    @Binding var showAddSheet: Bool
    @Binding var selectedSpan: SpanModel
    @State var custom: Bool = false

    var body: some View {
        NavigationStack {
            
            ZStack {
                List {
                    TextField("Name...", text: $vm.goalName)
                    TextField("Mileage...", text: $vm.goalDistance)
                        .keyboardType(.decimalPad)
                }
                .navigationTitle("Create Goal")
                saveButton
            }
            .background(.ultraThickMaterial)
        }
    }
}

struct NewGoalSpanView_Previews: PreviewProvider {
    static var previews: some View {
        NewGoalSpanView(vm: HealthDataService(), showAddSheet: .constant(true), selectedSpan: .constant(SpanModel(name: "Test", length: 1.5)))
    }
}
extension NewGoalSpanView {
    
    private var saveButton: some View {
        HStack {
            Spacer()
            Button {
                guard let distance = Double(vm.goalDistance) else {
                    print("Getting double failed")
                    return
                }
                vm.goalSpan = SpanModel(name: vm.goalName, length: distance)
                showAddSheet = false
            } label: {
                Text("Save")
                    .font(.title3)
                    .frame(width: 200)
            }
            .tint(.blue)
            .buttonStyle(.borderedProminent)
            Spacer()
        }
    }
}
