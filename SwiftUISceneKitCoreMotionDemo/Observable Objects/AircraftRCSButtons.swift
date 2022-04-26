//
//  AircraftRCSButtons.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 6/6/21.
//

import SwiftUI



class AircraftRCSButtons: ObservableObject {
    @Published var showRotationButtons: Bool            = false
    
    @Published var pitchUpButtonPressed: Bool           = false
    @Published var pitchDownButtonPressed: Bool         = false
    @Published var rollPortButtonPressed: Bool          = false
    @Published var rollStarboardButtonPressed: Bool     = false
    @Published var yawPortButtonPressed: Bool           = false
    @Published var yawStarboardButtonPressed: Bool      = false

    /*
    let aircraftRCSDefaultBirthrate: Int                = 500
    let aircraftRCSMinDuration: Int                     = 150 // milliseconds
    let aircraftRCSMaxDuration: Int                     = 300 // milliseconds
     */
}



enum AircraftRCSTiming: Int {
    case aircraftRCSDefaultBirthrate    = 500
    case aircraftRCSMinDuration         = 150 // milliseconds
    case aircraftRCSMaxDuration         = 300 // milliseconds
}

