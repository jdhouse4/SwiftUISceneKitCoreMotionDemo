//
//  AircraftSceneKitScene.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 10/18/20.
//

import Foundation
import SceneKit




class AircraftSceneKitScene: SCNScene, SCNSceneRendererDelegate, ObservableObject {

    var aircraftScene   = SCNScene(named: "art.scnassets/ship.scn")!
    var aircraftNode    = SCNNode()
    var aircraftCamera  = "distantCamera"

    var changeCamera: Bool                  = false
    var cameraIndex: Int                    = 0

    var showsStatistics: Bool               = true

    var motionManager: MotionManager        = MotionManager()
    var sceneQuaternion: simd_quatf?

    var _previousUpdateTime: TimeInterval   = 0.0
    var _deltaTime: TimeInterval            = 0.0

    var gyroReset: Bool                     = false



    override init() {
        print("AircraftScenekitScene override initialized")
        self.aircraftNode       = aircraftScene.rootNode.childNode(withName: "shipNode", recursively: true)!
        //self.motionManager      = MotionManager()
        self.motionManager.setupDeviceMotion()
        self.sceneQuaternion    = self.motionManager.motionQuaternion
        //self.changeCamera       = false

        //self.aircraftNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: .pi, y: 0.0, z: 0.0, duration: 2.0)))

        super.init()
    }



    required init?(coder: NSCoder) {
        print("AircraftScenekitScene initialized")
        self.aircraftNode       = aircraftScene.rootNode.childNode(withName: "shipNode", recursively: true)!
        //self.motionManager      = MotionManager()
        self.motionManager.setupDeviceMotion()
        self.sceneQuaternion    = self.motionManager.motionQuaternion
        //self.changeCamera       = false

        //self.aircraftNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: .pi, y: 0.0, z: 0.0, duration: 2.0)))

        super.init(coder: coder)
    }


    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval)
    {
        //print("AircraftSceneRendererDelegate.renderer(_, time)")

        //renderer.showsStatistics = showsStatistics

        cycleCameras()

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
        //prprint("quaternion: \(String(describing: sceneQuaternion))")


    }



    func cycleCameras() -> Void {
        if changeCamera == true {
            print("\n\nAircraftSceneKitScene Changing cameras")

            changeCamera.toggle()

            cameraIndex += 1
            if cameraIndex > 1 {
                cameraIndex = 0
            }
            print("AircraftScenekitScene camera index = \(cameraIndex)")

            motionManager.resetReferenceFrame()

            if cameraIndex == 0 {
                aircraftCamera = "distantCamera"
                print("Switching to distantCamera")
            } else if cameraIndex == 1 {
                aircraftCamera = "shipCamera"
                print("Switching to shipCamera")
            }

            /*
            if aircraftCamera == "shipCamera" {
                print("Switching to shipCamera")
                //motionManager.startDeviceMotion()
                // Make a function call to CommanderCamera function
            }

            if aircraftCamera == "distantCamera" {
                print("Switching to distantCamera")
                //motionManager.stopMotion()
                // Make a function call to Orion360Camera
            }
             */
        }
    }

}
