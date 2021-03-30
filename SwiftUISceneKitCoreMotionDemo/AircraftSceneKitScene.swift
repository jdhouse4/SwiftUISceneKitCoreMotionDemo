//
//  AircraftSceneKitScene.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 10/18/20.
//

import Foundation
import SceneKit




class AircraftSceneKitScene: SCNScene, ObservableObject {

    var aircraftScene   = SCNScene(named: "art.scnassets/ship.scn")!
    var aircraftNode    = SCNNode()
    var aircraftCamera  = "distantCamera"

    var changeCamera: Bool                  = false
    var cameraIndex: Int                    = 0

    //var showsStatistics: Bool               = true

    //var motionManager: MotionManager        = MotionManager()
    //var sceneQuaternion: simd_quatf?

    //var _previousUpdateTime: TimeInterval   = 0.0
    //var _deltaTime: TimeInterval            = 0.0

    //var gyroReset: Bool                     = false



    override init() {
        print("AircraftScenekitScene override initialized")
        self.aircraftNode   = aircraftScene.rootNode.childNode(withName: "shipNode", recursively: true)!

        super.init()
    }



    required init?(coder: NSCoder) {
        print("AircraftScenekitScene initialized")
        self.aircraftNode   = aircraftScene.rootNode.childNode(withName: "shipNode", recursively: true)!

        super.init(coder: coder)
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

            if cameraIndex == 0 {
                aircraftCamera = "distantCamera"
                print("Switching to distantCamera")
            } else if cameraIndex == 1 {
                aircraftCamera = "shipCamera"
                print("Switching to shipCamera")
            }
        }
    }

}
