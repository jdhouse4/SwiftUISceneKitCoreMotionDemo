//
//  AircraftEngineThrottleSlider.swift
//  AircraftEngineThrottleSlider
//
//  Created by James Hillhouse IV on 8/10/21.
//

import SwiftUI




struct AircraftEngineThrottleSlider: View {
    // @EnvironmentObject is a property wrapper type for an observable object that is
    // instantiated by @StateObject supplied by a parent or ancestor view.
    @EnvironmentObject var aircraft: AircraftSceneKitScene
    //@EnvironmentObject var aircraftDelegate: AircraftSceneRendererDelegate
    @EnvironmentObject var aircraftEngineThrottle: AircraftEngineThrottle

    @State private var throttle: Double = 0

    var sliderHeight: CGFloat = 200


    var body: some View {
        Slider(value: $aircraft.aircraftEngine.birthRate, in: 0...aircraftEngineThrottle.aircraftEngineMaxThrust)
            .rotationEffect(.degrees(-90), anchor: .topLeading)
            .frame(width: sliderHeight)
            .offset(x: 138, y: 200)
    }

}




struct AircraftEngineThrottleSliderView_Previews: PreviewProvider {
    static var previews: some View {
        AircraftEngineThrottleSlider(sliderHeight: 100)
    }
}
