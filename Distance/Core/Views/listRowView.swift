//
//  listRowView.swift
//  Distance
//
//  Created by Aaron Wilson on 4/17/23.
//

import SwiftUI

struct listRowView: View {
    
    @ObservedObject var vm: HealthDataService
    
    var body: some View {
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
            HStack {
                Text("\(vm.todaysMiles.asDistanceWith2Decimals())")
                    .font(.title2)
                Spacer()
                Text(vm.todaysSpan?.name ?? "Error")
                    .font(.title2)
            }
            
        }
        .cornerRadius(10)
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .padding(.horizontal)
    }
}

struct listRowView_Previews: PreviewProvider {
    static var previews: some View {
        listRowView(vm: HealthDataService())
    }
}
