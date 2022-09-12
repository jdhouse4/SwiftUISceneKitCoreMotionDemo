//
//  AircraftSettingsButton.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 7/12/21.
//

import SwiftUI




class AircraftSettingsButton: ObservableObject {
    @Published var settingsSwitch: Bool         = false
    
    @Published var showSettingsButtons: Bool    = false
    
    @Published var gyroButtonPressed: Bool      = false
    @Published var touchesButtonPressed: Bool   = false
    @Published var sunlightButtonPressed: Bool  = false
}
