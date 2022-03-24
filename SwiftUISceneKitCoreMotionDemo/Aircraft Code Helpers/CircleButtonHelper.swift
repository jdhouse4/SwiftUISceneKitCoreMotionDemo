//
//  CircleButtonHelper.swift
//  FourCornersUIWithSwiftUI
//
//  Created by James Hillhouse IV on 7/7/21.
//

import SwiftUI



struct CircleButtonHelper {

    //
    // Position Functions
    //
    // Compact
    //
    static func positionMainButtonCompact() -> (x: CGFloat, y:CGFloat) {
        return (x: CircleButtonSize.halfWidthHeightCompact.rawValue, y: CircleButtonSize.halfWidthHeightCompact.rawValue)
    }



    static func position0DegreeButtonCompact() -> (x: CGFloat, y:CGFloat) {
        return (x: CircleButtonSize.halfWidthHeightCompact.rawValue, y: CircleButtonSize.halfWidthHeightCompact.rawValue - CircleButtonSize.diameterWithRadialSpacingCompact.rawValue)
    }



    static func position60DegreeButtonCompact() -> (x: CGFloat, y:CGFloat) {
        return (x: CircleButtonSize.halfWidthHeightCompact.rawValue + ( CircleButtonSize.diameterWithRadialSpacingCompact.rawValue * cos( CGFloat( Double.pi / 6 ) ) ), y: CircleButtonSize.halfWidthHeightCompact.rawValue - ( CircleButtonSize.diameterWithRadialSpacingCompact.rawValue * sin( CGFloat( Double.pi / 6 ) ) ) )
    }



    static func position120DegreeButtonCompact() -> (x: CGFloat, y:CGFloat) {
        return (x: CircleButtonSize.halfWidthHeightCompact.rawValue + ( CircleButtonSize.diameterWithRadialSpacingCompact.rawValue * cos( CGFloat( Double.pi / 6 ) ) ), y: CircleButtonSize.halfWidthHeightCompact.rawValue + ( CircleButtonSize.diameterWithRadialSpacingCompact.rawValue * sin( CGFloat( Double.pi / 6 ) ) ) )
    }



    static func position180DegreeButtonCompact() -> (x: CGFloat, y:CGFloat) {
        return (x: CircleButtonSize.halfWidthHeightCompact.rawValue, y: CircleButtonSize.halfWidthHeightCompact.rawValue + CircleButtonSize.diameterWithRadialSpacingCompact.rawValue)
    }



    static func position240DegreeButtonCompact() -> (x: CGFloat, y:CGFloat) {
        return (x: CircleButtonSize.halfWidthHeightCompact.rawValue - ( CircleButtonSize.diameterWithRadialSpacingCompact.rawValue * cos( CGFloat( Double.pi / 6 ) ) ), y: CircleButtonSize.halfWidthHeightCompact.rawValue + ( CircleButtonSize.diameterWithRadialSpacingCompact.rawValue * sin( CGFloat( Double.pi / 6 ) ) ) )
    }



    static func position300DegreeButtonCompact() -> (x: CGFloat, y:CGFloat) {
        return (x: CircleButtonSize.halfWidthHeightCompact.rawValue - ( CircleButtonSize.diameterWithRadialSpacingCompact.rawValue * cos( CGFloat( Double.pi / 6 ) ) ), y: CircleButtonSize.halfWidthHeightCompact.rawValue - ( CircleButtonSize.diameterWithRadialSpacingCompact.rawValue * sin( CGFloat( Double.pi / 6 ) ) ) )
    }



    static func position60DegreeRisingButtonCompact() -> (x: CGFloat, y: CGFloat) {
        return (x: CircleButtonSize.halfWidthHeightCompact.rawValue + ( CircleButtonSize.diameterWithRadialSpacingCompact.rawValue * cos( CGFloat( Double.pi / 6 ) ) ), y: CircleButtonSize.centerButtonTopPositionCompact.rawValue - ( CircleButtonSize.diameterWithRadialSpacingCompact.rawValue * sin( CGFloat( Double.pi / 6 ) ) ) )
    }



