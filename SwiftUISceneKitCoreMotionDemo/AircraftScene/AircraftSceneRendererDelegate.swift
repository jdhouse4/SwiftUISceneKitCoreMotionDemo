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

    @Published var aircraftCamera: String       = AircraftCamera.distantCamera.rawValue
    @Published var aircraftCameraNode: SCNNode  = SCNNode()
    @Published var aircraftEngineNode: SCNNode  = SCNNode()

    //var aircraftScene: SCNScene?
    var changeCamera: Bool                  = false
    var cameraIndex: Int                    = 0

    var engineThrottle: Double?

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

    

        /*
        if cameraIndex == 0 {
            if aircraftCameraNode != nil {
                self.updateExteriorVehicleCameraOrientation(of: aircraftCameraNode!)
            }
        }
        if cameraIndex == 1 {
            if aircraftCameraNode != nil {
                self.updateInteriorVehicleCameraOrientation(of: aircraftCameraNode!)
            }
        }
        */

        if aircraftCamera == AircraftCamera.distantCamera.rawValue {
            self.updateExteriorVehicleCameraOrientation(of: aircraftCameraNode)
        }

        if aircraftCamera == AircraftCamera.shipCamera.rawValue {
            self.updateInteriorVehicleCameraOrientation(of: aircraftCameraNode)
        }
    }



    func setCameraName(name: String) {
        aircraftCamera = name
    }



    func setCameraNode(node: SCNNode) {
        aircraftCameraNode = node
        motionManager.resetReferenceFrame()
    }


    /*
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
                aircraftCamera      = AircraftCamera.distantCamera.rawValue
                print("Switching to \(AircraftCamera.distantCamera)")
            } else if cameraIndex == 1 {
                aircraftCamera = AircraftCamera.shipCamera.rawValue
                print("Switching to \(AircraftCamera.shipCamera)")
            }
        }
    }
     */


    
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
}
