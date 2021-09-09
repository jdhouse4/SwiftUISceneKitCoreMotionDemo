//
//  AircraftAnimationHelpers.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 7/13/21.
//

import SwiftUI




extension Animation {
    static func ripple(buttonIndex: Int) -> Animation {
        Animation.spring(dampingFraction: 0.5)
            .speed(1.2)
            .delay(0.05 * Double(buttonIndex))
    }
}




extension AnyTransition {
    static var leftButtonsMoveAndFadeTransition: AnyTransition {
        let insertion   = AnyTransition.move(edge: .leading)
            .combined(with: .opacity)

        let removal     = AnyTransition.offset(x: -200, y: 0)
            .combined(with: .opacity)

        return asymmetric(insertion: insertion, removal: removal)
    }
}


