//
//  AircraftView.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 7/13/21.
//

import SwiftUI




struct AircraftView: View {

    //
    // @StateObject is a property wrapper type that instantiates an observable object.
    //
    @StateObject var aircraft               = AircraftSceneKitScene()
    @StateObject var aircraftDelegate       = AircraftSceneRendererDelegate()
    @StateObject var aircraftSunlightButton = AircraftSunlightButton()
    @StateObject var aircraftCameraButton   = AircraftCameraButton()
    @StateObject var aircraftSettingsButton = AircraftSettingsButton()


    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            AircraftSceneView()

            VStack {
                
                Spacer()

                AircraftButtonsView()

            }


            VStack() {
                Text("Hello, SwiftUI!").multilineTextAlignment(.leading).padding()
                    .foregroundColor(Color.black)
                    .font(.largeTitle)
                    .opacity(0.7)


                Text("And SceneView too")
                    .foregroundColor(Color.black)
                    .font(.title2)
                    .opacity(0.8)

                Spacer(minLength: 300)
            }
        }

        .environmentObject(aircraft)
        .environmentObject(aircraftDelegate)
        .environmentObject(aircraftSunlightButton)
        .environmentObject(aircraftCameraButton)
        .environmentObject(aircraftSettingsButton)

    }
}




struct AircraftView_Previews: PreviewProvider {
    static var previews: some View {
        AircraftView().environmentObject(AircraftSceneKitScene())
    }
}

