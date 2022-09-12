//
//  NumericEntryController.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 5/13/22.
//

import Swift
import Foundation



///
/// This comes from Daren over at [Programming With Swift](https://programmingwithswift.com)
/// in his post, "[Numbers only TextField with Swift](https://programmingwithswift.com/numbers-only-textfield-with-swiftui/)"
///




final class NumericEntryController: ObservableObject {
    @Published var numbericEntry = "" {
        didSet {
            let filtered = numbericEntry.filter { $0.isNumber }
            
            if numbericEntry != filtered {
                numbericEntry = filtered
            }
        }
    }
}
