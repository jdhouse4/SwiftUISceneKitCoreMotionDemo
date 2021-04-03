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
    var aircraftCamera  = AircraftCamera.distantCamera.rawValue
    

    //var changeCamera: Bool                  = false
    //var cameraIndex: Int                    = 0

    //var showsStatistics: Bool               = true



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

    /*
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
                aircraftCamera = AircraftCamera.distantCamera.rawValue
                print("Switching to \(AircraftCamera.distantCamera.rawValue)")
            } else if cameraIndex == 1 {
                aircraftCamera = AircraftCamera.shipCamera.rawValue
                print("Switching to \(AircraftCamera.shipCamera.rawValue)")
            }
        }
    }
     */

}
