//
//  BottomRowButtonsView.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 4/4/22.
//

import SwiftUI




struct BottomRowButtonsView: View {
    @EnvironmentObject var aircraftAnalyticsButton: AircraftAnalyticsButton

    
    var body: some View {
        HStack (spacing: 5) {
            
            Group {
                
                AircraftSunlightButtonView()
                
                Spacer()
                
                AircraftAnalyticsButtonView()
                
            }
        }
        .padding(.bottom, aircraftAnalyticsButton.analyticsSwitch ? 140 : 5)
        //.background(Color.red.opacity(0.95))
    }
}




struct BottomRowButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        BottomRowButtonsView()
    }
}
