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

                Spacer(minLength: 375)

                AircraftRotationButtonsView()

                Spacer(minLength: 30)

            }
            //.padding(.leading, 50)
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

                AircraftCameraButtons()

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
