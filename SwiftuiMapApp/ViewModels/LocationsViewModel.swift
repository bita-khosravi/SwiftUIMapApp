//
//  LocationsViewModel.swift
//  SwiftuiMapApp
//
//  Created by Ensi Khosravi on 12.06.2024.
//

import Foundation
import MapKit
import SwiftUI

class LocationsViewModel: ObservableObject {
    // All loaded locations
    @Published var locations: [Location]
    // Current location on the map
    @Published var mapLocation: Location {
        didSet {
            UpdateMapRegion(location: mapLocation)
        }
    }
    // Current region on the map
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    // Show list of locations
    @Published var showLocationsList: Bool = false
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        self.UpdateMapRegion(location: locations.first!)
    }
    
    private func UpdateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(center: location.coordinates, span: mapSpan)
        }
    }
    
    func toggleLocationsList() {
        withAnimation(.easeInOut) {
            showLocationsList = !showLocationsList
        }
    }
    
    func showNextLocation(location: Location) {
        withAnimation {
            mapLocation = location
            showLocationsList = false
        }
    }
    
    func nextButtonPressed() {
//        guard let currentLocationIndex = locations.firstIndex(where: { $0 == currentLocation }) else {
//            return
//        }
//        var nextLocation : Location
//        if currentLocationIndex == locations.count - 1 {
//            nextLocation = locations.first!
//        } else {
//            nextLocation = locations[currentLocationIndex + 1]
//        }
//        
//        showNextLocation(location: nextLocation)
        
        
        // Get the current index
        guard let currentIndex = locations.firstIndex(where: { $0 == mapLocation }) else {
            print("Could not find current index in location arry! should never happen.")
            return
        }
        
        // Check if the currentIndex is valid
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            // Next index is NOT valid
            // Restart from 0
            guard let firstLocation = locations.first else { return }
            showNextLocation(location: firstLocation)
            return
        }
        
        // Next index IS valid
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
        
    }
}
