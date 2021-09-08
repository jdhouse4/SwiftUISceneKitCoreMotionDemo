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
    @StateObject var aircraft               = AircraftSceneKitScene()
    @StateObject var aircraftDelegate       = AircraftSceneRendererDelegate()
    @StateObject var aircraftSunlightButton = AircraftSunlightButton()
    @StateObject var aircraftCameraButton   = AircraftCameraButton()
    @StateObject var aircraftSettingsButton = AircraftSettingsButton()
    @StateObject var aircraftEngineThrottle = AircraftEngineThrottle()
    @StateObject var aircraftRotationButton = AircraftRotationButtons()


    var body: some View {

        ZStack {

            Color.black.edgesIgnoringSafeArea(.all)

            AircraftSceneView()

            AircraftHeaderView()

            VStack {
                
                Spacer()

                AircraftButtonsView()

            }

        }
        .statusBar(hidden: true)


        .environmentObject(aircraft)
        .environmentObject(aircraftDelegate)
        .environmentObject(aircraftSunlightButton)
        .environmentObject(aircraftCameraButton)
        .environmentObject(aircraftSettingsButton)
        .environmentObject(aircraftEngineThrottle)
        .environmentObject(aircraftRotationButton)
    }

}



/*
 struct ContentView_Previews: PreviewProvider {
 static var previews: some View {
 ContentView()
 }
 }
 */
