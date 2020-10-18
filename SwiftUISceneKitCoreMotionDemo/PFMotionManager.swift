//
//  PFMotionManager.swift
//  Mission-Orion2
//
//  Created by James Hillhouse IV on 9/17/15.
//  Copyright © 2015 PortableFrontier. All rights reserved.
//

import CoreMotion
import SceneKit
import simd




enum DeviceMotionState: String
{
    case DeviceMotionOff            = "DeviceMotionOff"
    case DeviceMotionOn             = "DeviceMotionOn"
    case DeviceMotionInoperative    = "DeviceMotionInoperative"
}




enum DeviceMtionError: Error
{
    case deviceMotionUnavailable
    case deviceMotionInactive
    case deviceMotionAttitudeUnavailable
    case deviceMotionQuaternionUnavailable
}




class PFMotionManager
{
    //
    // CMMotion variables
    //
    /* 
        Previously, myMotionManager was an instance of an extension to CMMotionManager declared in 
        CMMotionManger+Shared.swift.
    
        I may go back to this implementation. TBD.
    */
    //var myMotionManager:    CMMotionManager     = CMMotionManager.missionOrionSharedMotionManager // CMMotionManager()

    //
    // Declare the singleton :)
    //
    static let sharedMotionMangerInstance: PFMotionManager  = PFMotionManager()

    var motionManager: CMMotionManager    = CMMotionManager()

    var myDeviceMotion: CMDeviceMotion?
    var referenceFrame: CMAttitude?

    var sceneQuaternion: SCNQuaternion?
    var deviceQuaternion: CMQuaternion?

    var gyroMode: Bool



    private init()
    {
        print("PFMotionManager singleton created. :)")

        self.gyroMode       = false
        self.setupDeviceQuaternion()
    }




    // MARK: ==========================================================================
    // MARK: DEVICE MOTION FUNCTIONS
    //
    // MARK: These need to be moved into their own class(s)
    // MARK: ==========================================================================
    func setupDeviceQuaternion()
    {
        print("PFMotionManager setupDeviceQuaternion()")
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: DeviceMotionState.DeviceMotionOff.rawValue), object: self)

        var tempSceneQuaternion: SCNQuaternion?

        if motionManager.isDeviceMotionAvailable
        {
            motionManager.deviceMotionUpdateInterval    = 1.0 / 60.0
            motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: {
                myDeviceMotion, error in
                //print("Testing...")
            })
        }


        if motionManager.isDeviceMotionAvailable
        {
            while !gyroMode
            {
                if motionManager.isDeviceMotionActive
                {
                    myDeviceMotion = motionManager.deviceMotion


                    if motionManager.isGyroAvailable
                    {
                        referenceFrame = myDeviceMotion?.attitude
                    }


                    if gyroMode
                    {
                        myDeviceMotion?.attitude.multiply(byInverseOf: (myDeviceMotion?.attitude)!)
                    }


                    if (myDeviceMotion?.attitude != nil)
                    {
                        deviceQuaternion = myDeviceMotion?.attitude.quaternion

                        if (myDeviceMotion?.attitude.quaternion != nil)
                        {
                            tempSceneQuaternion = SCNQuaternion(x: Float(deviceQuaternion!.y),
                                                                y: Float(-deviceQuaternion!.x),
                                                                z: Float(-deviceQuaternion!.z),
                                                                w: Float(deviceQuaternion!.w))
                        }

                        if !gyroMode
                        {
                            resetReferenceFrame()

                            gyroMode = true
                        }
                    }
                    else
                    {
                        //print("Attitude not yet set.")
                    }
                }
                else
                {
                    //print("Device Motion isn't active.")
                }
            }

            //print("Device Motion is available.")

            NotificationCenter.default.post(name: Notification.Name(rawValue: DeviceMotionState.DeviceMotionOn.rawValue), object: self)
        }
        else
        {
            print("Device Motion isn't available. You're in deep doo-doo!")

            NotificationCenter.default.post(name: Notification.Name(rawValue: DeviceMotionState.DeviceMotionInoperative.rawValue), object: self)
        }

        if let sceneQ = tempSceneQuaternion
        {
            print("sceneQuaternion set by device motion.")
            sceneQuaternion                 = sceneQ
        }

        if tempSceneQuaternion == nil
        {
            print("Oops, you don't have a scene quaternion. Using GLKQuaternionIdentity.")
            let tempQ                       = GLKQuaternionIdentity
            tempSceneQuaternion             = SCNQuaternion(x: Float(tempQ.y),
                                                            y: Float(-tempQ.x),
                                                            z: Float(-tempQ.z),
                                                            w: Float(tempQ.w))
            sceneQuaternion                 = tempSceneQuaternion
        }
    }

    

    func startMotion()
    {
        var aMotionManager: CMMotionManager?
        aMotionManager = motionManager

        if (aMotionManager != nil)
        {
            motionManager.deviceMotionUpdateInterval    = 1.0 / 60.0
            motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: {
                myDeviceMotion, error in })
        }
    }



    func stopMotion()
    {
        motionManager.stopDeviceMotionUpdates()
    }



    @IBAction func resetReferenceFrame()
    {
        print("resetReferenceFrame")

        if motionManager.isDeviceMotionActive
        {
            referenceFrame          = motionManager.deviceMotion!.attitude
        }
    }


    func updateAttitudeQuaternion()
    {
        if (motionManager.isDeviceMotionAvailable)
        {
            myDeviceMotion      = motionManager.deviceMotion

            if ((referenceFrame) == nil)
            {
                referenceFrame      = motionManager.deviceMotion!.attitude
            }

            else if (gyroMode)
            {
                myDeviceMotion?.attitude.multiply(byInverseOf: referenceFrame!)
            }
            
            if (myDeviceMotion?.attitude != nil)
            {
                deviceQuaternion    = myDeviceMotion?.attitude.quaternion

                if ((myDeviceMotion?.attitude) != nil)
                {
                    sceneQuaternion = SCNQuaternion(x: Float(deviceQuaternion!.y),
                                                    y: Float(-deviceQuaternion!.x),
                                                    z: Float(-deviceQuaternion!.z),
                                                    w: Float(deviceQuaternion!.w))
                }
            }
        }
    }
}
