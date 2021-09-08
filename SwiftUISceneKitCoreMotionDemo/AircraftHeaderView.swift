//
//  AircraftHeaderView.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 7/13/21.
//

import SwiftUI




struct AircraftHeaderView: View {
    var body: some View {
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
}




struct AircraftHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        AircraftHeaderView()
    }
}
