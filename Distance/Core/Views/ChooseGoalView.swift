//
//  ChooseGoalView.swift
//  Distance
//
//  Created by Aaron Wilson on 4/26/23.
//

import SwiftUI

struct ChooseGoalView: View {
    
    @ObservedObject var vm: HealthDataService
    @Binding var showChooseSheet: Bool
    @Binding var selectedSpan: SpanModel
    
    var body: some View {
        NavigationStack {
            List {
                HStack {
                    Text("Select a Goal:")
                    Spacer()
                    Picker("", selection: $selectedSpan) {
                        ForEach(vm.spans, id: \.self) { span in
                            HStack {
                                Text(span.name)
                                Text("\(span.length)")
                            }
                                .tag(span)
                        }
                    }
                    .tint(.blue)
                }

                HStack {
                    Spacer()
                    Button {
                        vm.goalName = selectedSpan.name
                        vm.goalDistance = "\(selectedSpan.length)"
                        vm.fetchGoalSpan()
                        showChooseSheet = false
                    } label: {
                        Text("Save")
                    }
                    .tint(.blue)
                    .buttonStyle(BorderedProminentButtonStyle())

                }
            }
            .navigationTitle("Choose Goal:")
        }
    }
}

struct ChooseGoalView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseGoalView(vm: HealthDataService(), showChooseSheet: .constant(true), selectedSpan: .constant(SpanModel(name: "Testing", length: 2.0)))
    }
}
