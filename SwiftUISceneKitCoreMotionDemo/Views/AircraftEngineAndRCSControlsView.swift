//
//  AircraftEngineAndRCSControlsView.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 7/13/21.
//

import SwiftUI




struct AircraftEngineAndRCSControlsView: View {

    @Environment(\.horizontalSizeClass) var sizeClass
    
    @EnvironmentObject var aircraftAnalyticsButton: AircraftAnalyticsButton

    

    var body: some View {

        ZStack {

            HStack {
                                
                AircraftRCSButtonsView()
                    //.background(Color.yellow.opacity(0.7))
                
                    
                    Spacer()
                    
                AircraftEngineThrottleSlider()
                    //.background(Color.blue.opacity(0.7))
                
            }
            .frame(alignment: .center)
            .padding(EdgeInsets(top: 0, leading: 5, bottom: aircraftAnalyticsButton.analyticsSwitch ? 140 : 5, trailing: 0))
            //.background(Color.gray.opacity(0.7))
        }
    }
}




struct AircraftButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        AircraftEngineAndRCSControlsView()
    }
}
