//
//  TopRowButtonsView.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 4/4/22.
//

import SwiftUI

struct TopRowButtonsView: View {
    var body: some View {
        HStack (alignment: .center) {
            
            AircraftCameraButtonsView()
            
            Spacer()
            
            AircraftSettingsButtonView()
        }
    }
}




struct TopRowButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        TopRowButtonsView()
    }
}
