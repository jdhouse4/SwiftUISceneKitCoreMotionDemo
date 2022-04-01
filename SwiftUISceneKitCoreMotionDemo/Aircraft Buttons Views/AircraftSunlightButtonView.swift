//
//  AircraftSunlightButtonView.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 7/12/21.
//

import SwiftUI




struct AircraftSunlightButtonView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @EnvironmentObject var sunlightSwitch: AircraftSunlightButton
    @EnvironmentObject var aircraft: AircraftSceneKitScene


    var body: some View {

        //
        // Button for toggling the sunlight.
        //
        
        Button( action: {
            withAnimation{
                sunlightSwitch.sunlight.toggle()
            }

            toggleSunlight()

        }) {
            Image(systemName: sunlightSwitch.sunlight ? "lightbulb.fill" : "lightbulb")
                .imageScale(.large)
                .accessibility(label: Text("Light Switch"))
        }
        //.frame(width: CircleButtonSize.diameter.rawValue, height: CircleButtonSize.diameter.rawValue)
        .frame(width: sizeClass == .compact ? CircleButtonSize.diameterCompact.rawValue : CircleButtonSize.diameter.rawValue,
               height: sizeClass == .compact ? CircleButtonSize.diameterCompact.rawValue : CircleButtonSize.diameter.rawValue)
        .background(sunlightSwitch.sunlight ? CircleButtonColor.onWithBackground.rawValue : CircleButtonColor.offWithBackground.rawValue)
        .clipShape(Circle())
        .background(Circle().stroke(Color.blue, lineWidth: 1))
        .padding()
    }
        
        
        
        
        



    func toggleSunlight() -> Void {
        let sunlight = aircraft.aircraftScene.rootNode.childNode(withName: "sunlightNode", recursively: true)?.light

        if self.sunlightSwitch.sunlight == true {
            sunlight!.intensity = 2000.0
        } else {
            sunlight!.intensity = 0.0
        }
    }
}




struct AircraftSunlightButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AircraftSunlightButtonView().environmentObject(AircraftCameraButton())
    }
}
