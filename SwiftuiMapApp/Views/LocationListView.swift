//
//  LocationListView.swift
//  SwiftuiMapApp
//
//  Created by Ensi Khosravi on 13.06.2024.
//

import SwiftUI

struct LocationListView: View {
    @EnvironmentObject private var vm : LocationsViewModel
    
    var body: some View {
        List {
            ForEach(vm.locations) { location in
              listRowView(location: location)
                    .padding(.vertical, 3)
                    .listRowBackground(Color.clear)
                    .onTapGesture {
                        vm.showNextLocation(location: location)
                    }
            }
        }
        .listStyle(PlainListStyle())
    }
}

#Preview {
    LocationListView()
        .environmentObject(LocationsViewModel())
}

extension LocationListView {
    
    private func listRowView(location: Location) -> some View {
        HStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 45, height: 45)
                    .cornerRadius(10)
            }
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.headline)
                Text(location.cityName)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
