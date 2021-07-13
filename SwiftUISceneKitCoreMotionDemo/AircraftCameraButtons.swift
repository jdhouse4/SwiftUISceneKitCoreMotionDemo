//
//  AircraftCameraButtons.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 5/25/21.
//

import SwiftUI




extension AnyTransition {
    static var leftButtonsMoveAndFadeTransition: AnyTransition {
        let insertion   = AnyTransition.move(edge: .leading)
            .combined(with: .opacity)

        let removal     = AnyTransition.offset(x: -200, y: 0)
            .combined(with: .opacity)

        return asymmetric(insertion: insertion, removal: removal)
    }
}





struct AircraftCameraButtons: View {
    // @EnvironmentObject is a property wrapper type for an observable object that is
    // instantiated by @StateObject supplied by a parent or ancestor view.
    @EnvironmentObject var aircraft: AircraftSceneKitScene
    @EnvironmentObject var aircraftDelegate: AircraftSceneRendererDelegate
    @EnvironmentObject var aircraftCameraButton: AircraftCameraButton

    @State private var distantCamera    = true
    @State private var shipCamera       = false

    
    var body: some View {

        HStack (spacing: 5) {

            ZStack {
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.75)) {

                        self.aircraftCameraButton.showCameraButtons.toggle()
                    }
                }) {
                    Image(systemName: "camera.fill")
                        .imageScale(.large)
                }
                .zIndex(3)
                .frame(width: CircleButton.diameter.rawValue, height: CircleButton.diameter.rawValue, alignment: .center)
                .background(self.aircraftCameraButton.showCameraButtons ? CircleButtonColor.on.rawValue : CircleButtonColor.off.rawValue)
                .clipShape(Circle())
                .background(Capsule().stroke(Color.blue, lineWidth: 1))
                .animation(.ripple(buttonIndex: 2))


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
                    .frame(width: CircleButton.diameter.rawValue, height: CircleButton.diameter.rawValue, alignment: .center)
                    .background(distantCamera ? CircleButtonColor.on.rawValue : CircleButtonColor.off.rawValue)
                    .clipShape(Circle())
                    .background(Capsule().stroke(Color.blue, lineWidth: 1))
                    .transition(moveAndFadeLeft(buttonIndex: 1))
                    .offset(x: -( CircleButton.diameter.rawValue + CircleButton.spacer.rawValue ), y: 0)
                    .animation(.ripple(buttonIndex: 2))


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
                    .frame(width: CircleButton.diameter.rawValue, height: CircleButton.diameter.rawValue, alignment: .center)
                    .background(shipCamera ? CircleButtonColor.on.rawValue : CircleButtonColor.off.rawValue)
                    .clipShape(Circle())
                    .background(Capsule().stroke(Color.blue, lineWidth: 1))
                    .transition(moveAndFadeRight(buttonIndex: 1))
                    .offset(x: CircleButton.diameter.rawValue + CircleButton.spacer.rawValue, y: 0)
                    .animation(.ripple(buttonIndex: 2))
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



    func moveAndFadeRight(buttonIndex: Int) -> AnyTransition {
        let insertion   = AnyTransition.offset(x: -CircleButton.diameter.rawValue * CGFloat(buttonIndex), y: 0)
            //.combined(with: .opacity)

        let removal     = AnyTransition.offset(x: -CircleButton.diameter.rawValue * CGFloat(buttonIndex), y: 0)
            .combined(with: .opacity)

        return AnyTransition.asymmetric(insertion: insertion, removal: removal)
    }



    func moveAndFadeLeft(buttonIndex: Int) -> AnyTransition {
        let insertion   = AnyTransition.offset(x: CircleButton.diameter.rawValue * CGFloat(buttonIndex), y: 0)
            //.combined(with: .opacity)

        let removal     = AnyTransition.offset(x: CircleButton.diameter.rawValue * CGFloat(buttonIndex), y: 0)
            .combined(with: .opacity)

        return AnyTransition.asymmetric(insertion: insertion, removal: removal)
    }
}




struct AircraftCameraButtons_Previews: PreviewProvider {
    static var previews: some View {
        AircraftCameraButtons()
    }
}
