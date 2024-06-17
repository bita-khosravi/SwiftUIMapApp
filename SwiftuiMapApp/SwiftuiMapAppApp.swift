//
//  SwiftuiMapAppApp.swift
//  SwiftuiMapApp
//
//  Created by Ensi Khosravi on 12.06.2024.
//

import SwiftUI

@main
struct SwiftuiMapAppApp: App {
    
    @StateObject private var vm = LocationsViewModel()

    
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}
