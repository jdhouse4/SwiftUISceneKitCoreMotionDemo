//
//  SwiftUISceneKitCoreMotionDemoApp.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 10/18/20.
//

import SwiftUI

@main
struct SwiftUISceneKitCoreMotionDemoApp: App {
    
    // Step 1: Use a StateObject property wrapper to wrap a var aircraftCloudDefaults of type AircraftCloudDefaults.
    // This insures that our app will create and own its aircrafCloudDefaults and ensure it stays alive the
    // entire time the app is running.
    //
    // This alone is just a StateObject struct with aircraftCloudDefaults declared within it.
    //@StateObject var aircraftCloudDefaults = AircraftCloudDefaults.shared

    
    /*
    @StateObject var aircraftCloudDefaults = AircraftCloudDefaults
    
    // Step 2: Create an initializer to create the aircraftCloudDefaults and place it into the StateObject.
    init() {
        // Step 3: Create an instance of aircraftCloudDefaults.
        let aircraftCloudDefaults = AircraftCloudDefaults()
        
        // Step 4: Assign the @StateObject var aircraftCloudDefaults as a wrapped value of the instance of AircraftCloudDefaults.
        _aircraftCloudDefaults      = StateObject(wrappedValue: aircraftCloudDefaults)
    }
     */
    

    var body: some Scene {
       
        WindowGroup {
            ContentView()
                .environmentObject(aircraftCloudDefaults)
        }
    }
}
