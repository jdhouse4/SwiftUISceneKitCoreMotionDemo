//
//  AircraftEngineThrottleSlider.swift
//  AircraftEngineThrottleSlider
//
//  Created by James Hillhouse IV on 8/10/21.
//

import SwiftUI




struct AircraftEngineThrottleSlider: View {
    /// @EnvironmentObject is a property wrapper type for an observable object that is
    /// instantiated by @StateObject supplied by a parent or ancestor view.
    @EnvironmentObject var aircraft: AircraftSceneKitScene
    @EnvironmentObject var aircraftEngineThrottle: AircraftEngineThrottle


    var sliderHeight: CGFloat = 200

    var throttle: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        let throttle = aircraft.aircraftEngine.birthRate / 1500.00

        //print("Throttle: \(throttle)")

        return formatter.string(from: NSNumber(value: throttle)) ?? "0"
    }


    var body: some View {

        VStack {

            Text(throttle)
                .foregroundColor(Color.black)
                .opacity(CircleButton.primaryOpacity.rawValue)
                .font(.title3)
                .offset(x: 55, y: 10)

            Slider(value: $aircraft.aircraftEngine.birthRate, in: 0...aircraftEngineThrottle.aircraftEngineMaxThrust)
                .rotationEffect(.degrees(-90), anchor: .topLeading)
                .frame(width: sliderHeight)
                .offset(x: 138, y: 200) // x was 138
        }
    }

}




struct AircraftEngineThrottleSliderView_Previews: PreviewProvider {
    static var previews: some View {
        AircraftEngineThrottleSlider()
    }
}
