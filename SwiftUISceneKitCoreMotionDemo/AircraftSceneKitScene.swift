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
}
