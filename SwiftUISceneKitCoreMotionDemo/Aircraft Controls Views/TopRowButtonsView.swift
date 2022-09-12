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
        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
        //.background(Color.brown.opacity(0.95))
    }
}




struct TopRowButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        TopRowButtonsView()
    }
}
