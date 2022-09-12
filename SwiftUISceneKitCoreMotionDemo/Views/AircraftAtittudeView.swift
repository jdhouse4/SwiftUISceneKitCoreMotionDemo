//
//  AircraftAtittudeView.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 5/2/22.
//

import SwiftUI




struct AircraftAtittudeView: View {
    //@Environment(\.horizontalSizeClass) var sizeClass

    @EnvironmentObject var aircraftState: AircraftState
    @EnvironmentObject var aircraftDelegate: AircraftSceneRendererDelegate

    let angleFont = Font
            .body
            .monospaced()
    

    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.white)
                .frame(width: 350, height: 70)
                .opacity(0.4)
                //.background(.orange)
             
            
            Group {
                HStack(spacing: 0) {
                    
                    VStack (alignment: .leading) {
                        Text("Pitch: ")
                            .font(.body.monospaced())
                        
                        Text( "Yaw: ")
                            .font(.body.monospaced())
                        
                        Text("Roll: ")
                            .font(.body.monospaced())
                    }
                    //.foregroundColor(.accentColor)
                    //.background(Color.cyan)
                    
                    
                    VStack (alignment: .trailing) {
                        Text("\(self.radians2Degrees(aircraftDelegate.aircraftEulerAngles.x) >= 0.0 ? self.radians2Degrees(aircraftDelegate.aircraftEulerAngles.x) : -self.radians2Degrees(aircraftDelegate.aircraftEulerAngles.x), specifier: "%.2f")°")
                            .font(angleFont)
                        
                        Text("\(self.radians2Degrees(aircraftDelegate.aircraftEulerAngles.y) >= 0.0 ? self.radians2Degrees(aircraftDelegate.aircraftEulerAngles.y) : -self.radians2Degrees(aircraftDelegate.aircraftEulerAngles.y), specifier: "%.2f")°")
                            .font(angleFont)
                        
                        
                        Text("\(self.radians2Degrees(aircraftDelegate.aircraftEulerAngles.z) >= 0.0 ? self.radians2Degrees(aircraftDelegate.aircraftEulerAngles.z) : -self.radians2Degrees(aircraftDelegate.aircraftEulerAngles.z), specifier: "%.2f")°")
                            .font(angleFont)
                        
                    }
                    .frame(width: 100, alignment: .trailing)
                    //.background(Color.red)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
                    
                    VStack {
                        Text("∆: ")
                            .font(.body.monospaced())
                        
                        Text( "∆: ")
                            .font(.body.monospaced())
                        
                        Text("∆: ")
                            .font(.body.monospaced())
                        
                    }
                    //.background(Color.yellow)
                    //.padding(5)
                    
                    VStack (alignment: .trailing) {
                        Text("0.0°/s")
                            .font(angleFont)
                        
                        Text("0.0°/s")
                            .font(angleFont)
                        
                        Text("\(aircraftDelegate.deltaRollRate, specifier: "%.1f")°/s")
                            .font(angleFont)
                    }
                    
                    .frame(width: 100, /*height: 60,*/ alignment: .trailing)
                    //.background(Color.blue)
                    
                }
            }
            .frame(alignment: .top)
            //.foregroundColor(Color.init(red: 0.3, green: 0.3, blue: 0.3))
            .foregroundColor(.accentColor)
            //.background(.blue)
        }
        //.frame(width: 350, height: 80)
        .padding(EdgeInsets(top: 70, leading: 5, bottom: 5, trailing: 5))
        //.background(Color.red)
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
