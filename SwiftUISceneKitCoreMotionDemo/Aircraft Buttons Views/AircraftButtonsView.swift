//
//  AircraftButtonsView.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 7/13/21.
//

import SwiftUI




struct AircraftButtonsView: View {
    @EnvironmentObject var aircraft: AircraftSceneKitScene
    @EnvironmentObject var aircraftCameraButton: AircraftCameraButton
    @EnvironmentObject var aircraftAnalyticsButton: AircraftAnalyticsButton
    @EnvironmentObject var sunlightSwitch: AircraftSunlightButton



    var body: some View {

        ZStack {

            VStack {
                
                Spacer(minLength: 100)

                AircraftRCSButtonsView()
                    .padding(EdgeInsets(top: 5, leading: 5, bottom: aircraftAnalyticsButton.analyticsSwitch ? 205 : 70, trailing: 5))
                
            }
            //.background(Color.black.opacity(0.7))


            VStack {
                
                Spacer()
                
                GeometryReader { geometry in
                    
                    HStack (spacing: 5) {
                        
                        AircraftEngineThrottleSlider()
                        
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                    .padding(EdgeInsets(top: 10, leading: 135, bottom: 20, trailing: 5))
                    //.background(Color.cyan.opacity(0.95))
                }
                

                //Spacer(minLength: 50)
                
                /*HStack (spacing: 5) {
                    
                    Group {
                        
                        AircraftSunlightButtonView()
                        
                        Spacer()
                        
                        AircraftAnalyticsButtonView()
                        
                    }
                    .frame(alignment: .center)
                }*/
                //.padding(.bottom, aircraftAnalyticsButton.analyticsSwitch ? 140 : 5)
                //.background(Color.red.opacity(0.7))
            }
        }
    }
}




struct AircraftButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        AircraftButtonsView()
    }
}