    static func position180DegreeRisingButtonCompact() -> (x: CGFloat, y: CGFloat) {
        return (x: CircleButtonSize.halfWidthHeightCompact.rawValue, y: CircleButtonSize.centerButtonTopPositionCompact.rawValue + CircleButtonSize.diameterWithRadialSpacingCompact.rawValue)
    }



    static func position300DegreeRisingButtonCompact() -> (x: CGFloat, y: CGFloat) {
        return (x: CircleButtonSize.halfWidthHeightCompact.rawValue - ( CircleButtonSize.diameterWithRadialSpacingCompact.rawValue * cos( CGFloat( Double.pi / 6 ) ) ), y: CircleButtonSize.centerButtonTopPositionCompact.rawValue - ( CircleButtonSize.diameterWithRadialSpacingCompact.rawValue * sin( CGFloat( Double.pi / 6 ) ) ) )
    }




    //
    // Position Functions
    //
    // Standard
    //
    static func positionMainButton() -> (x: CGFloat, y:CGFloat) {
        return (x: CircleButtonSize.halfWidthHeight.rawValue, y: CircleButtonSize.halfWidthHeight.rawValue)
    }



    static func position0DegreeButton() -> (x: CGFloat, y:CGFloat) {
        return (x: CircleButtonSize.halfWidthHeight.rawValue, y: CircleButtonSize.halfWidthHeight.rawValue - CircleButtonSize.diameterWithRadialSpacing.rawValue)
    }



    static func position60DegreeButton() -> (x: CGFloat, y:CGFloat) {
        return (x: CircleButtonSize.halfWidthHeight.rawValue + ( CircleButtonSize.diameterWithRadialSpacing.rawValue * cos( CGFloat( Double.pi / 6 ) ) ), y: CircleButtonSize.halfWidthHeight.rawValue - ( CircleButtonSize.diameterWithRadialSpacing.rawValue * sin( CGFloat( Double.pi / 6 ) ) ) )
    }



    static func position120DegreeButton() -> (x: CGFloat, y:CGFloat) {
        return (x: CircleButtonSize.halfWidthHeight.rawValue + ( CircleButtonSize.diameterWithRadialSpacing.rawValue * cos( CGFloat( Double.pi / 6 ) ) ), y: CircleButtonSize.halfWidthHeight.rawValue + ( CircleButtonSize.diameterWithRadialSpacing.rawValue * sin( CGFloat( Double.pi / 6 ) ) ) )
    }



    static func position180DegreeButton() -> (x: CGFloat, y:CGFloat) {
        return (x: CircleButtonSize.halfWidthHeight.rawValue, y: CircleButtonSize.halfWidthHeight.rawValue + CircleButtonSize.diameterWithRadialSpacing.rawValue)
    }



    static func position240DegreeButton() -> (x: CGFloat, y:CGFloat) {
        return (x: CircleButtonSize.halfWidthHeight.rawValue - ( CircleButtonSize.diameterWithRadialSpacing.rawValue * cos( CGFloat( Double.pi / 6 ) ) ), y: CircleButtonSize.halfWidthHeight.rawValue + ( CircleButtonSize.diameterWithRadialSpacing.rawValue * sin( CGFloat( Double.pi / 6 ) ) ) )
    }



    static func position300DegreeButton() -> (x: CGFloat, y:CGFloat) {
        return (x: CircleButtonSize.halfWidthHeight.rawValue - ( CircleButtonSize.diameterWithRadialSpacing.rawValue * cos( CGFloat( Double.pi / 6 ) ) ), y: CircleButtonSize.halfWidthHeight.rawValue - ( CircleButtonSize.diameterWithRadialSpacing.rawValue * sin( CGFloat( Double.pi / 6 ) ) ) )
    }




    //
    // Transition Functions
    //
    // Compact
    //
    static func transition0DegreeButtonCompact() -> AnyTransition {
        let insertion   = AnyTransition.offset(x: 0, y: CircleButtonSize.diameterWithRadialSpacingCompact.rawValue)
            .combined(with: .opacity)

        let removal     = AnyTransition.opacity
            .combined(with: .offset(x: 0, y: CircleButtonSize.diameterWithRadialSpacingCompact.rawValue))

        return AnyTransition.asymmetric(insertion: insertion, removal: removal)
    }



