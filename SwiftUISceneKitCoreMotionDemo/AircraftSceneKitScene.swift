//
//  AircraftSceneKitScene.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 10/18/20.
//

import Foundation
import SceneKit




class AircraftSceneKitScene: SCNScene, ObservableObject {

    var aircraftScene           = SCNScene(named: "art.scnassets/ship.scn")!
    var aircraftNode            = SCNNode()

    @Published var aircraftDistantCamera    = AircraftCamera.distantCamera.rawValue
    @Published var aircraftShipCamera       = AircraftCamera.shipCamera.rawValue

    @Published var aircraftDistantCameraNode: SCNNode
    @Published var aircraftShipCameraNode: SCNNode
    


    override init() {
        print("AircraftScenekitScene override initialized")
        self.aircraftNode   = aircraftScene.rootNode.childNode(withName: "shipNode", recursively: true)!
        self.aircraftDistantCameraNode   = aircraftScene.rootNode.childNode(withName: "distantCameraNode", recursively: true)!
        self.aircraftShipCameraNode      = aircraftScene.rootNode.childNode(withName: "shipCameraNode", recursively: true)!

        super.init()
    }



    required init?(coder: NSCoder) {
        print("AircraftScenekitScene initialized")
        self.aircraftNode   = aircraftScene.rootNode.childNode(withName: "shipNode", recursively: true)!
        self.aircraftDistantCameraNode   = aircraftScene.rootNode.childNode(withName: "distantCameraNode", recursively: true)!
        self.aircraftShipCameraNode      = aircraftScene.rootNode.childNode(withName: "shipCameraNode", recursively: true)!

        super.init(coder: coder)
    }
}
