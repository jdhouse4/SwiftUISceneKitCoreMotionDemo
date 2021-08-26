//
//  AircraftButtonsView.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 7/13/21.
//

import SwiftUI




struct AircraftButtonsView: View {
    @EnvironmentObject var sunlightSwitch: AircraftSunlightButton
    @EnvironmentObject var aircraft: AircraftSceneKitScene
    @EnvironmentObject var aircraftCameraButton: AircraftCameraButton
    @EnvironmentObject var aircraftSettingsButton: AircraftSettingsButton



    var body: some View {

        VStack {

            Spacer(minLength: 200)

            GeometryReader { geo in

                HStack {

                    AircraftEngineThrottleSlider()

                }
                .frame(width: geo.size.width, height: aircraftSettingsButton.settingsSwitch ? geo.size.height - 140 : geo.size.height, alignment: .trailing)
                .padding(.bottom, 150)

            }

            //Spacer(minLength: 50)

            HStack (spacing: 5) {

                AircraftSunlightButtonView()

                AircraftCameraButtons()

                AircraftSettingsButtonView()

            }.padding(.bottom, aircraftSettingsButton.settingsSwitch ? 140 : 5)

        }

    }
}




struct AircraftButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        AircraftButtonsView()
    }
}