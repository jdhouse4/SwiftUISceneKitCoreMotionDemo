//
//  AircraftSettingsButtonView.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 7/12/21.
//

import SwiftUI




struct AircraftSettingsButtonView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @EnvironmentObject var aircraftSettingsButton: AircraftSettingsButton
    @EnvironmentObject var aircraftCloudUserDefaults: AircraftCloudUserDefaults
    //@EnvironmentObject var aircraftDelegate: AircraftSceneRendererDelegate
    
    @State private var gyro: Bool       = true
    @State private var touches: Bool    = false
    @State private var sunlight: Bool   = true
    
    
    var body: some View {
        
        HStack {
            
            ZStack {
                //
                // Button to show settings.
                //
                Button( action: {
                    withAnimation {
                        self.aircraftSettingsButton.showSettingsButtons.toggle()
                    }
                    
                    print("aircraftCloudUserDefaults.gyroOrientationControl : \(self.aircraftCloudUserDefaults.gyroOrientationControl)")
                    
                    //aircraftDelegate.showsStatistics.toggle()
                    
                }) {
                    Image(systemName: aircraftSettingsButton.settingsSwitch ? "gearshape.fill" : "gearshape")
                        .imageScale(.large)
                        .accessibility(label: Text("Settings"))
                }
                .zIndex(3)
                .frame(
                    width: sizeClass == .compact ? CircleButtonSize.diameterCompact.rawValue : CircleButtonSize.diameter.rawValue,
                    height: sizeClass == .compact ? CircleButtonSize.diameterCompact.rawValue : CircleButtonSize.diameter.rawValue)
                .background(aircraftSettingsButton.settingsSwitch ? CircleButtonColor.onWithBackground.rawValue : CircleButtonColor.offWithBackground.rawValue)
                .clipShape(Circle())
                .background(Circle().stroke(Color.blue, lineWidth: 1))
                
                
                if aircraftSettingsButton.showSettingsButtons {
                    
                    Group {
                        
                        Button(action: {
                            
                            //self.gyro       = true
                            //self.touches    = false
                            
                            self.aircraftSettingsButton.gyroButtonPressed.toggle()
                            print("The settings button pressed is \(aircraftSettingsButton.gyroButtonPressed).")
                            
                            self.aircraftCloudUserDefaults.gyroOrientationControl = true
                            //print("function: \(#function), line: \(#line)– aircraftCloudUserDefaults.gyroOrientationControl : \(self.aircraftCloudUserDefaults.gyroOrientationControl)")
                             
                            //print("function: \(#function), line: \(#line)– pfGyroOrientationControl : \(String(describing: UserDefaults.standard.object(forKey: AircraftUserSettings.pfGyroOrientationControl.rawValue)))")

                        }) {
                            Image(systemName: "gyroscope")
                                .imageScale(.large)
                                .opacity(self.aircraftCloudUserDefaults.gyroOrientationControl == true ? 1.0 : 0.4)
                                .accessibility(label: Text("Use device motion."))
                        }
                        .zIndex(2)
                        .frame(
                            width: sizeClass == .compact ? CircleButtonSize.diameterCompact.rawValue : CircleButtonSize.diameter.rawValue,
                            height: sizeClass == .compact ? CircleButtonSize.diameterCompact.rawValue : CircleButtonSize.diameter.rawValue,
                            alignment: .center)
                        .background(CircleButtonColor.offWithoutBackground.rawValue)
                        .clipShape(Circle())
                        .background(Circle().stroke(Color.blue, lineWidth: 1))
                        .transition(moveAndFadeLeft(buttonIndex: 1))
                        .offset(
                            x: sizeClass == .compact ? -( CircleButtonSize.diameterWithRadialSpacingCompact.rawValue ) : -( CircleButtonSize.diameterWithRadialSpacing.rawValue ),
                            y: 0)
                        
                        
                        
                        // Settings button
                        Button(action: {
                            
                            self.aircraftSettingsButton.touchesButtonPressed.toggle()
                            //print("The settings button pressed is \(aircraftSettingsButton.touchesButtonPressed) in \(#file) \(#function)")
                            
                            
                            self.aircraftCloudUserDefaults.gyroOrientationControl = false
                            print("function: \(#function), line: \(#line)– aircraftCloudUserDefaults.gyroOrientationControl : \(self.aircraftCloudUserDefaults.gyroOrientationControl)")
                            
                            print("function: \(#function), line: \(#line)– pfGyroOrientationControl : \(String(describing: UserDefaults.standard.object(forKey: AircraftUserSettings.pfGyroOrientationControl.rawValue)))")


                        }) {
                            Image(systemName: "hand.point.up.left")
                                .imageScale(.large)
                                .opacity(self.aircraftCloudUserDefaults.gyroOrientationControl == false ? 1.0 : 0.4)
                                .accessibility(label: Text("Use touches on screen."))
                        }
                        .zIndex(1)
                        .frame(
                            width: sizeClass == .compact ? CircleButtonSize.diameterCompact.rawValue : CircleButtonSize.diameter.rawValue,
                            height: sizeClass == .compact ? CircleButtonSize.diameterCompact.rawValue : CircleButtonSize.diameter.rawValue,
                            alignment: .center)
                        .background(CircleButtonColor.offWithoutBackground.rawValue)
                        .clipShape(Circle())
                        .background(Circle().stroke(Color.blue, lineWidth: 1))
                        .transition(moveAndFadeLeft(buttonIndex: 2))
                        .offset(
                            x: sizeClass == .compact ? -( CircleButtonSize.diameterWithRadialSpacingCompact.rawValue * 2 ) : -( CircleButtonSize.diameterWithRadialSpacing.rawValue * 2 ),
                            y: 0)
                        
                    }
                }
            }
            .padding(.init(top: 5, leading: 5, bottom: 5, trailing: 5))
        }
    }
    
    
    
    /*
     Note:
     
     I chose not to remove this function from the camera buttons view since they are only called here in this
     function. Were there calls to these functions elsewhere in the code, I wuold have moved these two functions
     to AircraftHelpers.swift
     */
    func moveAndFadeLeft(buttonIndex: Int) -> AnyTransition {
        let insertion   = AnyTransition.offset(
            x: sizeClass == .compact ? CircleButtonSize.diameterCompact.rawValue * CGFloat(buttonIndex) : CircleButtonSize.diameter.rawValue * CGFloat(buttonIndex),
            y: 0)
        //.combined(with: .opacity)
        
        let removal     = AnyTransition.offset(
            x: sizeClass == .compact ? CircleButtonSize.diameterCompact.rawValue * CGFloat(buttonIndex) : CircleButtonSize.diameter.rawValue * CGFloat(buttonIndex),
            y: 0)
            .combined(with: .opacity)
        
        return AnyTransition.asymmetric(insertion: insertion, removal: removal)
    }
}





struct AircraftSettingsButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AircraftSettingsButtonView().environmentObject(AircraftSettingsButton())
    }
}
