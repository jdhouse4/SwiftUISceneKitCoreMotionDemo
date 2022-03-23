//
//  AircraftSceneKitScene.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 10/18/20.
//

import Foundation
import SceneKit




/**
 This is the SceneKit Model for the  of the SwiftUISceneKitCoreMotionDemo app.
 */
class AircraftSceneKitScene: SCNScene, ObservableObject {

    var aircraftScene           = SCNScene(named: "art.scnassets/ship.scn")!
    
    var aircraftNode            = SCNNode()

    /// Aircraft camera strings (This should be an enum)
    @Published var aircraftDistantCameraString  = AircraftCamera.distantCamera.rawValue
    @Published var aircraftShipCameraString     = AircraftCamera.shipCamera.rawValue

    /// Aircraft cameras
    @Published var aircraftCurrentCamera: SCNNode

    @Published var aircraftDistantCamera: SCNNode
    @Published var aircraftShipCamera: SCNNode

    /// Aircraft camera nodes
    //var frontCameraNode: SCNNode
    
    @Published var aircraftDistantCameraNode: SCNNode
    @Published var aircraftShipCameraNode: SCNNode

    /// Aircraft engine nodes
    @Published var aircraftEnginesNode: SCNNode
    @Published var aircraftEngine: SCNParticleSystem

    /// Aircraft RCS nodes
    @Published var rcsNode: SCNNode
    @Published var rcsRollPortUpNode: SCNNode
    @Published var rcsRollPortDownNode: SCNNode
    @Published var rcsRollStarboardUpNode: SCNNode
    @Published var rcsRollStarboardDownNode: SCNNode

    /// RCS roll motion
    @Published var rcsRollPortUp: SCNParticleSystem
    @Published var rcsRollPortDown: SCNParticleSystem
    @Published var rcsRollStarboardUp: SCNParticleSystem
    @Published var rcsRollStarboardDown: SCNParticleSystem

    override init() {
        print("AircraftScenekitScene override initialized")
        self.aircraftNode               = aircraftScene.rootNode.childNode(withName: "shipNode", recursively: true)!
        
        self.aircraftCurrentCamera      = aircraftScene.rootNode.childNode(withName: "distantCamera", recursively: true)!

        self.aircraftDistantCamera      = aircraftScene.rootNode.childNode(withName: "distantCamera", recursively: true)!
        self.aircraftShipCamera         = aircraftScene.rootNode.childNode(withName: "shipCamera", recursively: true)!

        self.aircraftDistantCameraNode  = aircraftScene.rootNode.childNode(withName: "distantCameraNode", recursively: true)!
        self.aircraftShipCameraNode     = aircraftScene.rootNode.childNode(withName: "shipCameraNode", recursively: true)!

        self.aircraftEnginesNode        = aircraftScene.rootNode.childNode(withName: "shipEnginesNode", recursively: true)!

        self.aircraftEngine             = SCNParticleSystem()

        // RCS Nodes
        rcsNode                         = aircraftScene.rootNode.childNode(withName: "rcsNode", recursively: true)!
        rcsRollPortUpNode               = aircraftScene.rootNode.childNode(withName: "rcsRollPortUp", recursively: true)!
        rcsRollPortDownNode             = aircraftScene.rootNode.childNode(withName: "rcsRollPortDown", recursively: true)!
        rcsRollStarboardUpNode          = aircraftScene.rootNode.childNode(withName: "rcsRollStarboardUp", recursively: true)!
        rcsRollStarboardDownNode        = aircraftScene.rootNode.childNode(withName: "rcsRollStarboardDown", recursively: true)!

        // RCS Engines
        rcsRollPortUp                   = SCNParticleSystem()
        rcsRollPortDown                 = SCNParticleSystem()
        rcsRollStarboardUp              = SCNParticleSystem()
        rcsRollStarboardDown            = SCNParticleSystem()

        super.init()

        setAircraftEngine()

        setAircraftRCS()
    }



    required init?(coder: NSCoder) {
        print("AircraftScenekitScene initialized")
        self.aircraftNode               = aircraftScene.rootNode.childNode(withName: "shipNode", recursively: true)!

        self.aircraftCurrentCamera      = aircraftScene.rootNode.childNode(withName: "distantCamera", recursively: true)!

        self.aircraftDistantCamera      = aircraftScene.rootNode.childNode(withName: "distantCamera", recursively: true)!
        self.aircraftShipCamera         = aircraftScene.rootNode.childNode(withName: "shipCamera", recursively: true)!

        self.aircraftDistantCameraNode  = aircraftScene.rootNode.childNode(withName: "distantCameraNode", recursively: true)!
        self.aircraftShipCameraNode     = aircraftScene.rootNode.childNode(withName: "shipCameraNode", recursively: true)!

        self.aircraftEnginesNode        = aircraftScene.rootNode.childNode(withName: "shipEngineNode", recursively: true)!

        self.aircraftEngine              = SCNParticleSystem()

        // RCS Nodes
        rcsNode                         = aircraftScene.rootNode.childNode(withName: "rcsNode", recursively: true)!
        rcsRollPortUpNode               = aircraftScene.rootNode.childNode(withName: "rcsRollPortUp", recursively: true)!
        rcsRollPortDownNode             = aircraftScene.rootNode.childNode(withName: "rcsRollPortDown", recursively: true)!
        rcsRollStarboardUpNode          = aircraftScene.rootNode.childNode(withName: "rcsRollStarboardUp", recursively: true)!
        rcsRollStarboardDownNode        = aircraftScene.rootNode.childNode(withName: "rcsRollStarboardDown", recursively: true)!

        // RCS Engines
        rcsRollPortUp                   = SCNParticleSystem()
        rcsRollPortDown                 = SCNParticleSystem()
        rcsRollStarboardUp              = SCNParticleSystem()
        rcsRollStarboardDown            = SCNParticleSystem()

        super.init(coder: coder)

        setAircraftEngine()

        setAircraftRCS()
    }



    func setAircraftEngine() {
        aircraftEngine  = aircraftEnginesNode.particleSystems![0]
        //print("aircraftEngine: \(String(describing: aircraftEnginesNode.particleSystems![0]))")
    }

    
    
    func setAircraftRCS() {
        rcsRollPortUp           = rcsRollPortUpNode.particleSystems![0]
        rcsRollPortDown         = rcsRollPortDownNode.particleSystems![0]
        rcsRollStarboardUp      = rcsRollStarboardUpNode.particleSystems![0]
        rcsRollStarboardDown    = rcsRollStarboardDownNode.particleSystems![0]
    }
}
