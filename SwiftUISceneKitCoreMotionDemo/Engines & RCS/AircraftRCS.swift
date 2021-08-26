//
//  AircraftRCS.swift
//  AircraftRCS
//
//  Created by James Hillhouse IV on 8/15/21.
//

import SwiftUI



class AircraftRCS: ObservableObject {

    @Published var aircraftRCSOn: Bool          = true
    @Published var aircraftRCSThrust: Double    = 250
    @Published var aircraftRCSSetting: String   = ""

}
