//
//  AircraftOrientationControlView.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 5/13/22.
//

import SwiftUI




struct AircraftOrientationControlView: View {
    @Environment(\.dismiss) var dismiss
    
    //@ObservedObject var input   = NumericEntryController()
    @EnvironmentObject var aircraftState: AircraftState
    
    @State private var decimalEntry: Float = 0.0
    @FocusState private var entryIsFocused: Bool
    
    let decimalFormatter: NumberFormatter = {
        let formatter           = NumberFormatter()
        formatter.numberStyle   = .decimal
        return formatter
    }()
    
    
    var body: some View {
        TextField("", value: $decimalEntry, formatter: decimalFormatter)
            .focused($entryIsFocused)
            .textFieldStyle(.roundedBorder)
            .foregroundColor(Color.white)
            .padding()
            .keyboardType(.decimalPad)
            .onSubmit {
                print("\(#function) TextField .onSubmit just entered \(decimalEntry)")
            }
        
        
        Button("Dismiss") {
            print("\(#function) just entered \(decimalEntry)")
            
            entryIsFocused = false
            
            print("Let's square things: \(multiply(decimalEntry, amount: decimalEntry))")
            
            print("G'day!")

            dismiss()
        }
        
    }
    
    
    
    func multiply(_ input: Float, amount: Float) -> Float {
        let newNumber = input * amount
        
        return newNumber
    }
    
}




struct AircraftOrientationControlView_Previews: PreviewProvider {
    static var previews: some View {
        AircraftOrientationControlView()
    }
}
