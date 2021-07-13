//
//  AircraftButtonsView.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 7/13/21.
//

import SwiftUI




struct AircraftButtonsView: View {
    @EnvironmentObject var sunlightSwitch: AircraftSunlightButton
    @EnvironmentObject var aircraftCameraButton: AircraftCameraButton
    @EnvironmentObject var aircraftSettingsButton: AircraftSettingsButton



    var body: some View {
        HStack (spacing: 5) {

            AircraftSunlightButtonView()


            AircraftCameraButtons()


            AircraftSettingsButtonView()

        }.padding(.bottom, aircraftSettingsButton.settingsSwitch ? 140 : 5)

    }
}




struct AircraftButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        AircraftButtonsView()
    }
}
