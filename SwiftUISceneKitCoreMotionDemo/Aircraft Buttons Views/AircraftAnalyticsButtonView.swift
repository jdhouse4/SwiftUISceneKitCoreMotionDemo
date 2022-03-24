//
//  AircraftAnalyticsButtonView.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 3/23/22.
//

import SwiftUI




struct AircraftAnalyticsButtonView: View {
    @EnvironmentObject var aircraftAnalyticsButton: AircraftAnalyticsButton
    @EnvironmentObject var aircraftDelegate: AircraftSceneRendererDelegate


    var body: some View {
        //
        // Button to show statistics.
        //
        Button( action: {
            withAnimation {
                self.aircraftAnalyticsButton.analyticsSwitch.toggle()
            }

            aircraftDelegate.showsStatistics.toggle()

        }) {
            Image(systemName: aircraftAnalyticsButton.analyticsSwitch ? "chart.bar.fill" : "chart.bar")
                .imageScale(.large)
                .accessibility(label: Text("Analytics"))
        }
        .frame(width: CircleButtonSize.diameter.rawValue, height: CircleButtonSize.diameter.rawValue)
        .background(aircraftAnalyticsButton.analyticsSwitch ? CircleButtonColor.onWithBackground.rawValue : CircleButtonColor.offWithBackground.rawValue)
        .clipShape(Circle())
        .background(Capsule().stroke(Color.blue, lineWidth: 1))
        .padding()
    }
}




struct AircraftAnalyticsButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AircraftAnalyticsButtonView()
    }
}
