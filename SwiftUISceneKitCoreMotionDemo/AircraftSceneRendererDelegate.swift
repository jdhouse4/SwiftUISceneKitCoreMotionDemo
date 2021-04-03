//
//  AircraftSceneRendererDelegate.swift
//  SceneKitSwiftUIGesturesDemoApp
//
//  Created by James Hillhouse IV on 10/17/20.
//

import SceneKit




class AircraftSceneRendererDelegate: NSObject, SCNSceneRendererDelegate, ObservableObject {

    var aircraftScene: SCNScene?
    var aircraftCamera                      = AircraftCamera.distantCamera.rawValue
    var aircraftCameraNode: SCNNode?

    var changeCamera: Bool                  = false
    var cameraIndex: Int                    = 0

    var showsStatistics: Bool               = false

    var motionManager: MotionManager        = MotionManager()
    var sceneQuaternion: simd_quatf?

    var _previousUpdateTime: TimeInterval   = 0.0
    var _deltaTime: TimeInterval            = 0.0

    var gyroReset: Bool                     = false


    override init() {
        print("AircraftSceneRendererDelegate override initialized")
        self.motionManager.setupDeviceMotion()
        self.sceneQuaternion    = self.motionManager.motionQuaternion


        super.init()
    }



    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval)
    {
        renderer.showsStatistics = showsStatistics

        // Probably don't wont to hit this function at 60 Hz...
        //cycleCameras()


        // The main input pump for the simulator.

        if _previousUpdateTime == 0.0
        {
            _previousUpdateTime     = time
        }

        //print("\(time)")


        _deltaTime                  = time - _previousUpdateTime
        _previousUpdateTime         = time


        //
        // MARK: Update the attitude.quaternion from device manager
        //
        motionManager.updateAttitude()
        sceneQuaternion = motionManager.motionQuaternion
        //print("quaternion: \(String(describing: sceneQuaternion))")


        if cameraIndex == 0 {
            if aircraftCameraNode != nil {
                self.updateVehicleOrientation(of: aircraftCameraNode!)
            }
        }
        if cameraIndex == 1 {
            if aircraftCameraNode != nil {
                self.updateCameraOrientation(of: aircraftCameraNode!)
            }
        }
    }



    func cycleCameras() -> Void {
        if changeCamera == true {
            print("\n\nAircraftSceneRendererDelegate Changing cameras")

            changeCamera.toggle()

            cameraIndex += 1
            if cameraIndex > 1 {
                cameraIndex = 0
            }
            print("AircraftScenekitScene camera index = \(cameraIndex)")

            motionManager.resetReferenceFrame()

            if cameraIndex == 0 {
                aircraftCamera = AircraftCamera.distantCamera.rawValue
                print("Switching to \(AircraftCamera.distantCamera.rawValue)")
            } else if cameraIndex == 1 {
                aircraftCamera = AircraftCamera.shipCamera.rawValue
                print("Switching to \(AircraftCamera.shipCamera.rawValue)")
            }

            #warning("Set aircraftCameraNode here?")
        }
    }


    func updateOrientation(of node: SCNNode) -> Void {
        // Change Orientation with Device Motion
        //let deviceAttitudeSCNQ  = sceneQuaternion as SCNQuaternion

        #warning("Figure out why one cannot cast using sceneQuaternion as SCNQuaternion.")
        node.simdOrientation    = simd_quatf(ix: Float(motionManager.deviceMotion!.attitude.quaternion.x),
                                             iy: Float(motionManager.deviceMotion!.attitude.quaternion.y),
                                             iz: Float(motionManager.deviceMotion!.attitude.quaternion.z),
                                             r:  Float(motionManager.deviceMotion!.attitude.quaternion.w)).normalized
    }



    func updateVehicleOrientation(of node: SCNNode) -> Void {
        // Change Orientation with Device Motion
        //let deviceAttitudeSCNQ  = sceneQuaternion as SCNQuaternion

        #warning("Figure out why one cannot cast using sceneQuaternion as SCNQuaternion.")
        node.simdOrientation    = simd_quatf(ix: Float(motionManager.deviceMotion!.attitude.quaternion.x),
                                             iy: Float(motionManager.deviceMotion!.attitude.quaternion.y),
                                             iz: Float(motionManager.deviceMotion!.attitude.quaternion.z),
                                             r:  Float(motionManager.deviceMotion!.attitude.quaternion.w)).normalized
    }



    func updateCameraOrientation(of node: SCNNode) -> Void {
        // Change Orientation with Device Motion

        #warning("Figure out why one cannot cast using sceneQuaternion as SCNQuaternion.")
        //let deviceAttitudeSCNQ  = sceneQuaternion as SCNQuaternion

        node.simdOrientation    = simd_quatf(angle: -.pi,
                                             axis: simd_normalize(simd_float3(x: 0, y: 1, z: 0))).normalized


        let motionSimdQuatf     = simd_quatf(ix: Float(motionManager.deviceMotion!.attitude.quaternion.x),
                                             iy: Float(motionManager.deviceMotion!.attitude.quaternion.y),
                                             iz: Float(motionManager.deviceMotion!.attitude.quaternion.z),
                                             r:  Float(motionManager.deviceMotion!.attitude.quaternion.w)).normalized

        node.simdOrientation   = simd_mul(node.simdOrientation, motionSimdQuatf).normalized
    }

}
