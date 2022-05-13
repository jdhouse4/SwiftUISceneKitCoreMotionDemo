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
    
    static let shared = AircraftState()
    
    
    /// This is a place where the position, velocity, orientation, delta-orientation, and translation data is stored and managed.
    let deltaOrientationAngle: Float    = 0.0078125 * .pi / 180.0 // This results in a 0.5°/s attitude change. 0.015625 = 1°/s
    
    ///
    /// The scene for the aircraft scn
    @Published var aircraftScene: SCNScene         = AircraftSceneKitScene.shared

    ///
    /// The scene node for the aircraft itself
    @Published var aircraftNode: SCNNode
    
    
    /// Aircraft Position
    ///
    /// Aircraft Velocity
    ///
    /// Aircraft Orientation
    @Published var aircraftOrientation: simd_quatf  // Do this as a computed property
    
    @Published var aircraftDeltaQuaternion: simd_quatf
    
    @Published var aircraftEulerAngles: SIMD3<Float>
    
    var aircraftRollAngle: Float = 0.0
    
    private init() {
        print("AircraftState \(#function)")
        self.aircraftOrientation        = simd_quatf(ix: 0.0, iy: 0.0, iz: 0.0, r: 1.0)
        
        self.aircraftDeltaQuaternion    = simd_quatf(ix: 0.0, iy: 0.0, iz: 0.0, r: 1.0)
        
        self.aircraftNode               = AircraftSceneKitScene.shared.aircraftNode
        
        self.aircraftEulerAngles        = simd_float3(x: 0.0, y: 0.0, z: 0.0)
    }
    
    
    
    func degrees2Radians(_ number: Float) -> Float {
        return number * .pi / 180.0
    }
    
    
    
    func radians2Degrees(_ number: Float) -> Float {
        return number * 180.0 / .pi
    }

    
    
    func singleImpulseRollStarboard() -> simd_quatf {
        print("AircraftState singleImpulseStarboard()")
        let rollStarboardQuaternion: simd_quatf = simd_quatf(angle: deltaOrientationAngle,
                                                             axis: simd_float3(x: 0.0, y: 0.0, z: 1.0)).normalized
        
        aircraftDeltaQuaternion = simd_mul(aircraftDeltaQuaternion, rollStarboardQuaternion)
        //print("\(#function): aircraftDeltaQuaternion: \(aircraftDeltaQuaternion.debugDescription)")
        
        return aircraftDeltaQuaternion
    }
    
    
    
    func doubleImpulseRollStarboard() -> simd_quatf {
        print("AircraftState singleImpulseStarboard()")
        let rollStarboardQuaternion: simd_quatf = simd_quatf(angle: deltaOrientationAngle * 2.0,
                                                             axis: simd_float3(x: 0.0, y: 0.0, z: 1.0)).normalized
        
        aircraftDeltaQuaternion = simd_mul(aircraftDeltaQuaternion, rollStarboardQuaternion)
        //print("\(#function): aircraftDeltaQuaternion: \(aircraftDeltaQuaternion.debugDescription)")
        
        return aircraftDeltaQuaternion
    }
    
    
    
    func singleImpulseRollPort() -> simd_quatf {
        print("AircraftState singleImpulsePort()")
        let rollPortQuaternion: simd_quatf = simd_quatf(angle: deltaOrientationAngle,
                                                        axis: simd_float3(x: 0.0, y: 0.0, z: -1.0)).normalized
        
        aircraftDeltaQuaternion = simd_mul(aircraftDeltaQuaternion, rollPortQuaternion)
        //print("\(#function): aircraftDeltaQuaternion: \(aircraftDeltaQuaternion.debugDescription)")
        
        return aircraftDeltaQuaternion
    }

    
    
    func doubleImpulseRollPort() -> simd_quatf {
        print("AircraftState singleImpulsePort()")
        let rollPortQuaternion: simd_quatf = simd_quatf(angle: deltaOrientationAngle * 2.0,
                                                        axis: simd_float3(x: 0.0, y: 0.0, z: -1.0)).normalized
        
        aircraftDeltaQuaternion = simd_mul(aircraftDeltaQuaternion, rollPortQuaternion)
        //print("\(#function): aircraftDeltaQuaternion: \(aircraftDeltaQuaternion.debugDescription)")
        
        return aircraftDeltaQuaternion
    }

    
    
   func aircraftEulerAngles(from quaternion: simd_quatf) {
        print("AircraftState \(#function)")
        
        ///
        /// Thanks go to Thilo (https://stackoverflow.com/users/11655730/thilo) for this simple way of obtaining Euler angles
        /// of a node.
        ///
        /// for his post on Stack Overflow, (https://stackoverflow.com/a/71344720/1518544)
        ///
        let node = SCNNode()
        node.simdOrientation    = quaternion
        self.aircraftEulerAngles = node.simdEulerAngles
        
        //aircraftNode.simdOrientation = quaternion
        
        //return aircraftNode.simdEulerAngles
    }
    
    
    
    func resetOrientation() -> simd_quatf {
        return simd_quatf(angle: 0, axis: simd_float3(x: 0.0, y: 0.0, z: 0.0))
    }
}
