//
//  AircraftUserSettings.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 4/7/22.
//

import Foundation




///
/// These are for user settings so I don't have to use stringly typed text that is prone to failure.
///
/// - Remark: See (HWS+ Storing preferences efficiently)[https://www.hackingwithswift.com/plus/making-the-most-of-foundation/storing-preferences-efficiently]
///

enum AircraftUserSettings: String {
    case pfGyroOrientationControl

}




enum AircraftGroupSettings: String {
    case aircraftGroupSuiteName = "group.com.portablefrontier.swiftuiscenekitcoremotiondemo"
}
