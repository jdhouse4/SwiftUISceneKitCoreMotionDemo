//
//  AircraftRCSButtonView.swift
//  AircraftRCSButtonView
//
//  Created by James Hillhouse IV on 9/8/21.
//

import SwiftUI




struct AircraftRCSButtonView: View {

    @EnvironmentObject var aircraft: AircraftSceneKitScene
    @EnvironmentObject var aircraftDelegate: AircraftSceneRendererDelegate
    @EnvironmentObject var aircraftRCSButton: AircraftRCSButton

    @State private var aircraftRCSRollPort      = true
    @State private var aircraftRCSRollStarboard = false

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AircraftRCSButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AircraftRCSButtonView()
    }
}
