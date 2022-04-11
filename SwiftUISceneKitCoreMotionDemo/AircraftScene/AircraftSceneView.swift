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
    @State private var magnification        = CGFloat(1.0)
    @State private var isDragging           = false
    @State private var totalChangePivot     = SCNMatrix4Identity

    
    @EnvironmentObject var aircraft: AircraftSceneKitScene
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

                //changeOrientation(of: aircraft.aircraftSceneNode, with: value.translation)
                // AircraftCamera.distantCamera.rawValue
                
                if !aircraftCloudUserDefaults.gyroOrientationControl {
                    
                    if aircraftDelegate.aircraftCamera == AircraftCamera.distantCamera.rawValue {
                        //changeOrientation(of: aircraft.aircraftDistantCameraNode, with: value.translation)
                        changeOrientation(of: aircraft.aircraftCurrentCameraNode, with: value.translation)
                    }
                    
                    if aircraftDelegate.aircraftCamera == AircraftCamera.shipCamera.rawValue {
                        changeOrientation(of: aircraft.aircraftCurrentCamera, with: value.translation)
                    }
                }

            }
            .onEnded { value in
                self.isDragging = false

                //updateOrientation(of: aircraft.aircraftSceneNode)
                
                if !aircraftCloudUserDefaults.gyroOrientationControl {
                    
                    if aircraftDelegate.aircraftCamera == AircraftCamera.distantCamera.rawValue {
                        //updateOrientation(of: aircraft.aircraftDistantCameraNode)
                        updateOrientation(of: aircraft.aircraftCurrentCameraNode)
                    }
                    
                    if aircraftDelegate.aircraftCamera == AircraftCamera.shipCamera.rawValue {
                        updateOrientation(of: aircraft.aircraftCurrentCamera)
                    }
                }
            }
    }


    // Don't forget to comment this is you are using .allowsCameraControl
    var magnify: some Gesture {
        MagnificationGesture()
            .onChanged{ (value) in
                print("magnify = \(self.magnification)")

                self.magnification = value

                changeCameraFOV(of: (self.aircraft.aircraftCurrentCamera.camera)!,
                                value: self.magnification)

            }
            .onEnded{ value in
                print("Ended pinch with value \(value)\n\n")
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
                resetCameraFOV(of: (self.aircraft.aircraftCurrentCamera.camera)!)
                
                
                if aircraftDelegate.aircraftCamera == AircraftCamera.distantCamera.rawValue {
                    resetOrientation(of: aircraft.aircraftCurrentCameraNode)
                }
                
                if aircraftDelegate.aircraftCamera == AircraftCamera.shipCamera.rawValue {
                    resetOrientation(of: aircraft.aircraftCurrentCamera)
                }
                
                
                self.aircraftDelegate.motionManager.resetReferenceFrame()
            })

        }
        .onAppear {
            aircraftDelegate.aircraftCameraNode = aircraft.aircraftDistantCameraNode
            aircraftDelegate.motionManager.resetReferenceFrame()
        }
    }



    private func changeOrientation(of node: SCNNode, with translation: CGSize) {
        let x = Float(translation.width)
        let y = Float(-translation.height)

        let anglePan = sqrt(pow(x,2)+pow(y,2)) * (Float)(Double.pi) / 180.0
        //let anglePan = sqrt(pow((x * .pi / 180.0), 2) + pow((y * .pi / 180.0), 2))

        var rotationVector = SCNVector4()


        rotationVector.x =  y
        rotationVector.y = -x
        rotationVector.z =  0
        rotationVector.w = anglePan

        node.rotation = rotationVector
    }


    // TODO: Move this to the state observable object when it's done.
    // TODO: Consider changing this to quaternions
    private func updateOrientation(of node: SCNNode) {
        let currentPivot = node.pivot

        let changePivot = SCNMatrix4Invert(node.transform)

        totalChangePivot = SCNMatrix4Mult(changePivot, currentPivot)

        node.pivot = SCNMatrix4Mult(changePivot, currentPivot)

        node.transform = SCNMatrix4Identity
    }



    private func resetOrientation(of node: SCNNode) {
        let currentPivot    = node.pivot
        //print("currentPivot: \(currentPivot)")

        let changePivot     = SCNMatrix4Invert( totalChangePivot )
        //print("changePivot = \(changePivot)")

        node.pivot = SCNMatrix4Mult(changePivot, currentPivot)

        totalChangePivot    = SCNMatrix4Identity
    }



    private func changeCameraFOV(of camera: SCNCamera, value: CGFloat) {
        if magnification >= 1.025 {
            magnification = 1.025
        }
        if magnification <= 0.97 {
            magnification = 0.97
        }

        let maximumFOV: CGFloat = 25 // Zoom-in.
        let minimumFOV: CGFloat = 90 // Zoom-out.

        camera.fieldOfView /= magnification

        if camera.fieldOfView <= maximumFOV {
            camera.fieldOfView = maximumFOV
            magnification        = 1.0
        }
        if camera.fieldOfView >= minimumFOV {
            camera.fieldOfView = minimumFOV
            magnification        = 1.0
        }
    }



    private func resetCameraFOV(of camera: SCNCamera) {
        camera.fieldOfView = 60
    }
}




struct AircraftSceneView_Previews: PreviewProvider {
    static var previews: some View {
        AircraftSceneView()
    }
}

