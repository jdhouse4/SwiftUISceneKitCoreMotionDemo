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
        .frame(width: CircleButton.diameter.rawValue, height: CircleButton.diameter.rawValue)
        .background(aircraftSettingsButton.settingsSwitch ? CircleButtonColor.on.rawValue : CircleButtonColor.off.rawValue)
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



extension AnyTransition {
    static var leftButtonsMoveAndFadeTransition: AnyTransition {
        let insertion   = AnyTransition.move(edge: .leading)
            .combined(with: .opacity)

        let removal     = AnyTransition.offset(x: -200, y: 0)
            .combined(with: .opacity)

        return asymmetric(insertion: insertion, removal: removal)
    }
}
