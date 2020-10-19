//
//  AircraftSceneRendererDelegate.swift
//  SceneKitSwiftUIGesturesDemoApp
//
//  Created by James Hillhouse IV on 10/17/20.
//

import SceneKit




class AircraftSceneRendererDelegate: SCNScene, SCNSceneRendererDelegate, ObservableObject {

    var aircraft = SCNScene(named: "art.scnassets/ship.scn")!
    var aircraftNode: SCNNode
    var aircraftCamera = "distantCamera"


    var showsStatistics: Bool = true


    override init() {
        self.aircraftNode = aircraft.rootNode.childNode(withName: "shipNode", recursively: true)!
        self.aircraftNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: .pi, y: 0.0, z: 0.0, duration: 2.0)))

        super.init()
    }


    required init?(coder: NSCoder) {
        self.aircraftNode = aircraft.rootNode.childNode(withName: "shipNode", recursively: true)!
        self.aircraftNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: .pi, y: 0.0, z: 0.0, duration: 2.0)))

        super .init(coder: coder)
    }


    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval)
    {
        print("AircraftSceneRendererDelegate.renderer(_, time)")

        //renderer.showsStatistics = showsStatistics

    }
}
