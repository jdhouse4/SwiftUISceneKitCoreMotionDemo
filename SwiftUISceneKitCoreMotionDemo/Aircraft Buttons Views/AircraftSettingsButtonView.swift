//
//  AircraftSettingsButtonView.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 7/12/21.
//

import SwiftUI




struct AircraftSettingsButtonView: View {
    @EnvironmentObject var aircraftSettingsButton: AircraftSettingsButton
    @EnvironmentObject var aircraftDelegate: AircraftSceneRendererDelegate


    var body: some View {
        //
        // Button to show statistics.
        //
        Button( action: {
            withAnimation {
                self.aircraftSettingsButton.settingsSwitch.toggle()
            }

            aircraftDelegate.showsStatistics.toggle()

        }) {
            Image(systemName: aircraftSettingsButton.settingsSwitch ? "gearshape.fill" : "gearshape")
                .imageScale(.large)
                .accessibility(label: Text("Settings"))
        }
        .frame(width: CircleButtonSize.diameter.rawValue, height: CircleButtonSize.diameter.rawValue)
        .background(aircraftSettingsButton.settingsSwitch ? CircleButtonColor.onWithBackground.rawValue : CircleButtonColor.offWithBackground.rawValue)
        .clipShape(Circle())
        .background(Capsule().stroke(Color.blue, lineWidth: 1))
        //.animation(.easeInOut(duration: Double( CircleButtonSize.animationFast.rawValue) ).delay(0.0), value: aircraftSettingsButton.settingsSwitch)
        //.animation(.ripple(buttonIndex: 2), value: aircraftSettingsButton.settingsSwitch)
        .padding()
    }
}





struct AircraftSettingsButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AircraftSettingsButtonView().environmentObject(AircraftSettingsButton())
    }
}
