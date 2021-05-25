//
//  AircraftCameraButtons.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 5/25/21.
//

import SwiftUI




struct AircraftCameraButtons: View {
    // @EnvironmentObject is a property wrapper type for an observable object that is
    // instantiated by @StateObject supplied by a parent or ancestor view.
    @EnvironmentObject var aircraft: AircraftSceneKitScene
    @EnvironmentObject var aircraftDelegate: AircraftSceneRendererDelegate

    @State private var distantCamera        = true
    @State private var shipCamera           = false

    
    var body: some View {

        HStack (spacing: 5) {
            //
            // Button for toggling distant camera.
            //
            Button( action: {
                withAnimation {
                    self.distantCamera  = true
                    self.shipCamera     = false
                }

                self.changePOV(cameraString: self.aircraft.aircraftDistantCameraString)

            }) {
                /*
                Image(systemName: distantCamera ? "camera.circle.fill" : "camera.circle")
                    //.resizable()
                    .frame(width: 40, height: 40, alignment: .center)
                    .imageScale(.large)
                    .accessibility(label: Text("Show Distant Camera"))
                    .padding()
                */
                Image(systemName: "camera")
                    .frame(width: 20, height: 20, alignment: .center)
                    .imageScale(.large)
                    .accessibility(label: Text("Show Distant Camera"))
                    .padding()
            }
            .background(Capsule().stroke(lineWidth: 1))


            //
            // Button for toggling ship camera.
            //
            Button( action: {
                withAnimation {
                    self.shipCamera     = true
                    self.distantCamera  = false
                }

                self.changePOV(cameraString: self.aircraft.aircraftShipCameraString)

            }) {
                /*
                Image(systemName: shipCamera ? "airplane.circle.fill" : "airplane.circle")
                    .frame(width: 40, height: 40)
                    .imageScale(.large)
                    .accessibility(label: Text("Airplane Camera"))
                    .padding()
                */
                Image(systemName: "airplane")
                    .frame(width: 20, height: 20)
                    .imageScale(.large)
                    .accessibility(label: Text("Airplane Camera"))
                    .padding()
            }
            .background(Capsule().stroke(lineWidth: 1))

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

}




struct AircraftCameraButtons_Previews: PreviewProvider {
    static var previews: some View {
        AircraftCameraButtons()
    }
}
