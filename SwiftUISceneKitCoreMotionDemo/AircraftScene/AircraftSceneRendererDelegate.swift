//
//  AircraftSceneRendererDelegate.swift
//  SceneKitSwiftUIGesturesDemoApp
//
//  Created by James Hillhouse IV on 10/17/20.
//
import SceneKit




/**
 This is the delegate class for AircraftSceneKitScene model.
 
 It's purpose is to do some of the grunt work for an SCNScene. One important role is the function,
 
 `renderer(_:updateAtTime:)`
 
 that allows for changes of the Scene to be rendereed on a reglar time interval. For our purposes, this will allow for the physics-based motion
 say due to firing of the aircraft's RCS, to be displayed. Another would be to update the position after Runge-Kutta45 integration the state vector.
 */
class AircraftSceneRendererDelegate: NSObject, SCNSceneRendererDelegate, ObservableObject {
    
    var aircraftScene: SCNScene                     = AircraftSceneKitScene.shared
    var aircraftState                               = AircraftState.shared
    
    @Published var aircraftNode: SCNNode            = SCNNode()
    @Published var aircraftNodeString: String       = "shipNode"
    //@Published var otherNode: SCNNode
    
    @Published var aircraftDeltaQuaternion: simd_quatf  = simd_quatf()
    @Published var aircraftOrientation: simd_quatf      = simd_quatf()
    @Published var aircraftEulerAngles: SIMD3<Float>    = simd_float3()

    @Published var aircraftCamera: String           = AircraftCamera.distantCamera.rawValue
    @Published var aircraftCameraNode: SCNNode      = SCNNode()
    @Published var aircraftEngineNode: SCNNode      = SCNNode()
    
    /// Prepare to DELETE
    @Published var nearPoint: SCNVector3            = SCNVector3()
    @Published var farPoint: SCNVector3             = SCNVector3()

    var changeCamera: Bool                          = false

    var engineThrottle: Double?

    var showsStatistics: Bool                       = false

    var motionManager: MotionManager                = MotionManager()
    var sceneQuaternion: simd_quatf?

    var _previousUpdateTime: TimeInterval           = 0.0
    var _deltaTime: TimeInterval                    = 0.0

    var gyroReset: Bool                             = false


    override init() {
        print("AircraftSceneRendererDelegate override initialized")
        self.motionManager.setupDeviceMotion()
        self.sceneQuaternion    = self.motionManager.motionQuaternion
        
        //self.aircraftScene      = AircraftSceneKitScene.shared

        self.aircraftNode       = AircraftSceneKitScene.shared.aircraftNode

        super.init()
        
        print("AircraftSceneRendererDelegate \(#function) aircraftScene: \(aircraftScene)")
        print("AircraftSceneRendererDelegate \(#function) aircraftNode: \(aircraftNode.name)")
}



    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval)
    {
        renderer.showsStatistics = showsStatistics


        // This is to ensure that the time is initialized properly for the simulator.
        if _previousUpdateTime == 0.0
        {
            _previousUpdateTime     = time
                        
        }

        //print("\(time)")


        _deltaTime                  = time - _previousUpdateTime
        _previousUpdateTime         = time


        ///
        // MARK: Update the attitude.quaternion from device manager
        ///
        motionManager.updateAttitude()
        
        
        
        // MARK: Update the orientation due to RCS activity
        self.updateOrientation()
        
        
    
        if aircraftCamera == AircraftCamera.distantCamera.rawValue {
            
            if UserDefaults.standard.bool(forKey: AircraftUserSettings.pfGyroOrientationControl.rawValue) {
                self.updateExteriorVehicleCameraOrientation(of: aircraftCameraNode)
            }
        }

        if aircraftCamera == AircraftCamera.shipCamera.rawValue {
            if UserDefaults.standard.bool(forKey: AircraftUserSettings.pfGyroOrientationControl.rawValue) {
                self.updateInteriorVehicleCameraOrientation(of: aircraftCameraNode)
            }
        }
    }



    func setCameraName(name: String) {
        aircraftCamera = name
    }



    func setCameraNode(node: SCNNode) {
        aircraftCameraNode = node
        motionManager.resetReferenceFrame()
    }
    
    
    
    func setAircraftNode(node: SCNNode) {
        aircraftNode = node
    }



    func updateExteriorVehicleCameraOrientation(of node: SCNNode) -> Void {

        // Change Orientation with Device Motion
        node.simdOrientation    = simd_quatf(ix: Float(motionManager.deviceMotion!.attitude.quaternion.x),
                                             iy: Float(motionManager.deviceMotion!.attitude.quaternion.y),
                                             iz: Float(motionManager.deviceMotion!.attitude.quaternion.z),
                                             r:  Float(motionManager.deviceMotion!.attitude.quaternion.w)).normalized
    }



    func updateInteriorVehicleCameraOrientation(of node: SCNNode) -> Void {

        // Change Orientation with Device Motion
        node.simdOrientation    = simd_quatf(angle: -.pi,
                                             axis: simd_normalize(simd_float3(x: 0, y: 1, z: 0))).normalized

        let motionSimdQuatf     = simd_quatf(ix: Float(motionManager.deviceMotion!.attitude.quaternion.x),
                                             iy: Float(motionManager.deviceMotion!.attitude.quaternion.y),
                                             iz: Float(motionManager.deviceMotion!.attitude.quaternion.z),
                                             r:  Float(motionManager.deviceMotion!.attitude.quaternion.w)).normalized

        node.simdOrientation   = simd_mul(node.simdOrientation, motionSimdQuatf).normalized
    }
    
    
    
    func updateOrientation() -> Void {
        self.aircraftNode.simdOrientation   = simd_mul(aircraftNode.simdOrientation, aircraftDeltaQuaternion).normalized
        
        
        ///
        /// Thank you [Rob Napier](https://stackoverflow.com/users/97337/rob-napier) for answering the
        /// StackOverflow thread on,
        /// [SwiftUI - make sure to publish values from the main thread (via operators like receive(on:)) on model updates](https://stackoverflow.com/a/64404137/1518544)
        ///
        /// This really blows-up the memory footprint.
        
        
        /*
        DispatchQueue.main.async {
            
            ///
            /// Thanks go to Thilo (https://stackoverflow.com/users/11655730/thilo) for this simple way of obtaining Euler angles
            /// of a node.
            ///
            /// for his post on Stack Overflow, (https://stackoverflow.com/a/71344720/1518544)
            ///
            
            /// Beginning to wonder if AircraftState shouldn't be renamed AircraftControl or ...Controller and be used to generate the impulses for the RCS systems.
            //self.aircraftState.aircraftEulerAngles = self.aircraftNode.simdEulerAngles
            self.aircraftEulerAngles = self.aircraftNode.simdEulerAngles
        
        }
        */
        
        Task {
            await MainActor.run {
                self.aircraftEulerAngles = self.aircraftNode.simdEulerAngles
            }
        }
        
        /*
        async {
            await MainActor.run {
                self.aircraftEulerAngles = self.aircraftNode.simdEulerAngles
            }
        }
         */
        /*
        //self.aircraftEulerAngles        = aircraftNode.simdEulerAngles
        let eulerAngles: simd_float3    = aircraftNode.simdEulerAngles
        
        print("""
              \nAircraft Euler Angles:
                pitch: \(self.radians2Degrees(eulerAngles.x)),
                yaw: \(self.radians2Degrees(eulerAngles.y)),
                roll: \(self.radians2Degrees(eulerAngles.z))
        """)
        */
    }
    
    
    
    func radians2Degrees(_ number: Float) -> Float {
        return number * 180.0 / .pi
    }

}
