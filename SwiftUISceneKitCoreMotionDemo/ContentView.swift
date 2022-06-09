//
//  ContentView.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 10/18/20.
//

import SwiftUI
import SceneKit



/*
extension UserDefaults {
    static var shared: UserDefaults {
        guard let defaults = UserDefaults(suiteName: AircraftGroupSettings.aircraftGroupSuiteName.rawValue) else {
            
            print("Oops, no group user settings")
            
            fatalError("Missing app group!")
            //return UserDefaults.standard
        }
        
        return defaults
    }
}
*/


struct ContentView: View {


    //
    // @StateObject is a property wrapper type that instantiates an object conforming to ObservableObject.
    //
    @StateObject var aircraft                   = AircraftSceneKitScene.shared
    @StateObject var aircraftDelegate           = AircraftSceneRendererDelegate()
    @StateObject var aircraftState              = AircraftState.shared
    @StateObject var aircraftSunlightButton     = AircraftSunlightButton()
    @StateObject var aircraftCameraButton       = AircraftCameraButton()
    @StateObject var aircraftSettingsButton     = AircraftSettingsButton()
    @StateObject var aircraftAnalyticsButton    = AircraftAnalyticsButton()
    @StateObject var aircraftEngineThrottle     = AircraftEngineThrottle()
    @StateObject var aircraftRotationButton     = AircraftRCSButtons()
    
    @State var showOrientationSheet: Bool       = false


    var body: some View {

        ZStack {

            AircraftSceneView()
                //.overlay(Circle().opacity(0.5))
            
            /*
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.white)
                .frame(width: 250, height: 250)
                .offset(x: 0, y: -100)
                .opacity(0.4)
            
            
            Circle()
                .fill(.gray)
                .frame(width: 225, height: 225)
                .offset(x: 0, y: -100)
                .opacity(0.4)
            */
            
            AircraftEngineAndRCSControlsView()
            

            VStack {
                
                TopRowButtonsView()
                
                Spacer()
                
                BottomRowButtonsView()
                
            }
            //.background(Color.white.opacity(0.75))
            
            
            VStack {
                
                AircraftAtittudeView()
                    .padding(10)
                
                
                Button {
                    
                    showOrientationSheet.toggle()
                    
                } label: {
                    
                    Image(systemName: "keyboard")
                        .imageScale(.large)
                }
                .frame(alignment: .leading)
                .sheet(isPresented: $showOrientationSheet) {
                    AircraftOrientationControlView()
                }
                
                Spacer()

            }
            //.background(Color.blue)

        }
        .background(Color.black)
        .statusBar(hidden: true)

        .environmentObject(aircraft)
        .environmentObject(aircraftDelegate)
        .environmentObject(aircraftState)
        .environmentObject(aircraftSunlightButton)
        .environmentObject(aircraftCameraButton)
        .environmentObject(aircraftAnalyticsButton)
        .environmentObject(aircraftSettingsButton)
        .environmentObject(aircraftEngineThrottle)
        .environmentObject(aircraftRotationButton)
    }
    
    
    
    func loadSettings() {
        let defaults = UserDefaults.standard
        defaults.addSuite(named: AircraftGroupSettings.aircraftGroupSuiteName.rawValue)
        defaults.register(defaults: [AircraftUserSettings.pfGyroOrientationControl.rawValue: "true"])
        //UserDefaults.shared.set(true, forKey: AircraftUserSettings.pfGyroOrientationControl.rawValue)
    }
}



/*
 struct ContentView_Previews: PreviewProvider {
 static var previews: some View {
 ContentView()
 }
 }
 */
