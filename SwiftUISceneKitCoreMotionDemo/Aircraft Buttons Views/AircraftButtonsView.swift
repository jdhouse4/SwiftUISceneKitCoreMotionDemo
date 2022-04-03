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
                    //.frame(alignment: .bottom)
                    //.padding(.top, aircraftAnalyticsButton.analyticsSwitch ? 210 : 350)
                    //.padding(.bottom, aircraftAnalyticsButton.analyticsSwitch ? 240 : 100)
                    .padding(EdgeInsets(top: 5, leading: 5, bottom: aircraftAnalyticsButton.analyticsSwitch ? 205 : 70, trailing: 5))
                
                //Spacer(minLength: 50)
            }
            //.background(Color.black.opacity(0.7))


            VStack {
                
                //Spacer(minLength: 200)
                Spacer()
                
                GeometryReader { geometry in
                    
                    HStack (spacing: 5) {
                        
                        
                        //Spacer()
                        
                        AircraftEngineThrottleSlider()
                        
                    }
                    /*.frame(width: geometry.size.width, height: aircraftAnalyticsButton.analyticsSwitch ? geometry.size.height - 140 - 100 : geometry.size.height - 50, alignment: .trailing)
                     */
                    .frame(width: geometry.size.width, height: geometry.size.height - 50/*, alignment: .trailing*/)
                    //.padding(.bottom, 150)
                    //.padding(EdgeInsets(top: 00, leading: 5, bottom: 20, trailing: 5))
                    .padding(EdgeInsets(top: 10, leading: 135, bottom: 20, trailing: 5))
                    //.background(Color.cyan.opacity(0.95))
                }
                

                //Spacer(minLength: 50)
                
                HStack (spacing: 5) {
                    
                    Group {
                        
                        AircraftSunlightButtonView()
                        
                        AircraftCameraButtonsView()
                        
                        AircraftAnalyticsButtonView()
                        
                    }
                    .frame(alignment: .center)
                }
                .padding(.bottom, aircraftAnalyticsButton.analyticsSwitch ? 140 : 5)
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
