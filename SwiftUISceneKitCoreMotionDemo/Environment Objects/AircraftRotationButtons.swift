//
//  AircraftRotationButtons.swift
//  FourCornersUIWithSwiftUI
//
//  Created by James Hillhouse IV on 6/6/21.
//

import SwiftUI



class AircraftRotationButtons: ObservableObject {
    @Published var showRotationButtons: Bool            = false
    
    @Published var pitchUpButtonPressed: Bool           = false
    @Published var pitchDownButtonPressed: Bool         = false
    @Published var rollPortButtonPressed: Bool          = false
    @Published var rollStarboardButtonPressed: Bool     = false
    @Published var yawPortButtonPressed: Bool           = false
    @Published var yawStarboardButtonPressed: Bool      = false

    @Published var aircraftRCSThrust: Double            = 100
}
