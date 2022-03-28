//
//  AircraftCameraButtonsView.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 5/25/21.
//

import SwiftUI




struct AircraftCameraButtonsView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    /// @EnvironmentObject is a property wrapper type for an observable object that is
    /// instantiated by @StateObject supplied by a parent or ancestor view.
    @EnvironmentObject var aircraft: AircraftSceneKitScene
    @EnvironmentObject var aircraftDelegate: AircraftSceneRendererDelegate
    @EnvironmentObject var aircraftCameraButton: AircraftCameraButton

    @State private var distantCamera    = true
    @State private var shipCamera       = false

    
    var body: some View {

        HStack (spacing: 5) {

            ZStack {
                Button(action: {
                    withAnimation(.ripple(buttonIndex: 2) /*.easeInOut(duration: 0.25)*/) {

                        self.aircraftCameraButton.showCameraButtons.toggle()
                    }
                }) {
                    Image(systemName: aircraftCameraButton.showCameraButtons ? "camera.fill" : "camera")
                        .imageScale(.large)
                        .accessibility(label: Text("Cameras"))
                }
                .zIndex(3)
                .frame(
                    width: sizeClass == .compact ? CircleButtonSize.diameterCompact.rawValue : CircleButtonSize.diameter.rawValue,
                    height: sizeClass == .compact ? CircleButtonSize.diameterCompact.rawValue : CircleButtonSize.diameter.rawValue)
                /*.frame(width: CircleButtonSize.diameter.rawValue, height: CircleButtonSize.diameter.rawValue, alignment: .center)*/
                .background(self.aircraftCameraButton.showCameraButtons ? CircleButtonColor.onWithBackground.rawValue : CircleButtonColor.offWithBackground.rawValue)
                .clipShape(Circle())
                .background(Capsule().stroke(Color.blue, lineWidth: 1))
                //.animation(.ripple(buttonIndex: 2), value: aircraftCameraButton.showCameraButtons)
                //.animation(.easeInOut(duration: Double( CircleButtonSize.animationFast.rawValue) ).delay(0.0), value: aircraftCameraButton.showCameraButtons)


                if aircraftCameraButton.showCameraButtons {

                    //
                    // Button for toggling distant camera.
                    //
                    Button( action: {
                        withAnimation {
                            self.distantCamera  = true
                            self.shipCamera     = false
                            self.aircraftCameraButton.distantCameraButtonPressed.toggle()
                        }

                        self.changePOV(cameraString: self.aircraft.aircraftDistantCameraString)

                    }) {
                        Image(systemName: "airplane")
                            .imageScale(.large)
                            .accessibility(label: Text("Show Distant Camera"))
                            .padding()
                    }
                    .zIndex(2)
                    .frame(width: sizeClass == .compact ? CircleButtonSize.diameterCompact.rawValue : CircleButtonSize.diameter.rawValue,
                           height: sizeClass == .compact ? CircleButtonSize.diameterCompact.rawValue : CircleButtonSize.diameter.rawValue)
                    /*.frame(width: CircleButtonSize.diameter.rawValue, height: CircleButtonSize.diameter.rawValue, alignment: .center)*/
                    .background(distantCamera ? CircleButtonColor.onWithBackground.rawValue : CircleButtonColor.offWithBackground.rawValue)
                    .clipShape(Circle())
                    .background(Capsule().stroke(Color.blue, lineWidth: 1))
                    .transition(moveAndFadeLeft(buttonIndex: 1))
                    .offset(
                        x: sizeClass == .compact ? -( CircleButtonSize.diameterCompact.rawValue + CircleButtonSize.spacer.rawValue ) : -( CircleButtonSize.diameter.rawValue + CircleButtonSize.spacer.rawValue ),
                        y: 0)
                    /*.offset(x: -( CircleButtonSize.diameter.rawValue + CircleButtonSize.spacer.rawValue ), y: 0)*/
                    //.animation(.ripple(buttonIndex: 2), value: self.aircraftCameraButton.showCameraButtons)


                    //
                    // Button for toggling ship camera.
                    //
                    Button( action: {
                        withAnimation {
                            self.shipCamera     = true
                            self.distantCamera  = false
                            self.aircraftCameraButton.shipCameraButtonPressed.toggle()
                        }

                        self.changePOV(cameraString: self.aircraft.aircraftShipCameraString)

                    }) {
                        Image(systemName: "person.fill")
                            .imageScale(.large)
                            .accessibility(label: Text("Airplane Camera"))
                            .padding()
                    }
                    .zIndex(2)
                    .frame(
                        width: sizeClass == .compact ? CircleButtonSize.diameterCompact.rawValue : CircleButtonSize.diameter.rawValue,
                        height: sizeClass == .compact ? CircleButtonSize.diameterCompact.rawValue : CircleButtonSize.diameter.rawValue)
                    /*.frame(width: CircleButtonSize.diameter.rawValue, height: CircleButtonSize.diameter.rawValue, alignment: .center)*/
                    .background(shipCamera ? CircleButtonColor.onWithBackground.rawValue : CircleButtonColor.offWithBackground.rawValue)
                    .clipShape(Circle())
                    .background(Capsule().stroke(Color.blue, lineWidth: 1))
                    .transition(moveAndFadeRight(buttonIndex: 1))
                    .offset(
                        x: sizeClass == .compact ? ( CircleButtonSize.diameterCompact.rawValue + CircleButtonSize.spacer.rawValue ) : ( CircleButtonSize.diameter.rawValue + CircleButtonSize.spacer.rawValue ),
                        y: 0)
                    /*.offset(x: CircleButtonSize.diameter.rawValue + CircleButtonSize.spacer.rawValue, y: 0)*/
                }
            }
            .frame(width: 200, height: 70, alignment: .center)
        }
    }


    //
    // Escaping closure to push change from the AircraftScene function cycleCameras()
    //
    // Because of the way SwiftUI works, the call to the AircraftSceneRendererDelegate function cycleCamera()
    // wasn't being 'seen'.
    //
    func modifyPOV(closure: @escaping () -> Void) {
        closure()
    }



    private func changePOV(cameraString: String) -> Void {
        print("\nContentView changePOV")

        modifyPOV { [self] in

            print("cameraString: \(cameraString)")

            if cameraString == aircraft.aircraftDistantCameraString {
                self.aircraft.aircraftCurrentCamera = self.aircraft.aircraftDistantCamera
                self.aircraftDelegate.setCameraName(name: aircraft.aircraftDistantCameraString)
                self.aircraftDelegate.setCameraNode(node: aircraft.aircraftDistantCameraNode)
            }

            if cameraString == aircraft.aircraftShipCameraString {
                self.aircraft.aircraftCurrentCamera = self.aircraft.aircraftShipCamera
                self.aircraftDelegate.setCameraName(name: aircraft.aircraftShipCameraString)
                self.aircraftDelegate.setCameraNode(node: aircraft.aircraftShipCameraNode)
            }
        }
    }



    /*
     Note:

     I chose not to remove these functions from the camera buttons view since they are only called here in this
     function. Were there calls to these functions elsewhere in the code, I wuold have moved these two functions
     to AircraftHelpers.swift
     */
    func moveAndFadeRight(buttonIndex: Int) -> AnyTransition {
        let insertion   = AnyTransition.offset(
            x: sizeClass == .compact ? ( -CircleButtonSize.diameterCompact.rawValue * CGFloat(buttonIndex) ) : ( -CircleButtonSize.diameter.rawValue * CGFloat(buttonIndex) ),
            y: 0)
            //.combined(with: .opacity)

        let removal     = AnyTransition.offset(
            x: sizeClass == .compact ? ( -CircleButtonSize.diameterCompact.rawValue * CGFloat(buttonIndex) ) : ( -CircleButtonSize.diameter.rawValue * CGFloat(buttonIndex) ),
            y: 0)
            .combined(with: .opacity)

        return AnyTransition.asymmetric(insertion: insertion, removal: removal)
    }



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




struct AircraftCameraButtons_Previews: PreviewProvider {
    static var previews: some View {
        AircraftCameraButtonsView().environmentObject(AircraftCameraButton())
    }
}