    static func transition60DegreeButtonCompact() -> AnyTransition {
        let insertion   = AnyTransition.offset(x: -( CircleButtonSize.diameterWithRadialSpacingCompact.rawValue * CGFloat( cos( Double.pi / 6.0 ) ) ), y: CircleButtonSize.diameterWithRadialSpacingCompact.rawValue  * CGFloat( sin( Double.pi / 6.0 ) ) )
            .combined(with: .opacity)

        let removal     = AnyTransition.offset(x: -( CircleButtonSize.diameterWithRadialSpacingCompact.rawValue * CGFloat( cos( Double.pi / 6.0 ) ) ), y: CircleButtonSize.diameterWithRadialSpacingCompact.rawValue * CGFloat( sin( Double.pi / 6.0 ) ) )
            .combined(with: .opacity)

        return AnyTransition.asymmetric(insertion: insertion, removal: removal)
    }



    static func transition120DegreeButtonCompact() -> AnyTransition {
        let insertion   = AnyTransition.offset(x: -( CircleButtonSize.diameterWithRadialSpacingCompact.rawValue * CGFloat( cos( Double.pi / 6.0) ) ), y: -CircleButtonSize.diameterWithRadialSpacingCompact.rawValue * CGFloat( sin( Double.pi / 6.0 ) ) )
            .combined(with: .opacity)

        let removal     = AnyTransition.offset(x: -( CircleButtonSize.diameterWithRadialSpacingCompact.rawValue * CGFloat( cos( Double.pi / 6.0) ) ), y: -CircleButtonSize.diameterWithRadialSpacingCompact.rawValue * CGFloat( sin( Double.pi / 6.0 ) ) )
            .combined(with: .opacity)

        return AnyTransition.asymmetric(insertion: insertion, removal: removal)
    }



    static func transition180DegreeButtonCompact() -> AnyTransition {
        let insertion   = AnyTransition.offset(x: 0, y: -CircleButtonSize.diameterWithRadialSpacingCompact.rawValue)
            .combined(with: .opacity)

        let removal     = AnyTransition.offset(x: 0, y: -CircleButtonSize.diameterWithRadialSpacingCompact.rawValue)
            .combined(with: .opacity)

        return AnyTransition.asymmetric(insertion: insertion, removal: removal)
    }



    static func transition240DegreeButtonCompact() -> AnyTransition {
        let insertion   = AnyTransition.offset(x: CircleButtonSize.diameterWithRadialSpacingCompact.rawValue * CGFloat( cos( Double.pi / 6.0 ) ), y: -CircleButtonSize.diameterWithRadialSpacingCompact.rawValue * CGFloat( sin( Double.pi / 6.0 ) ) )
            .combined(with: .opacity)

        let removal     = AnyTransition.offset(x: CircleButtonSize.diameterWithRadialSpacingCompact.rawValue * CGFloat( cos( Double.pi / 6.0 ) ), y: -CircleButtonSize.diameterWithRadialSpacingCompact.rawValue * CGFloat( sin( Double.pi / 6.0 ) ) )
            .combined(with: .opacity)

        return AnyTransition.asymmetric(insertion: insertion, removal: removal)
    }



    static func transition300DegreeButtonCompact() -> AnyTransition {
        let insertion   = AnyTransition.offset(x: CircleButtonSize.diameterWithRadialSpacingCompact.rawValue * CGFloat( cos( Double.pi / 6.0 ) ), y: CircleButtonSize.diameterWithRadialSpacingCompact.rawValue * CGFloat( sin( Double.pi / 6.0 ) ) )
            .combined(with: .opacity)

        let removal     = AnyTransition.offset(x: CircleButtonSize.diameterWithRadialSpacingCompact.rawValue * CGFloat( cos( Double.pi / 6.0 ) ), y: CircleButtonSize.diameterWithRadialSpacingCompact.rawValue * CGFloat( sin( Double.pi / 6.0 ) ) )
            .combined(with: .opacity)

        return AnyTransition.asymmetric(insertion: insertion, removal: removal)
    }




    //
    // Transition Functions
    //
    // Standard
    //
    static func transition0DegreeButton() -> AnyTransition {
        let insertion   = AnyTransition.offset(x: 0, y: CircleButtonSize.diameterWithRadialSpacing.rawValue)
            .combined(with: .opacity)

        let removal     = AnyTransition.offset(x: 0, y: CircleButtonSize.diameterWithSpacing.rawValue)
            .combined(with: .opacity)

        return AnyTransition.asymmetric(insertion: insertion, removal: removal)
    }



