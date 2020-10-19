//
//  MotionManager.swift
//  GyroSwiftUI
//
//  Created by James Hillhouse IV on 1/6/20.
//  Copyright © 2020 PortableFrontier. All rights reserved.
//

import Foundation
import Combine
import CoreMotion
import simd



class MotionManager: ObservableObject {
    private var motionManager: CMMotionManager

    @Published var motionQuaternion: simd_quatf = simd_quatf()

    var referenceFrame: CMAttitude?
    var motionTimer: Timer?
    var deviceMotion: CMDeviceMotion?
    var motionQuaterionAvailable: Bool = false
    var resetFrame: Bool = false




    init() {
        print("MotionManager initialized")
        self.motionManager = CMMotionManager()
        self.setupDeviceMotion()
    }



    func setupDeviceMotion() {
        //var cycles: Int = 1
        if motionManager.isDeviceMotionAvailable {
            self.motionManager.deviceMotionUpdateInterval = 1.0 / 60.0
            self.motionManager.startDeviceMotionUpdates()


            while motionQuaterionAvailable == false {
                if self.motionManager.deviceMotion != nil {
                    if self.motionManager.isDeviceMotionActive {

                        self.deviceMotion = self.motionManager.deviceMotion

                        if motionManager.isGyroAvailable {
                            if motionManager.deviceMotion?.attitude != nil {

                                self.referenceFrame = self.deviceMotion?.attitude

                                self.deviceMotion?.attitude.multiply(byInverseOf: self.referenceFrame!)

                                self.motionQuaterionAvailable = true
                            }
                        }
                    }
                }
                //cycles += 1
                //print("cycles: \(cycles)") // Usually takes between 1,800 to 2,000 cycles before gyro is available.
            }
        }
        //print("deviceMotion: \(String(describing: self.deviceMotion))")
        //print("referenceFrame: \(String(describing: self.referenceFrame))")

        self.startDeviceMotion()
    }



    func startDeviceMotion() {
        print("motion startDeviceMotion()")
        self.motionTimer = Timer(fire: Date(), interval: (1.0 / 60.0), repeats: true,
                                 block: { (motionTimer) in
                                    if self.deviceMotion != nil {
                                        self.motionQuaternion = simd_quatf(ix: Float((self.deviceMotion?.attitude.quaternion.x)!),
                                                                           iy: Float((self.deviceMotion?.attitude.quaternion.y)!),
                                                                           iz: Float((self.deviceMotion?.attitude.quaternion.z)!),
                                                                           r:  Float((self.deviceMotion?.attitude.quaternion.w)!)).normalized

                                        self.updateAttitude()
                                    }
        })

        //print("motionTimer set.")

        // Add the timer to the current run loop.
        RunLoop.current.add(self.motionTimer!, forMode: RunLoop.Mode.common)

    }



    func stopMotion()
    {
        motionManager.stopDeviceMotionUpdates()
    }



    func resetReferenceFrame()
    {
        //print("MotionManager resetReferenceFrame()")
        if motionManager.isDeviceMotionAvailable
        {
            //print("MotionManager device motion is available.")
            referenceFrame          = motionManager.deviceMotion!.attitude
            resetFrame.toggle()
            //print("resetFrame: \(resetFrame)")
        }
    }



    func updateAttitude() {
        deviceMotion = motionManager.deviceMotion

        if motionManager.deviceMotion != nil {
            deviceMotion?.attitude.multiply(byInverseOf: referenceFrame!)
        }
    }
}



/*
 func startContinuousDeviceMotion() {
     if motionManager.isDeviceMotionAvailable {
         self.motionManager.deviceMotionUpdateInterval = 1.0 / 60.0
         //self.motionManager.showsDeviceMovementDisplay = true

         /*
         self.motionManager.startDeviceMotionUpdates()

         if let tempDeviceMotion = self.motionManager.deviceMotion {
             self.deviceMotion       = tempDeviceMotion
             self.referenceFrame     = tempDeviceMotion.attitude
             let deviceQ             = tempDeviceMotion.attitude.quaternion
             self.motionQuaternion   = simd_quatf(ix: Float(deviceQ.x), iy: Float(deviceQ.y), iz: Float(deviceQ.z), r: Float(deviceQ.w))
         }
         */


         self.motionManager.startDeviceMotionUpdates(to: OperationQueue.main, withHandler: {
             myDeviceMotion, error in
             if let tempDeviceMotion     = myDeviceMotion {
                 self.deviceMotion       = tempDeviceMotion
                 self.referenceFrame     = tempDeviceMotion.attitude
                 let deviceQ             = tempDeviceMotion.attitude.quaternion
                 self.motionQuaternion   = simd_quatf(ix: Float(deviceQ.x), iy: Float(deviceQ.y), iz: Float(deviceQ.z), r: Float(deviceQ.w)).normalized
             }
             print("dviceMotion: \(String(describing: self.deviceMotion))")
         })

     }
 }




 */
