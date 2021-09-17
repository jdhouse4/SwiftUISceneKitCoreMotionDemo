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

        ZStack {

            VStack {

                AircraftRCSButtonsView()
                    .padding(.top, aircraftSettingsButton.settingsSwitch ? 210 : 350)
                    .padding(.bottom, aircraftSettingsButton.settingsSwitch ? 240 : 100)

            }
            //.background(Color.orange)


        VStack {

            Spacer(minLength: 200)

            GeometryReader { geometry in

                HStack (spacing: 5) {

                    AircraftEngineThrottleSlider()

                }
                .frame(width: geometry.size.width, height: aircraftSettingsButton.settingsSwitch ? geometry.size.height - 140 : geometry.size.height, alignment: .trailing)
                .padding(.bottom, 150)

            }

            //Spacer(minLength: 50)

            HStack (spacing: 5) {

                AircraftSunlightButtonView()

                AircraftCameraButtonsView()

                AircraftSettingsButtonView()

            }.padding(.bottom, aircraftSettingsButton.settingsSwitch ? 140 : 5)

        }
    }
    }
}




struct AircraftButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        AircraftButtonsView()
    }
}
