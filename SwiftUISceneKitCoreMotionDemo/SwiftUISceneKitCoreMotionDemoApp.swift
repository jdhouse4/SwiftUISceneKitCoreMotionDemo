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

    @StateObject var aircraftCloudUserDefaults = AircraftCloudUserDefaults()
    
    /*
    @StateObject var aircraftCloudDefaults = AircraftCloudDefaults
    */
    // Step 2: Create an initializer to create the aircraftCloudDefaults and place it into the StateObject.
    init() {
        // Step 3: Create an instance of aircraftCloudDefaults.
        let aircraftCloudUserDefaults = AircraftCloudUserDefaults()
        
        // Step 4: Assign the @StateObject var aircraftCloudUserDefaults as a wrapped value of the instance of AircraftCloudUserDefaults.
        _aircraftCloudUserDefaults      = StateObject(wrappedValue: aircraftCloudUserDefaults)
    }
    

    var body: some Scene {
       
        WindowGroup {
            ContentView()
                .environmentObject(aircraftCloudUserDefaults)
        }
    }
}
