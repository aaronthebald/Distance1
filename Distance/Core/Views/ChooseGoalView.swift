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
            ZStack {
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

                    
                }
                .navigationTitle("Choose Goal:")
                HStack {
                    Spacer()
                    Button {
                        vm.goalName = selectedSpan.name
                        vm.goalDistance = "\(selectedSpan.length)"
                        vm.fetchGoalSpan()
                        showChooseSheet = false
                    } label: {
                        Text("Save")
                            .font(.title3)
                            .frame(width: 200)
                    }
                    .tint(.blue)
                    .buttonStyle(BorderedProminentButtonStyle())
                   Spacer()

                }
                Spacer()
            }
            .background(.ultraThickMaterial)
        }
    }
}

struct ChooseGoalView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseGoalView(vm: HealthDataService(), showChooseSheet: .constant(true), selectedSpan: .constant(SpanModel(name: "Testing", length: 2.0)))
    }
}
