//
//  AircraftSceneRendererDelegate.swift
//  SceneKitSwiftUIGesturesDemoApp
//
//  Created by James Hillhouse IV on 10/17/20.
//

//import Cocoa
import SceneKit




class AircraftSceneRendererDelegate: NSObject, SCNSceneRendererDelegate {

    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval)
    {
        print("AircraftSceneRendererDelegate.renderer(_, time)")
    }
}
