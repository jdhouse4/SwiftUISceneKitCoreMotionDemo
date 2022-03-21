//
//  AircraftRCSButtonsView.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 6/6/21.
//

import SwiftUI




struct AircraftRCSButtonsView: View {
    @EnvironmentObject var aircraft: AircraftSceneKitScene
    @EnvironmentObject var rcsButtons: AircraftRCSButtons

    let buttonAnimationTime = 0.25


    var body: some View {
        HStack (spacing: 5) {

            ZStack {
                Circle()
                    .fill(CircleButtonColor.background.rawValue)
                    .zIndex(-1)
                    .clipShape(Circle())
                    .position(x: CircleButtonView.halfWidthHeight.rawValue, y: CircleButtonView.halfWidthHeight.rawValue)



                //
                // Access Rotation Buttons
                //
                Button(action: {
                    withAnimation(.easeInOut(duration: Double(CircleButton.animationFast.rawValue))) {

                        self.rcsButtons.showRotationButtons.toggle()

                    }
                }) {
                    Image(systemName: "rotate.3d")
                        .frame(width: CircleButton.diameter.rawValue, height: CircleButton.diameter.rawValue, alignment: .center)
                        .imageScale(.large)
                }
                .zIndex(3)
                .background(CircleButtonColor.main.rawValue)
                .clipShape(Circle())
                .background(Capsule().stroke(Color.blue, lineWidth: 1))
                .position(x: CircleButtonHelper.positionMainButton().x, y: CircleButtonHelper.positionMainButton().y)


                if rcsButtons.showRotationButtons {

                    Group {
                        /*
                        //
                        // Button for pitching up.
                        //
                        Button( action: {
                            withAnimation {
                                
                                self.rcsButtons.pitchUpButtonPressed.toggle()
                                
                            }
                            
                            // Code to do something goes here
                            
                        }) {
                            Image(systemName: "arrow.up")
                                .frame(width: CircleButton.diameter.rawValue, height: CircleButton.diameter.rawValue, alignment: .center)
                                .imageScale(.large)
                                .accessibility(label: Text("Pitching up."))
                        }
                        .zIndex(2)
                        .background(CircleButtonColor.offWithBackground.rawValue)
                        .clipShape(Circle())
                        .background(Capsule().stroke(Color.blue, lineWidth: 1))
                        .transition(CircleButtonHelper.transition0DegreeButton())
                        .position(x: CircleButtonHelper.position0DegreeButton().x, y: CircleButtonHelper.position0DegreeButton().y)
                        .animation(.ripple(buttonIndex: 2), value: rcsButtons.showRotationButtons)
                        //.animation(.easeInOut(duration: Double( CircleButton.animationFast.rawValue) ).delay(0.0))
                        */
                        
                        //
                        // Button for rolling starboard.
                        //
                        Button( action: {
                            withAnimation {
                                
                                self.rcsButtons.rollStarboardButtonPressed.toggle()
                                print("Rolling Starboard")
                                
                            }
                            
                            // Code to do something goes here
                            aircraft.rcsRollStarboardUp.birthRate   = rcsButtons.aircraftRCSDefaultBirthrate
                            aircraft.rcsRollPortDown.birthRate      = rcsButtons.aircraftRCSDefaultBirthrate

                            // Milliseconds of duration for firing
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(rcsButtons.aircraftRCSMinDuration)) {
                                aircraft.rcsRollStarboardUp.birthRate   = 0
                                aircraft.rcsRollPortDown.birthRate      = 0
                            }

                        }) {
                            Image(systemName: "arrow.clockwise")
                                .frame(width: CircleButton.diameter.rawValue, height: CircleButton.diameter.rawValue, alignment: .center)
                                .imageScale(.large)
                                .accessibility(label: Text("Roll starboard."))
                        }
                        .zIndex(2)
                        .background(CircleButtonColor.offWithBackground.rawValue)
                        .clipShape(Circle())
                        .background(Capsule().stroke(Color.blue, lineWidth: 1))
                        .transition(CircleButtonHelper.transition60DegreeButton())
                        .position(x: CircleButtonHelper.position60DegreeButton().x, y: CircleButtonHelper.position60DegreeButton().y)
                        .animation(.ripple(buttonIndex: 2), value: rcsButtons.showRotationButtons)
                        //.animation(.easeInOut(duration: Double( CircleButton.animationFast.rawValue) ).delay(0.0))
                        
                        
                        /*
                        //
                        // Button for yawing starboard.
                        //
                        Button( action: {
                            withAnimation {
                                
                                self.rcsButtons.yawStarboardButtonPressed.toggle()
                                
                            }
                            
                            // Code to do something goes here
                            
                        }) {
                            Image(systemName: "arrow.right")
                                .frame(width: CircleButton.diameter.rawValue, height: CircleButton.diameter.rawValue, alignment: .center)
                                .imageScale(.large)
                                .accessibility(label: Text("Yawing starboard."))
                        }
                        .zIndex(2)
                        .background(CircleButtonColor.offWithBackground.rawValue)
                        .clipShape(Circle())
                        .background(Capsule().stroke(Color.blue, lineWidth: 1))
                        .transition(CircleButtonHelper.transition120DegreeButton())
                        .position(x: CircleButtonHelper.position120DegreeButton().x, y: CircleButtonHelper.position120DegreeButton().y)
                        .animation(.ripple(buttonIndex: 2), value: rcsButtons.showRotationButtons)
                        //.animation(.easeInOut(duration: Double( CircleButton.animationFast.rawValue) ).delay(0.0))
                        */
                        
                        /*
                        //
                        // Button for pitching down.
                        //
                        Button( action: {
                            withAnimation {
                                
                                self.rcsButtons.pitchDownButtonPressed.toggle()
                                
                            }
                            
                            // Code to do something goes here
                            
                        }) {
                            Image(systemName: "arrow.down")
                                .frame(width: CircleButton.diameter.rawValue, height: CircleButton.diameter.rawValue, alignment: .center)
                                .imageScale(.large)
                                .accessibility(label: Text("Pitching down."))
                        }
                        .zIndex(2)
                        .background(CircleButtonColor.offWithBackground.rawValue)
                        .clipShape(Circle())
                        .background(Capsule().stroke(Color.blue, lineWidth: 1))
                        .transition(CircleButtonHelper.transition180DegreeButton())
                        .position(x: CircleButtonHelper.position180DegreeButton().x, y: CircleButtonHelper.position180DegreeButton().y)
                        .animation(.ripple(buttonIndex: 2), value: rcsButtons.showRotationButtons)
                        //.animation(.easeInOut(duration: Double( CircleButton.animationFast.rawValue) ).delay(0.0))
                        */
                        
                        /*
                        //
                        // Button for yawing port.
                        //
                        Button( action: {
                            withAnimation {
                                
                                self.rcsButtons.yawPortButtonPressed.toggle()
                                
                            }
                            
                            // Code to do something goes here
                            
                        }) {
                            Image(systemName: "arrow.left")
                                .frame(width: CircleButton.diameter.rawValue, height: CircleButton.diameter.rawValue, alignment: .center)
                                .imageScale(.large)
                                .accessibility(label: Text("Yawing port."))
                        }
                        .zIndex(2)
                        .background(CircleButtonColor.offWithBackground.rawValue)
                        .clipShape(Circle())
                        .background(Capsule().stroke(Color.blue, lineWidth: 1))
                        .transition(CircleButtonHelper.transition240DegreeButton())
                        .position(x: CircleButtonHelper.position240DegreeButton().x, y: CircleButtonHelper.position240DegreeButton().y)
                        .animation(.ripple(buttonIndex: 2), value: rcsButtons.showRotationButtons)
                        //.animation(.easeInOut(duration: Double( CircleButton.animationFast.rawValue) ).delay(0.0))
                        */
                        

                        //
                        // Button for rolling port.
                        //
                        Button( action: {
                            withAnimation {
                                
                                self.rcsButtons.rollPortButtonPressed.toggle()
                                print("Roll Port")
                            }
                            
                            // Code to do something goes here
                            aircraft.rcsRollPortUp.birthRate        = rcsButtons.aircraftRCSDefaultBirthrate
                            aircraft.rcsRollStarboardDown.birthRate = rcsButtons.aircraftRCSDefaultBirthrate

                            // Milliseconds of duration for firing
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(rcsButtons.aircraftRCSMinDuration)) {
                                aircraft.rcsRollPortUp.birthRate        = 0
                                aircraft.rcsRollStarboardDown.birthRate = 0
                            }

                        }) {
                            Image(systemName: "arrow.counterclockwise")
                                .frame(width: CircleButton.diameter.rawValue, height: CircleButton.diameter.rawValue, alignment: .center)
                                .imageScale(.large)
                                .accessibility(label: Text("Rolling port."))
                        }
                        .zIndex(2)
                        .background(CircleButtonColor.offWithBackground.rawValue)
                        .clipShape(Circle())
                        .background(Capsule().stroke(Color.blue, lineWidth: 1))
                        .transition(CircleButtonHelper.transition300DegreeButton())
                        .position(x: CircleButtonHelper.position300DegreeButton().x, y: CircleButtonHelper.position300DegreeButton().y)
                        .animation(.ripple(buttonIndex: 2), value: rcsButtons.showRotationButtons)
                        //.animation(.easeInOut(duration: Double( CircleButton.animationFast.rawValue) ).delay(0.0))
                        
                }
                    .animation(.easeInOut(duration: Double( CircleButton.animationFast.rawValue) ).delay(0.0), value: rcsButtons.showRotationButtons)

                }

            }
            .frame(width: CircleButtonView.widthHeight.rawValue, height: CircleButtonView.widthHeight.rawValue, alignment: .bottomTrailing)
            //.background(Color.blue)

        }
        .frame(width: CircleButtonView.widthHeight.rawValue, height: CircleButtonView.extendedHeight.rawValue, alignment: .bottomTrailing)
        .padding(.init(top: 5, leading: 5, bottom: 5, trailing: 5))
        //.background(Color.red)

    }

}



/*
struct BottomRightButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        AircraftRCSButtonsView().environmentObject(AircraftRCSButtons())
    }
}
*/
