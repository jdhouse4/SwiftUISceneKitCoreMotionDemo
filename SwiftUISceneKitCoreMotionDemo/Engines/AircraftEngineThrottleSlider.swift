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


    var sliderHeight: CGFloat = 125

    var throttle: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        let throttle = aircraft.aircraftEngine.birthRate / 1500.00

        //print("Throttle: \(throttle)")

        return formatter.string(from: NSNumber(value: throttle)) ?? "0"
    }


    var body: some View {

        VStack(/*alignment: .trailing*/) {
            
            Spacer()

            Text(throttle)
                .foregroundColor(Color.black)
                .opacity(CircleButtonSize.primaryOpacity.rawValue)
                .font(.title3.monospaced())
                //.background(Color.red.opacity(0.9))

            Slider(value: $aircraft.aircraftEngine.birthRate, in: 0...aircraftEngineThrottle.aircraftEngineMaxThrust)
                .frame(width: sliderHeight)
                .rotationEffect(.degrees(-90), anchor: .center)
            
                .padding(EdgeInsets(top: 50, leading: 5, bottom: 5, trailing: 5))
                //.background(Color.pink.opacity(0.9))
        }
        .frame(alignment: .bottom)
        .padding(EdgeInsets(top: 5, leading: 5, bottom: 60, trailing: 10))
        //.background(Color.green.opacity(0.95))
    }

}




struct AircraftEngineThrottleSliderView_Previews: PreviewProvider {
    static var previews: some View {
        AircraftEngineThrottleSlider()
    }
}
