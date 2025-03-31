//
//  AircraftEngineThrottleSlider.swift
//  AircraftEngineThrottleSlider
//
//  Created by James Hillhouse IV on 8/10/21.
//

import SwiftUI




struct AircraftEngineThrottleSlider: View {

    @Environment(\.horizontalSizeClass) var sizeClass

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

        VStack {


        
            Text(throttle)
                .frame(width: 75, height: 40)
                .foregroundColor(Color.black)
                .opacity(CircleButtonSize.primaryOpacity.rawValue)
                .font(.title3.monospaced())
                .padding(EdgeInsets(top: 15, leading: 5, bottom: 5, trailing: 5))
                //.background(Color.red.opacity(0.7))
            
            Spacer()

            Slider(value: $aircraft.aircraftEngine.birthRate, in: 0...aircraftEngineThrottle.aircraftEngineMaxThrust)
                .frame(width: sliderHeight)
                //.background(Color.yellow.opacity(0.7))
                .rotationEffect(.degrees(-90), anchor: .center)
                .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
            
            Spacer()
        }
        .frame(
            width: sizeClass == .compact ? CircleButtonSize.widthHeightCompact.rawValue : CircleButtonSize.widthHeight.rawValue,
            height: sizeClass == .compact ? CircleButtonSize.widthHeightCompact.rawValue : CircleButtonSize.widthHeight.rawValue,
            alignment: .center)
        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
        //.background(Color.green.opacity(0.7))
    }

}




struct AircraftEngineThrottleSliderView_Previews: PreviewProvider {
    static var previews: some View {
        AircraftEngineThrottleSlider()
    }
}
