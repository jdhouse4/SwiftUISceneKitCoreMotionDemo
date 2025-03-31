//
//  BottomButtonsView.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 3/31/25.
//

import SwiftUI




struct BottomButtonsView: View {
    
    @EnvironmentObject var aircraftAnalyticsButton: AircraftAnalyticsButton
    
    
    var body: some View {
        
        HStack (spacing: 5) {
            
            Group {
                
                //
                // TODO: Delete or comment-out before shipping.
                //
                AircraftAnalyticsButtonView()
                
            }
            
        }
        .padding(.bottom, aircraftAnalyticsButton.analyticsSwitch ? 140 : 5)
        //.background(Color.red.opacity(0.5))
    }
    
}

