//
//  SwiftUISceneKitCoreMotionDemoApp.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 10/18/20.
//

import SwiftUI

@main
struct SwiftUISceneKitCoreMotionDemoApp: App {
    
    //@Environment(\.scenePhase) var scenePhase
    
    // Step 1: Use a StateObject property wrapper to wrap a var aircraftCloudDefaults of type AircraftCloudDefaults.
    // This insures that our app will create and own its aircrafCloudDefaults and ensure it stays alive the
    // entire time the app is running.
    //
    // This alone is just a StateObject struct with aircraftCloudDefaults declared within it.
    //@StateObject var aircraftCloudDefaults = AircraftCloudDefaults.shared

    @StateObject var motionManager              = MotionManager.shared
    @StateObject var aircraftCloudUserDefaults  = AircraftCloudUserDefaults.shared

    var body: some Scene {
       
        WindowGroup {
            ContentView()
                .environmentObject(aircraftCloudUserDefaults)
                .environmentObject(motionManager)
                .onAppear {
                    motionManager.setupDeviceMotion()
                }
                .onDisappear {
                    motionManager.stopMotion()
                }
        }
    }
}
