//
//  ContentView.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 10/18/20.
//

import SwiftUI
import SceneKit




struct ContentView: View {

    var body: some View {
        
        AircraftView()
            .statusBar(hidden: true)

        /*ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            AircraftSceneView()

            VStack() {
                Text("Hello, SwiftUI!").multilineTextAlignment(.leading).padding()
                    .foregroundColor(Color.gray)

                    .font(.largeTitle)

                Text("And SceneView too")
                    .foregroundColor(Color.gray)
                    .font(.title2)

                Spacer(minLength: 300)
            }
        }
             .statusBar(hidden: true)
             */
    }

}



/*
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
 */
