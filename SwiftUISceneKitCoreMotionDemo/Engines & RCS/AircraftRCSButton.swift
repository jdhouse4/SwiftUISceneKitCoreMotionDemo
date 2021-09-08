//
//  AircraftRCSButton.swift
//  AircraftRCSButton
//
//  Created by James Hillhouse IV on 8/15/21.
//

import SwiftUI



class AircraftRCSButton: ObservableObject {

    @Published var aircraftRCSButton: Bool      = true
    @Published var aircraftRCSOn: Bool          = true
    @Published var aircraftRCSThrust: Double    = 100
    @Published var aircraftRCSSetting: String   = ""

}
