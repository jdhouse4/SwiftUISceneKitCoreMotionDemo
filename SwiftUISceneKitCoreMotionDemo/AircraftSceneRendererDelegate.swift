//
//  AircraftSceneRendererDelegate.swift
//  SceneKitSwiftUIGesturesDemoApp
//
//  Created by James Hillhouse IV on 10/17/20.
//

import SceneKit




class AircraftSceneRendererDelegate: NSObject, SCNSceneRendererDelegate, ObservableObject {

    var showsStatistics: Bool = true


    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval)
    {
        print("AircraftSceneRendererDelegate.renderer(_, time)")

        renderer.showsStatistics = showsStatistics
    }
}
