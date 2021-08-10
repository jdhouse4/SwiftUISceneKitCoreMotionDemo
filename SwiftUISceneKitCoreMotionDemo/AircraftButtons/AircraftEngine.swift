//
//  AircraftEngineThrottle.swift
//  AircraftEngineThrottle
//
//  Created by James Hillhouse IV on 8/10/21.
//

import SwiftUI




class AircraftEngineThrottle: ObservableObject {

    @Published var aircraftEngineOn: Bool       = true
    @Published var aircraftEngineMaxThrust: Int = 1500
    @Published var aircraftEngineThrust: Int    = 1000

}
