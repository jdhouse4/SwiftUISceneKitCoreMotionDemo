//
//  CircleButton.swift
//  FourCornersUIWithSwiftUI
//
//  Created by James Hillhouse IV on 4/30/21.
//
import SwiftUI
import CoreGraphics




enum CircleButton: CGFloat {
    case diameter       = 60
    case spacer         = 4
}





/*
 Thanks go to:

 jackxujh (https://stackoverflow.com/a/49192862/1518544)
 Ole Begemann (https://oleb.net/blog/2016/11/rawrepresentable/)

 for this hack.
 */
enum CircleButtonColor {
    case background
    case selected
    case on
    case off
}




extension CircleButtonColor: RawRepresentable {
    typealias RawValue = Color

    init?(rawValue: RawValue) {
        switch rawValue {
            case Color(#colorLiteral(red: 0.75, green: 0.75, blue: 0.75, alpha: 0.4)):
                self = .background
            case Color(#colorLiteral(red: 1, green: 0.576471, blue: 0, alpha: 0.8)):
                self = .selected
            case Color(#colorLiteral(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.6)):
                self = .on
            case Color(#colorLiteral(red: 0.75, green: 0.75, blue: 0.75, alpha: 0.4)):
                self = .off
            default:
                return nil
        }
    }


    var rawValue: RawValue {
        switch self {
            case .background:
                return Color(#colorLiteral(red: 0.75, green: 0.75, blue: 0.75, alpha: 0.4))
            case .selected:
                return Color(#colorLiteral(red: 1, green: 0.576471, blue: 0, alpha: 0.8))
            case .on:
                return Color(#colorLiteral(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.6))
            case .off:
                return Color(#colorLiteral(red: 0.75, green: 0.75, blue: 0.75, alpha: 0.4))
        }
    }
}
