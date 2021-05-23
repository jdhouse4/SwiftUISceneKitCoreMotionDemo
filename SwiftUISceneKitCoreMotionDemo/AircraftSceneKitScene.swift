//
//  AircraftSceneKitScene.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 10/18/20.
//

import Foundation
import SceneKit
import SwiftUI




class AircraftSceneKitScene: SCNScene, ObservableObject {
    @Published var aircraftCamera: String       = AircraftCamera.distantCamera.rawValue
    var aircraftCameraNode  = SCNNode()

    var aircraftScene       = SCNScene(named: "art.scnassets/ship.scn")!
    var aircraftNode        = SCNNode()





    override init() {
        print("AircraftScenekitScene override initialized")
        self.aircraftNode       = aircraftScene.rootNode.childNode(withName: "shipNode", recursively: true)!
        //self.aircraftCameraNode = aircraftScene.rootNode.childNode(withName: AircraftCamera.distantCamera.rawValue + "Node", recursively: true)!

        super.init()

    }



    required init?(coder: NSCoder) {
        print("AircraftScenekitScene initialized")
        self.aircraftNode       = aircraftScene.rootNode.childNode(withName: "shipNode", recursively: true)!
        //self.aircraftCameraNode = aircraftScene.rootNode.childNode(withName: AircraftCamera.distantCamera.rawValue + "Node", recursively: true)!

        super.init(coder: coder)
    }
}
