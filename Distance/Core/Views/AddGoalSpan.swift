//
//  AddGoalSpan.swift
//  Distance
//
//  Created by Aaron Wilson on 4/24/23.
//

import SwiftUI

struct AddGoalSpan: View {
    @ObservedObject var vm: HealthDataService
    @State var selectedSpan: SpanModel = SpanModel(name: "5 Miles", length: 5.0)
    var body: some View {
        VStack {
            HStack {
                Text("Pick something")
                    .foregroundColor(.blue)
                Spacer()
                Picker("Choose", selection: $selectedSpan) {
                    ForEach(vm.spans, id: \.self) { span in
                        Text(span.name)
                            .tag(span)
                            .foregroundColor(.blue)
                    }
                }
            }
            Button {
                print("tap detected")
                    vm.goalSpan = selectedSpan
            } label: {
                Text("Save")
                    .foregroundColor(.blue)
            }
            .buttonStyle(BorderedProminentButtonStyle())
        }
    }
}

struct AddGoalSpan_Previews: PreviewProvider {
    static var previews: some View {
        AddGoalSpan(vm: HealthDataService())
    }
}
