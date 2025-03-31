//
//  AircraftSceneView.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 3/30/21.
//

import SwiftUI
import SceneKit




/*
 This view contains all of the code for the SceneView() for the primary scene.
 */
struct AircraftSceneView: View {
    @State private var isDragging = false

    @EnvironmentObject var motionManager: MotionManager
    @EnvironmentObject var aircraft: AircraftSceneKitScene
    @EnvironmentObject var aircraftCameraState: AircraftCameraState
    @EnvironmentObject var aircraftCloudUserDefaults: AircraftCloudUserDefaults

    
    /// This contains the function
    /// `renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval)`
    /// that is used to animate the model.
    @EnvironmentObject var aircraftDelegate: AircraftSceneRendererDelegate


    // SceneView.Options for affecting the SceneView.
    // Uncomment if you would like to have Apple do all of the camera control
    //private var sceneViewCameraOptions      = SceneView.Options.allowsCameraControl
    //private var sceneViewRenderContinuously = SceneView.Options.rendersContinuously


    // Don't forget to comment that you are using .allowsCameraControl
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                self.isDragging = true
                
                if !aircraftCloudUserDefaults.gyroOrientationControl {
                    
                    if aircraftDelegate.aircraftCurrentCamera == AircraftCamera.distantCamera.rawValue {
                        aircraftCameraState.changeCameraOrientation(of: aircraft.aircraftCurrentCameraNode, with: value.translation)
                    }
                    
                    if aircraftDelegate.aircraftCurrentCamera == AircraftCamera.shipCamera.rawValue {
                        aircraftCameraState.changeCameraOrientation(of: aircraft.aircraftCurrentCamera, with: value.translation)
                    }
                    
                }
            }
            .onEnded { value in
                
                self.isDragging = false
                
                if !aircraftCloudUserDefaults.gyroOrientationControl {
                    
                    if aircraftDelegate.aircraftCurrentCamera == AircraftCamera.distantCamera.rawValue {
                        aircraftCameraState.updateCameraOrientation(of: aircraft.aircraftCurrentCameraNode)
                    }
                    
                    if aircraftDelegate.aircraftCurrentCamera == AircraftCamera.shipCamera.rawValue {
                        aircraftCameraState.updateCameraOrientation(of: aircraft.aircraftCurrentCamera)
                    }
                    
                }
            }
    }


    // Don't forget to comment this is you are using .allowsCameraControl
    var magnify: some Gesture {
        MagnificationGesture()
            .onChanged{ (magnificationValue) in

                //
                // Only zoom in/out in the external cameras, at least for now.
                //
                if aircraftDelegate.aircraftCurrentCamera == AircraftCamera.distantCamera.rawValue {
                    
                    aircraftCameraState.currentCameraMagnification = magnificationValue
                    //print("magnify = \(aircraftCameraState.currentCameraMagnification)")
                    
                    aircraftCameraState.changeCurrentCameraFOV(of: aircraft.aircraftCurrentCamera.camera!, value: aircraftCameraState.currentCameraMagnification)
                    
                }
            }
            .onEnded{ magnificationValue in
                
                //print("Ended pinch with value \(magnificationValue)\n\n")
                
            }
    }


    // Don't forget to comment this is you are using .allowsCameraControl
    var exclusiveGesture: some Gesture {
        
        ExclusiveGesture(drag, magnify)
        
    }


    var body: some View {
        ZStack {
            SceneView (
                scene: aircraft.aircraftScene,
                pointOfView: aircraft.aircraftCurrentCamera,
                delegate: aircraftDelegate
            )
            .gesture(exclusiveGesture)
            .onTapGesture(count: 2, perform: {
                
                aircraftCameraState.resetCurrentCameraFOV(of: (self.aircraft.aircraftCurrentCamera.camera)!)
                
                if aircraftDelegate.aircraftCurrentCamera == AircraftCamera.distantCamera.rawValue {
                    aircraftCameraState.resetCameraOrientation(of: aircraft.aircraftCurrentCameraNode)
                }
                
                if aircraftDelegate.aircraftCurrentCamera == AircraftCamera.shipCamera.rawValue {
                    aircraftCameraState.resetCameraOrientation(of: aircraft.aircraftCurrentCamera)
                }
                
            })

        }
        .onAppear {
            
            aircraftDelegate.aircraftCurrentCameraNode = aircraft.aircraftDistantCameraNode
            motionManager.resetReferenceFrame()
            
        }
    }
}




struct AircraftSceneView_Previews: PreviewProvider {
    static var previews: some View {
        AircraftSceneView()
    }
}

