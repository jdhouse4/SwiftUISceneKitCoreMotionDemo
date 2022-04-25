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
    
    var aircraftSceneNode: SCNNode
    
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
    @Published var aircraftCurrentCameraNode: SCNNode
    @Published var aircraftDistantCameraNode: SCNNode
    @Published var aircraftShipCameraNode: SCNNode

    /// Aircraft engine particle system nodes and and particles
    @Published var aircraftEnginesNode: SCNNode
    @Published var aircraftEngine: SCNParticleSystem

    /// Aircraft RCS particle system nodes
    @Published var rcsNode: SCNNode
    @Published var rcsRollPortUpNode: SCNNode
    @Published var rcsRollPortDownNode: SCNNode
    @Published var rcsRollStarboardUpNode: SCNNode
    @Published var rcsRollStarboardDownNode: SCNNode

    /// RCS roll motion particle system
    @Published var rcsRollPortUp: SCNParticleSystem
    @Published var rcsRollPortDown: SCNParticleSystem
    @Published var rcsRollStarboardUp: SCNParticleSystem
    @Published var rcsRollStarboardDown: SCNParticleSystem
    
    /// Orientation
    @Published var aircraftQuaternion: simd_quatf   = simd_quatf(ix: 0.0, iy: 0.0, iz: 0.0, r: 1.0)
    @Published var deltaQuaternion: simd_quatf      = simd_quatf(ix: 0.0, iy: 0.0, iz: 0.0, r: 1.0)
    
    

    override init() {
        print("AircraftScenekitScene override initialized")
        self.aircraftSceneNode          = aircraftScene.rootNode.childNode(withName: "shipSceneNode", recursively: true)!
        
        self.aircraftNode               = aircraftScene.rootNode.childNode(withName: "shipNode", recursively: true)!
        
        self.aircraftCurrentCamera      = aircraftScene.rootNode.childNode(withName: "distantCamera", recursively: true)!

        self.aircraftDistantCamera      = aircraftScene.rootNode.childNode(withName: "distantCamera", recursively: true)!
        self.aircraftShipCamera         = aircraftScene.rootNode.childNode(withName: "shipCamera", recursively: true)!
        
        self.aircraftCurrentCameraNode  = aircraftScene.rootNode.childNode(withName: "distantCameraNode", recursively: true)!

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
        print("AircraftScenekitScene required initializer")
        self.aircraftSceneNode          = aircraftScene.rootNode.childNode(withName: "shipSceneNode", recursively: true)!
        
        self.aircraftNode               = aircraftScene.rootNode.childNode(withName: "shipNode", recursively: true)!

        self.aircraftCurrentCamera      = aircraftScene.rootNode.childNode(withName: "distantCamera", recursively: true)!

        self.aircraftDistantCamera      = aircraftScene.rootNode.childNode(withName: "distantCamera", recursively: true)!
        self.aircraftShipCamera         = aircraftScene.rootNode.childNode(withName: "shipCamera", recursively: true)!

        self.aircraftCurrentCameraNode  = aircraftScene.rootNode.childNode(withName: "distantCameraNode", recursively: true)!

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



    // This is just for the particle system for the jet exhaust.
    func setAircraftEngine() {
        aircraftEngine  = aircraftEnginesNode.particleSystems![0]
        //print("aircraftEngine: \(String(describing: aircraftEnginesNode.particleSystems![0]))")
    }

    
    
    // This is just for the particle system, not the action that sets the roll rotation.
    func setAircraftRCS() {
        rcsRollPortUp           = rcsRollPortUpNode.particleSystems![0]
        rcsRollPortDown         = rcsRollPortDownNode.particleSystems![0]
        rcsRollStarboardUp      = rcsRollStarboardUpNode.particleSystems![0]
        rcsRollStarboardDown    = rcsRollStarboardDownNode.particleSystems![0]
    }
    
    
    
    func rollStarboard() {
        
        let rollAngle: Float   = 0.025 * .pi / 180.0
        
        let rollQuaternion: simd_quatf  = simd_quatf(ix: 0.0, iy: 0.0, iz: 1.0, r: rollAngle)
    }
}
