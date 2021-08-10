//
//  AircraftSceneKitScene.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 10/18/20.
//

import Foundation
import SceneKit




/*
 This is the View Model of the SwiftUISceneKitCoreMotionDemo app.
 */
class AircraftSceneKitScene: SCNScene, ObservableObject {

    var aircraftScene           = SCNScene(named: "art.scnassets/ship.scn")!
    var aircraftNode            = SCNNode()

    @Published var aircraftDistantCameraString  = AircraftCamera.distantCamera.rawValue
    @Published var aircraftShipCameraString     = AircraftCamera.shipCamera.rawValue

    @Published var aircraftCurrentCamera: SCNNode

    @Published var aircraftDistantCamera: SCNNode
    @Published var aircraftShipCamera: SCNNode

    @Published var aircraftDistantCameraNode: SCNNode
    @Published var aircraftShipCameraNode: SCNNode

    @Published var aircraftEnginesNode: SCNNode
    @Published var aircraftEngine: SCNParticleSystem



    override init() {
        print("AircraftScenekitScene override initialized")
        self.aircraftNode   = aircraftScene.rootNode.childNode(withName: "shipNode", recursively: true)!

        self.aircraftCurrentCamera      = aircraftScene.rootNode.childNode(withName: "distantCamera", recursively: true)!

        self.aircraftDistantCamera      = aircraftScene.rootNode.childNode(withName: "distantCamera", recursively: true)!
        self.aircraftShipCamera         = aircraftScene.rootNode.childNode(withName: "shipCamera", recursively: true)!

        self.aircraftDistantCameraNode  = aircraftScene.rootNode.childNode(withName: "distantCameraNode", recursively: true)!
        self.aircraftShipCameraNode     = aircraftScene.rootNode.childNode(withName: "shipCameraNode", recursively: true)!

        self.aircraftEnginesNode        = aircraftScene.rootNode.childNode(withName: "shipEnginesNode", recursively: true)!
        //self.aircraftEngine             = aircraftScene.rootNode.childNode(withName: "engine1", recursively: true)!

        //self.aircraftEngine             = SCNParticleSystem(named: "engine1", inDirectory: nil)!

        //self.aircraftEngine             = self.aircraftEngineNode.particleSystems![0]

        self.aircraftEngine              = SCNParticleSystem()

        super.init()

        self.setAircraftEngine()
    }



    required init?(coder: NSCoder) {
        print("AircraftScenekitScene initialized")
        self.aircraftNode   = aircraftScene.rootNode.childNode(withName: "shipNode", recursively: true)!

        self.aircraftCurrentCamera      = aircraftScene.rootNode.childNode(withName: "distantCamera", recursively: true)!

        self.aircraftDistantCamera      = aircraftScene.rootNode.childNode(withName: "distantCamera", recursively: true)!
        self.aircraftShipCamera         = aircraftScene.rootNode.childNode(withName: "shipCamera", recursively: true)!

        self.aircraftDistantCameraNode  = aircraftScene.rootNode.childNode(withName: "distantCameraNode", recursively: true)!
        self.aircraftShipCameraNode     = aircraftScene.rootNode.childNode(withName: "shipCameraNode", recursively: true)!

        self.aircraftEnginesNode        = aircraftScene.rootNode.childNode(withName: "shipEngineNode", recursively: true)!
        //self.aircraftEngine             = aircraftScene.rootNode.childNode(withName: "engine1", recursively: true)!

        self.aircraftEngine              = SCNParticleSystem()

        super.init(coder: coder)

        self.setAircraftEngine()
    }



    func setAircraftEngine() {
        aircraftEngine  = aircraftEnginesNode.particleSystems![0]
        print("aircraftEngine: \(String(describing: aircraftEnginesNode.particleSystems![0]))")
    }
}
