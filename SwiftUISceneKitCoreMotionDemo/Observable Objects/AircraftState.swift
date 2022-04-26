//
//  AircraftState.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 3/14/22.
//

import Foundation
import SceneKit
import simd


class AircraftState: ObservableObject {
    /// This is a place where the position, velocity, orientation, delta-orientation, and translation data is stored and managed.
    var deltaRollPort: Float = 0.0
    var deltaRollStarboard: Float = 0.0
    
    
    /// Aircraft Position
    ///
    /// Aircraft Velocity
    ///
    /// Aircraft Orientation
    @Published var aircraftOrientation: simd_quatf  // Do this as a computed property
    
    @Published var deltaRollEulerAngle: Float
    
    var deltaRotationEulerAngle: Float = 0.025 * .pi / 180.0
    
    @Published var orientationEulerAngles: simd_float3
    
    
    init() {
        self.aircraftOrientation    = simd_quatf().normalized
        
        /// x: pitch, y: yaw, z: roll
        self.orientationEulerAngles      = simd_float3(x: 0.0, y: 0.0, z: 0.0)
        self.deltaRollEulerAngle = 0.0
    }
    
    
    
    func degrees2Radians(_ number: Float) -> Float {
        return number * .pi / 180.0
    }
    
    
    
    func radians2Degrees(_ number: Float) -> Float {
        return number * 180.0 / .pi
    }
    
    
    
    func impulseRollPort() {
        print("AircraftState impulsePort()")
        deltaRollEulerAngle -= deltaRotationEulerAngle

        let totalRollRate = radians2Degrees(deltaRollEulerAngle)
        print("Roll Rate (degrees): \(totalRollRate)")
        
        addOrientationEulerAngleChanges()
    }
    
    
    
    func impulseRollStarboard() {
        print("AircraftState impulseStarboard()")
        deltaRollEulerAngle += deltaRotationEulerAngle
        
        let totalRollRate = radians2Degrees(deltaRollEulerAngle)
        print("Roll Rate (degrees): \(totalRollRate)")

        addOrientationEulerAngleChanges()
    }
    
    
    
    func addOrientationEulerAngleChanges() {
        /// Roll change
        orientationEulerAngles.z += deltaRotationEulerAngle
    }
    
    
    
    func updateAircraftOrientation() {
        /// Handling only roll at this time
        let newRollRateQuatf = simd_quatf(angle: orientationEulerAngles.z, axis: simd_float3(x: 0.0, y: 0.0, z: 1.0)).normalized
        aircraftOrientation = simd_mul(aircraftOrientation, newRollRateQuatf).normalized
    }
    
    
    
    func resetOrientation() -> simd_quatf {
        return simd_quatf(angle: 0, axis: simd_float3())
    }
}
