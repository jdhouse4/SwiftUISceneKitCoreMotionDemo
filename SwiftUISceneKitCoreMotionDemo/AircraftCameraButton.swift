//
//  AircraftCameraButton.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 5/25/21.
//

import SwiftUI




class AircraftCameraButton: ObservableObject {
    // Top Left Buttons
    @Published var cameraButton: Bool               = false
    @Published var showCameraButtons: Bool          = false
    @Published var shipCameraButtonPressed: Bool    = false
    @Published var distantCameraButtonPressed: Bool = false

    // Top Right Buttons
    //@Published var showSettingsButtons: Bool            = false
    //@Published var settingsButtonPressed: Bool          = false
}




extension Animation {
    static func ripple(buttonIndex: Int) -> Animation {
        Animation.spring(dampingFraction: 0.5)
            .speed(1.2)
            .delay(0.05 * Double(buttonIndex))

    }
}





