//
//  AircraftSettingsButtonView.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 7/12/21.
//

import SwiftUI




struct AircraftSettingsButtonView: View {
    @EnvironmentObject var aircraftSettingsSwitch: AircraftSettingsButton
    @EnvironmentObject var aircraftDelegate: AircraftSceneRendererDelegate


    var body: some View {
        //
        // Button to show statistics.
        //
        Button( action: {
            withAnimation {
                self.aircraftSettingsSwitch.settingsSwitch.toggle()
            }

            aircraftDelegate.showsStatistics.toggle()

        }) {
            Image(systemName: aircraftSettingsSwitch.settingsSwitch ? "gearshape.fill" : "gearshape")
                .imageScale(.large)
                .accessibility(label: Text("Settings"))
        }
        .frame(width: CircleButton.diameter.rawValue, height: CircleButton.diameter.rawValue)
        .background(aircraftSettingsSwitch.settingsSwitch ? CircleButtonColor.on.rawValue : CircleButtonColor.off.rawValue)
        .clipShape(Circle())
        .background(Capsule().stroke(Color.blue, lineWidth: 1))
        .animation(.ripple(buttonIndex: 2))
        .padding()
    }
}





struct AircraftSettingsButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AircraftSettingsButtonView().environmentObject(AircraftSettingsButton())
    }
}
