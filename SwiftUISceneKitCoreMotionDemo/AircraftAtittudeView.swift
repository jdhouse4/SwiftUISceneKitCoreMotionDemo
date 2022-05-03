//
//  AircraftAtittudeView.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 5/2/22.
//

import SwiftUI




struct AircraftAtittudeView: View {
    @Environment(\.horizontalSizeClass) var sizeClass

    @EnvironmentObject var aircraftState: AircraftState
    @EnvironmentObject var aircraftDelegate: AircraftSceneRendererDelegate

    let angleFont = Font
            .body
            .monospaced()
    

    var body: some View {
        Group {
            HStack {

                VStack (alignment: .leading) {
                    Text("Pitch: ")
                        .font(.body.monospaced())
                    
                    Text( "Yaw: ")
                        .font(.body.monospaced())
                    
                    Text("Roll: ")
                        .font(.body.monospaced())
                }
                .padding(5)
                
                
                VStack (alignment: .trailing) {
                    Text("\(self.radians2Degrees(aircraftDelegate.aircraftEulerAngles.x), specifier: "%.2f")°")
                        .font(angleFont)
                    
                    Text("\(self.radians2Degrees(aircraftDelegate.aircraftEulerAngles.y), specifier: "%.2f")°")
                        .font(angleFont)
                    
                    Text("\(self.radians2Degrees(aircraftDelegate.aircraftEulerAngles.z), specifier: "%.2f")°")
                        .font(angleFont)
                }
                .frame(width: 90, /*height: 60,*/ alignment: .trailing)
                //.background(Color.blue)
            }
        }
        .frame(alignment: .top)
        .foregroundColor(.white)
        .padding(EdgeInsets(top: 70, leading: 5, bottom: 5, trailing: 5))
    }
    
    
    
    func radians2Degrees(_ number: Float) -> Float {
        return number * 180.0 / .pi
    }
}




struct AircraftAtittudeView_Previews: PreviewProvider {
    static var previews: some View {
        AircraftAtittudeView()
    }
}
