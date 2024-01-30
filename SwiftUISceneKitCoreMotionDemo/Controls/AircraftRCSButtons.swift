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
}



enum AircraftRCSTiming: Int {
    case aircraftRCSMinDuration             = 150 // milliseconds
    case aircraftRCSMaxDuration             = 300 // milliseconds
    case aircraftRCSSingleImpulseBirthrateForNearCamera     = 10000
    case aircraftRCSDoubleImpulseBirthrateForNearCamera     = 20000
    case aircraftRCSSingleImpulseBirthrateForDistantCamera  = 1000
    case aircraftRCSDoubleImpulseBirthrateForDistantCamera  = 2000
}