    static func transition60DegreeButton() -> AnyTransition {
        let insertion   = AnyTransition.offset(x: -( CircleButtonSize.diameterWithRadialSpacing.rawValue * CGFloat( cos( Double.pi / 6.0 ) ) ), y: ( CircleButtonSize.diameterWithRadialSpacing.rawValue * CGFloat( sin( Double.pi / 6.0 ) ) ) )
            .combined(with: .opacity)

        let removal     = AnyTransition.offset(x: -( CircleButtonSize.diameterWithRadialSpacing.rawValue * CGFloat( cos( Double.pi / 6.0 ) ) ), y: ( CircleButtonSize.diameterWithRadialSpacing.rawValue * CGFloat( sin( Double.pi / 6.0 ) ) ) )
            .combined(with: .opacity)

        return AnyTransition.asymmetric(insertion: insertion, removal: removal)
    }



    static func transition120DegreeButton() -> AnyTransition {
        let insertion   = AnyTransition.offset(x: -( CircleButtonSize.diameterWithRadialSpacing.rawValue * CGFloat( cos( Double.pi / 6.0 ) ) ), y: -( CircleButtonSize.diameterWithRadialSpacing.rawValue * CGFloat(sin( Double.pi / 6.0 ) ) ) )
            .combined(with: .opacity)

        let removal     = AnyTransition.offset(x: -( CircleButtonSize.diameterWithRadialSpacing.rawValue * CGFloat( cos( Double.pi / 6.0 ) ) ), y: -( CircleButtonSize.diameterWithRadialSpacing.rawValue * CGFloat(sin( Double.pi / 6.0 ) ) ) )
            .combined(with: .opacity)

        return AnyTransition.asymmetric(insertion: insertion, removal: removal)
    }



    static func transition180DegreeButton() -> AnyTransition {
        let insertion   = AnyTransition.offset(x: 0, y: -CircleButtonSize.diameterWithRadialSpacing.rawValue)
            .combined(with: .opacity)

        let removal     = AnyTransition.offset(x: 0, y: -CircleButtonSize.diameterWithRadialSpacing.rawValue)
            .combined(with: .opacity)

        return AnyTransition.asymmetric(insertion: insertion, removal: removal)
    }



    static func transition240DegreeButton() -> AnyTransition {
        let insertion   = AnyTransition.offset(x: ( CircleButtonSize.diameterWithRadialSpacing.rawValue * CGFloat( cos( Double.pi / 6.0 ) ) ), y: -( CircleButtonSize.diameterWithRadialSpacing.rawValue * CGFloat( sin( Double.pi / 6.0 ) ) ) )
            .combined(with: .opacity)

        let removal     = AnyTransition.offset(x: ( CircleButtonSize.diameterWithRadialSpacing.rawValue * CGFloat( cos( Double.pi / 6.0 ) ) ), y: -( CircleButtonSize.diameterWithRadialSpacing.rawValue * CGFloat( sin( Double.pi / 6.0 ) ) ) )
            .combined(with: .opacity)

        return AnyTransition.asymmetric(insertion: insertion, removal: removal)
    }



    static func transition300DegreeButton() -> AnyTransition {
        let insertion   = AnyTransition.offset(x: ( CircleButtonSize.diameterWithRadialSpacing.rawValue * CGFloat( cos( Double.pi / 6.0 ) ) ), y: ( CircleButtonSize.diameterWithRadialSpacing.rawValue * CGFloat( sin( Double.pi / 6.0 ) ) ) )
            .combined(with: .opacity)

        let removal     = AnyTransition.offset(x: ( CircleButtonSize.diameterWithRadialSpacing.rawValue * CGFloat( cos( Double.pi / 6.0 ) ) ), y: ( CircleButtonSize.diameterWithRadialSpacing.rawValue * CGFloat( sin( Double.pi / 6.0 ) ) ) )
            .combined(with: .opacity)

        return AnyTransition.asymmetric(insertion: insertion, removal: removal)
    }

}
