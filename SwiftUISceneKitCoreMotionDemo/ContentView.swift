//
//  ContentView.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 10/18/20.
//

import SwiftUI
import SceneKit




struct ContentView: View {


    //
    // @StateObject is a property wrapper type that instantiates an observable object.
    //
    @StateObject var aircraft                   = AircraftSceneKitScene()
    @StateObject var aircraftDelegate           = AircraftSceneRendererDelegate()
    @StateObject var aircraftSunlightButton     = AircraftSunlightButton()
    @StateObject var aircraftCameraButton       = AircraftCameraButton()
    @StateObject var aircraftSettingsButton     = AircraftSettingsButton()
    @StateObject var aircraftAnalyticsButton    = AircraftAnalyticsButton()
    @StateObject var aircraftEngineThrottle     = AircraftEngineThrottle()
    @StateObject var aircraftRotationButton     = AircraftRCSButtons()


    var body: some View {

        ZStack {

            AircraftSceneView()
            
            AircraftButtonsView()
            

            VStack {
                
                TopRowButtonsView()
                
                Spacer()
                
                BottomRowButtonsView()
                
            }
            //.background(Color.white.opacity(0.75))

        }
        .background(Color.black)
        .statusBar(hidden: true)

        .environmentObject(aircraft)
        .environmentObject(aircraftDelegate)
        .environmentObject(aircraftSunlightButton)
        .environmentObject(aircraftCameraButton)
        .environmentObject(aircraftAnalyticsButton)
        .environmentObject(aircraftSettingsButton)
        .environmentObject(aircraftEngineThrottle)
        .environmentObject(aircraftRotationButton)
    }
    
    
    
    func loadSettings() {
    }
}



/*
 struct ContentView_Previews: PreviewProvider {
 static var previews: some View {
 ContentView()
 }
 }
 */
