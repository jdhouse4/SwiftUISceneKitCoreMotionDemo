//
//  AircraftEngineThrottle.swift
//  AircraftEngineThrottle
//
//  Created by James Hillhouse IV on 8/10/21.
//

import SwiftUI




class AircraftEngineThrottle: ObservableObject {

    @Published var aircraftEngineOn: Bool           = true
    @Published var aircraftEngineMaxThrust: Double  = 1500
    @Published var aircraftEngineThrust: Double     = 1000
    @Published var aircraftThrottleSetting: String  = ""


    

}
