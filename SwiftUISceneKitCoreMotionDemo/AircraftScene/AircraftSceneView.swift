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
                
                if !aircraftCloudUserDefaults.gyroOrientationControl {
                    
                    if aircraftDelegate.aircraftCamera == AircraftCamera.distantCamera.rawValue {
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
    
    
    
    private func changed(of node: SCNNode, with value: DragGesture.Value) {
        
        ///
        /// Someday, use the example in the Medium post, "[SceneKit Rotations with Quaternions]"(https://medium.com/@jacob.waechter/scenekit-rotations-with-quaternions-d74dc6ba68c6)
        ///
        /// and https://stackoverflow.com/questions/44991038/get-vector-in-scnnode-environment-from-touch-location-swift.
        ///
        /// But Apple's SwiftUI and SceneKit people will need to resolve a few things, which they haven't done for two years.
        ///
        /// Either SceneView needs to be able to be accessed as a, say, `self.sceneView` within the SCNSceneRendererDelegate or, better yet,
        /// within the Struct in which the SceneView is declared and defined so that one might be able to do, you know,
        /// ```
        /// func getDirection(for point: CGPoint, in view: SCNView) -> SCNVector3 {
        ///     let farPoint  = view.unprojectPoint(SCNVector3Make(point.x, point.y, 1))
        ///     let nearPoint = view.unprojectPoint(SCNVector3Make(point.x, point.y, 0))
        ///
        ///     return SCNVector3Make(farPoint.x - nearPoint.x, farPoint.y - nearPoint.y, farPoint.z - nearPoint.z)
        /// }```
        ///
        /// Or gosh, even, in a DragGesture or TapGesture,
        /// ```
        /// let scneneView = recognizer.view as! SCNView
        /// let p          = recognizer.location(in: scnView)
        /// let hitResults = scnView.hitTest(p, options: [:])
        ///
        /// if let hit = hitResults.first{
        ///     let worldTouch = simd_float3(result.worldCoordinates)
        ///     ...
        /// }
        /// ```
        ///
        /// I write this because, as of April 2022, nearly two full years since SceneView was introduced in SwiftUI, one can do any of these.
        ///
        /// That sorta sucks because it takes a whole host of things off the table that are commonly used SceneKit techniques for performing hit testing or
        /// just trying to get the worldLocation and localLocation of nodes.
        ///
        /// To do these things now requires using UIViewRepresentable and just the usual crap code that SwiftUI was supposed to take-away from us.
        ///
        print("\n\(#function) startLocation: \(value.startLocation)")
        print("\(#function) currentLocation: \(value.location)")
        
        var startVector3    = simd_float3()
        var startNorm3      = simd_float3()
        var endVector3      = simd_float3()
        var endNorm3        = simd_float3()
        var axis            = simd_float3()
        
        if let start = value.startLocation as CGPoint? {
            startVector3 = simd_float3(x: Float(start.x), y: Float(start.y), z: 0.0)
            //print("\(#function) startVector3: \(startVector3)")
            
            startNorm3 = simd_normalize(startVector3)
        }
        
        if let end = value.location as CGPoint? {
            endVector3 = simd_float3(x: Float(end.x), y: Float(end.y), z: 0.0)
            //print("\(#function) endVector3: \(endVector3)")
            
            endNorm3 = simd_normalize(endVector3)
        }
        
        print("\(#function) node.simdWorldPosition: \(node.simdWorldPosition)")
        print("\(#function) node.simdWorldOrientation: \(node.simdWorldOrientation)")
        
        let angle = acosf(simd_dot(startNorm3, endNorm3))
        print("\(#function) angle (in degrees): \(angle * 180.0 / .pi)")

        /// Modify startVector3 and endVector3 so that the cross, or vector, product isn't only about the z-axis.
        startVector3    = simd_normalize(simd_float3(x: startVector3.x, y: startVector3.y, z: node.position.z))
        endVector3      = simd_normalize(simd_float3(x: endVector3.x, y: endVector3.y, z: node.position.z))
        
        axis = simd_normalize(simd_cross(startVector3, endVector3))
        print("\(#function) axis: \(axis)")
        
        /// Remove the z-component because rotation about the z-axis is not desired.
        //axis = simd_normalize(simd_float3(x: axis.x, y: -axis.y, z: 0.0))
        //print("\(#function) Revised axis (removed z-component): \(axis)")

        let newOrientation: simd_quatf = simd_quatf(angle: -angle, axis: axis).normalized
        print("\(#function) newOrientation: \(newOrientation)")
        
        let currentOrientation = node.simdOrientation
        print("\(#function) currentOrientation = \(currentOrientation)\n")
        
        print("\(#function) node.simdOrientation: \(node.simdOrientation)")
        //node.simdOrientation = simd_normalize(newOrientation * currentOrientation)
        print("\(#function) node.simdOrientation: \(node.simdOrientation)")
    }



    private func changeOrientation(of node: SCNNode, with translation: CGSize) {
        //print("\n\(#function) translation: \(translation)")
        
        let x = Float(translation.width)
        let y = Float(-translation.height)

        let anglePan = sqrt(pow(x,2)+pow(y,2)) * (Float)(Double.pi) / 180.0
        //print("\(#function) anglePan (in degrees): \(anglePan * 180.0 / .pi)")
        //let anglePan = sqrt(pow((x * .pi / 180.0), 2) + pow((y * .pi / 180.0), 2))

        var rotationVector = SCNVector4()

        rotationVector.x =  y
        rotationVector.y = -x
        rotationVector.z =  0
        rotationVector.w = anglePan

        node.rotation = rotationVector
        //print("\(#function) rotationVector: \(rotationVector)")
        
        //let rotationQuaternion = simd_quatf(ix: y, iy: -x, iz: 0, r: anglePan).normalized
        //print("\(#function) rotationQuaternion: \(rotationQuaternion)\n")
    }


    // TODO: Consider changing this to quaternions when SceneView content can be accessed.
    private func updateOrientation(of node: SCNNode) {
        
        //print("\n\(#function) currentOrientation: \(node.orientation)")
        
        let currentPivot = node.pivot
        //print("currentPivot: \(currentPivot)")

        let changePivot = SCNMatrix4Invert(node.transform)
        //print("changePivot: \(changePivot)")
        
        totalChangePivot = SCNMatrix4Mult(changePivot, currentPivot)
        //print("totalChangePivot: \(totalChangePivot)")
        
        node.pivot = SCNMatrix4Mult(changePivot, currentPivot)
        //print("node.pivot: \(node.pivot)")
        
        node.transform = SCNMatrix4Identity
        //print("node.transform: \(node.transform)")
    }



    ///
    /// MotionManager.swift's resetReferenceFrame resets the `attitude simd_Quatertian` to the current attitude.
    /// I'm hoping that for gestures, that will be a quaterion of (0,0,0,1).
    /// :-/
    ///
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

