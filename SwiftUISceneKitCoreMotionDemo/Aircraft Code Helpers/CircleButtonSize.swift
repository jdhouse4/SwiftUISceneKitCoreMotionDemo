//
//  CircleButton.swift
//  FourCornersUIWithSwiftUI
//
//  Created by James Hillhouse IV on 4/30/21.
//
import SwiftUI
import CoreGraphics




struct CircleButtonFlexible: ButtonStyle {
    @Environment(\.horizontalSizeClass) var sizeClass

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: sizeClass == .compact ? CircleButtonSize.diameterCompact.rawValue : CircleButtonSize.diameter.rawValue,
                   height: sizeClass == .compact ? CircleButtonSize.diameterCompact.rawValue : CircleButtonSize.diameter.rawValue)
            //.padding()
            //.background(Color.secondary)
            //.foregroundColor(Color.white)
    }
}




enum CircleButtonSize: CGFloat {
    // Regular Screen
    case center                             = 90
    case diameter                           = 60
    case diameterWithSpacing                = 62
    case diameterWithRadialSpacing          = 64
    case radius                             = 30
    case radiusWithSpacing                  = 32
    case radiusWithRadialSpacing            = 34
    case cornerRadius                       = 28
    case spacer                             = 2
    case radialSpacer                       = 4

    // Compact Screen
    case diameterCompact                    = 50
    case diameterWithSpacingCompact         = 52
    case diameterWithRadialSpacingCompact   = 54
    case radiusCompact                      = 25
    case radiusWithSpacingCompact           = 27
    case spacerCompact                      = 1
    case radiusWithRadialSpacingCompact     = 29

    // Colors
    case primaryOpacity                     = 0.5
    case secondaryOpacity                   = 0.3

    // Animation Speed
    case animationDebug                     = 1.5
    case animationSlow                      = 0.4
    case animationFast                      = 0.25

    // Regular Screen
    case extendedHeight                     = 250
    case widthHeight                        = 200
    case halfWidthHeight                    = 100
    case buttonBottonPosition               = 170

    // Compact Screen
    case extendedHeightCompact              = 190
    case innerExtendedHeightCompact         = 95
    case widthHeightCompact                 = 160
    case halfWidthHeightCompact             = 80
    case quarterExtendedHeightCompact       = 85
    case centerButtonTopPositionCompact     = -20 //53
    case centerButtonBottomPositionCompact  = 155 //165
}



enum CircleButtonView: CGFloat {
    // Regular Screen
    case extendedHeight                     = 250
    case widthHeight                        = 200
    case halfWidthHeight                    = 100
    case buttonBottonPosition               = 170

    // Compact Screen
    case extendedHeightCompact              = 190
    case innerExtendedHeightCompact         = 95
    case widthHeightCompact                 = 160
    case halfWidthHeightCompact             = 80
    case quarterExtendedHeightCompact       = 85
    case centerButtonTopPositionCompact     = 53
    case centerButtonBottomPositionCompact  = 165
}





/*
 Thanks go to:

 jackxujh (https://stackoverflow.com/a/49192862/1518544)
 Ole Begemann (https://oleb.net/blog/2016/11/rawrepresentable/)

 for this hack.
 */
enum CircleButtonColor {
    case background
    case main
    case selected
    case onWithBackground
    case offWithBackground
    case mainWithoutBackground
    case onWithoutBackground
    case offWithoutBackground
}




extension CircleButtonColor: RawRepresentable {
    typealias RawValue = Color

    init?(rawValue: RawValue) {
        switch rawValue {
            case Color(#colorLiteral(red: 0.75, green: 0.75, blue: 0.75, alpha: 0.5)):
                self = .background
            case Color(#colorLiteral(red: 0.98, green: 0.98, blue: 0.98, alpha: 0.7)):
                self = .main
            case Color(#colorLiteral(red: 0.75, green: 0.75, blue: 0.75, alpha: 0.6024553571)):
                self = .selected
            case Color(#colorLiteral(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.7)):
                self = .onWithBackground
            case Color(#colorLiteral(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.6)):
                self = .offWithBackground
            case Color(#colorLiteral(red: 0.98, green: 0.98, blue: 0.98, alpha: 0.85)):
                self = .mainWithoutBackground
            case Color(#colorLiteral(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.85)):
                self = .onWithoutBackground
            case Color(#colorLiteral(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.75)):
                self = .offWithoutBackground
            default:
                return nil
        }
    }


    var rawValue: RawValue {
        switch self {
            case .background:
                return Color(#colorLiteral(red: 0.75, green: 0.75, blue: 0.75, alpha: 0.5))
            case .main:
                return Color(#colorLiteral(red: 0.98, green: 0.98, blue: 0.98, alpha: 0.8))
            case .selected:
                return Color(#colorLiteral(red: 0.95, green: 0.95, blue: 0.95, alpha: 0.6))
            case .onWithBackground:
                return Color(#colorLiteral(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.7))
            case .offWithBackground:
                return Color(#colorLiteral(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.6))
            case .mainWithoutBackground:
                return Color(#colorLiteral(red: 0.98, green: 0.98, blue: 0.98, alpha: 0.85))
            case .onWithoutBackground:
                return Color(#colorLiteral(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.85))
            case .offWithoutBackground:
                return Color(#colorLiteral(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.75))
        }
    }
}
