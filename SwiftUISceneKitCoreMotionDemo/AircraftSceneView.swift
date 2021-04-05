//
//  AircraftSceneView.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 3/30/21.
//

import SwiftUI
import SceneKit




struct AircraftSceneView: View {
    @State private var sunlightSwitch       = true
    @State private var cameraSwitch         = true
    @State private var settingsSwitch       = false
    @State private var povName              = AircraftCamera.distantCamera.rawValue
    @State private var magnification        = CGFloat(1.0)
    @State private var isDragging           = false
    @State private var totalChangePivot     = SCNMatrix4Identity

    @StateObject private var aircraft           = AircraftSceneKitScene()
    @StateObject private var aircraftDelegate   = AircraftSceneRendererDelegate()


    // SceneView.Options for affecting the SceneView.
    // Uncomment if you would like to have Apple do all of the camera control
    //private var sceneViewCameraOptions      = SceneView.Options.allowsCameraControl
    //private var sceneViewRenderContinuously = SceneView.Options.rendersContinuously

    // Don't forget to comment this is you are using .allowsCameraControl
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                self.isDragging = true

                changeOrientation(of: aircraft.aircraftScene.rootNode.childNode(withName: "shipNode", recursively: true)!, with: value.translation)
            }
            .onEnded { value in
                self.isDragging = false

                updateOrientation(of: aircraft.aircraftScene.rootNode.childNode(withName: "shipNode", recursively: true)!)
            }
    }

    // Don't forget to comment this is you are using .allowsCameraControl
    var magnify: some Gesture {
        MagnificationGesture()
            .onChanged{ (value) in
                print("magnify = \(self.magnification)")

                self.magnification = value

                changeCameraFOV(of: (self.aircraft.aircraftScene.rootNode.childNode(withName: povName, recursively: true)?.camera)!,
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
                pointOfView: aircraft.aircraftScene.rootNode.childNode(withName: povName, recursively: true),
                delegate: aircraftDelegate
            )
            .gesture(exclusiveGesture)
            .onTapGesture(count: 2, perform: {
                resetCameraFOV(of: (self.aircraft.aircraftScene.rootNode.childNode(withName: povName, recursively: true)?.camera)!)
                resetOrientation(of: aircraft.aircraftScene.rootNode.childNode(withName: "shipNode", recursively: true)!)
                self.aircraftDelegate.motionManager.resetReferenceFrame()
            })

            VStack {
                Spacer()

                HStack (spacing: 5) {

                    //
                    // Button for toggling the sunlight.
                    //
                    Button( action: {
                        withAnimation{
                            self.sunlightSwitch.toggle()
                        }

                        self.toggleSunlight()
                    }) {
                        Image(systemName: sunlightSwitch ? "lightbulb.fill" : "lightbulb")
                            .imageScale(.large)
                            .accessibility(label: Text("Light Switch"))
                            .padding()
                    }


                    //
                    // Button for toggling cameras.
                    //
                    Button( action: {
                        withAnimation {
                            self.cameraSwitch.toggle()
                        }

                        self.changePOV(scene: self.aircraftDelegate)

                    }) {
                        Image(systemName: cameraSwitch ? "video.fill" : "video")
                            .imageScale(.large)
                            .accessibility(label: Text("Camera Switch"))
                            .padding()
                    }


                    //
                    // Button to show statistics.
                    //
                    Button( action: {
                        withAnimation {
                            self.settingsSwitch.toggle()
                        }

                        aircraftDelegate.showsStatistics.toggle()
                    }) {
                        Image(systemName: settingsSwitch ? "gearshape" : "gearshape.fill")
                            .imageScale(.large)
                            .accessibility(label: Text("Settings"))
                            .padding()
                    }
                }.padding(.bottom, settingsSwitch ? 120 : 5)
            }
        }.onAppear {
            self.aircraftDelegate.aircraftCameraNode = aircraft.aircraftScene.rootNode.childNode(withName: self.povName + "Node", recursively: true)
            self.aircraftDelegate.motionManager.resetReferenceFrame()
        }
    }



    func toggleSunlight() -> Void {
        let sunlight = self.aircraft.aircraftScene.rootNode.childNode(withName: "sunlightNode", recursively: true)?.light

        if self.sunlightSwitch == true {
            sunlight!.intensity = 2000.0
        } else {
            sunlight!.intensity = 0.0
        }
    }


    //
    // Escaping closure to push change from the AircraftScene function cycleCameras()
    //
    // Because of the way SwiftUI works, the call to the AircraftSceneRendererDelegate function cycleCamera()
    // wasn't being 'seen'.
    //
    func modifyPOV(closure: @escaping () -> Void) {
        closure()
    }



    private func changePOV(scene: SCNSceneRendererDelegate) -> Void {
        self.aircraftDelegate.changeCamera = true
        print("\nContentView cameraSwitch")

        modifyPOV { [self] in
            // This calls the delegate function to change cameras.
            self.aircraftDelegate.cycleCameras()

            // This sets povName String that will be read in the next call to initialize SceneView.
            self.povName = self.aircraftDelegate.aircraftCamera
            print("self.povName: \(self.povName)")

            // This (hopefully) sets the camera node that will be manipulated by the motion manager.
            self.aircraftDelegate.aircraftCameraNode = aircraft.aircraftScene.rootNode.childNode(withName: self.povName + "Node", recursively: true)
        }
    }



    private func changeOrientation(of node: SCNNode, with translation: CGSize) {
        let x = Float(translation.width)
        let y = Float(-translation.height)

        let anglePan = sqrt(pow(x,2)+pow(y,2)) * (Float)(Double.pi) / 180.0

        var rotationVector = SCNVector4()

        rotationVector.x = -y
        rotationVector.y = x
        rotationVector.z = 0
        rotationVector.w = anglePan

        node.rotation = rotationVector
    }



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
        if self.magnification >= 1.025 {
            self.magnification = 1.025
        }
        if self.magnification <= 0.97 {
            self.magnification = 0.97
        }

        let maximumFOV: CGFloat = 25 // Zoom-in.
        let minimumFOV: CGFloat = 90 // Zoom-out.

        camera.fieldOfView /= magnification

        if camera.fieldOfView <= maximumFOV {
            camera.fieldOfView = maximumFOV
            self.magnification        = 1.0
        }
        if camera.fieldOfView >= minimumFOV {
            camera.fieldOfView = minimumFOV
            self.magnification        = 1.0
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

