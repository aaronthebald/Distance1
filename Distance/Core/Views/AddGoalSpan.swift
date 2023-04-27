//
//  AddGoalSpan.swift
//  Distance
//
//  Created by Aaron Wilson on 4/24/23.
//

import SwiftUI

struct AddGoalSpan: View {
    @ObservedObject var vm: HealthDataService
    @Binding var showAddSheet: Bool
    @State var selectedSpan: SpanModel = SpanModel(name: "5 Miles", length: 5.0)
    var body: some View {
        VStack {
            HStack {
                Text("Select a Goal:")
                Spacer()
                Picker("Choose", selection: $selectedSpan) {
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
            .padding(.horizontal)
            .background(Color.accentColor)
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.3), radius: 10)
            .padding(.horizontal)
            Button {
                print("tap detected")
                    vm.goalSpan = selectedSpan
                showAddSheet = false
            } label: {
                Text("Save")
                    .foregroundColor(.blue)
            }
            .buttonStyle(BorderedButtonStyle())
        }
    }
}

struct AddGoalSpan_Previews: PreviewProvider {
    static var previews: some View {
        AddGoalSpan(vm: HealthDataService(), showAddSheet: .constant(true))
    }
}
