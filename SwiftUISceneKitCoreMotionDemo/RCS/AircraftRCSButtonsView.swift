//
//  AircraftRCSButtonsView.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 6/6/21.
//

import SwiftUI




struct AircraftRCSButtonsView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @EnvironmentObject var aircraft: AircraftSceneKitScene
    @EnvironmentObject var aircraftDelegate: AircraftSceneRendererDelegate
    @EnvironmentObject var aircraftState: AircraftState
    @EnvironmentObject var rcsButtons: AircraftRCSButtons
    

    let buttonAnimationTime = 0.25


    var body: some View {
        HStack (spacing: 5) {

            ZStack {
                Circle()
                    .fill(CircleButtonColor.background.rawValue)
                    .zIndex(-1)
                    .clipShape(Circle())
                    .position(
                              x: sizeClass == .compact ? CircleButtonSize.halfWidthHeightCompact.rawValue : CircleButtonSize.halfWidthHeight.rawValue,
                              y: sizeClass == .compact ? CircleButtonSize.halfWidthHeightCompact.rawValue : CircleButtonSize.halfWidthHeight.rawValue)



                //
                // Access Rotation Buttons
                //
                Button(action: {
                    withAnimation(.easeInOut(duration: Double(CircleButtonSize.animationFast.rawValue))) {

                        self.rcsButtons.showRotationButtons.toggle()

                    }
                }) {
                    Image(systemName: "rotate.3d")
                        /*.frame(width: CircleButtonSize.diameter.rawValue, height: CircleButtonSize.diameter.rawValue, alignment: .center)*/
                        .imageScale(.large)
                }
                .zIndex(3)
                .frame(
                    width: sizeClass == .compact ? CircleButtonSize.diameterCompact.rawValue : CircleButtonSize.diameter.rawValue,
                    height: sizeClass == .compact ? CircleButtonSize.diameterCompact.rawValue : CircleButtonSize.diameter.rawValue,
                    alignment: .center)
                .background(CircleButtonColor.main.rawValue)
                .clipShape(Circle())
                .background(Circle().stroke(Color.blue, lineWidth: 1))
                .position(
                    x: sizeClass == .compact ? CircleButtonHelper.positionMainButtonCompact().x :         CircleButtonHelper.positionMainButton().x,
                    y: sizeClass == .compact ? CircleButtonHelper.positionMainButtonCompact().y : CircleButtonHelper.positionMainButton().y)


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
                                .frame(width: CircleButtonSize.diameter.rawValue, height: CircleButtonSize.diameter.rawValue, alignment: .center)
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
                        //.animation(.easeInOut(duration: Double( CircleButtonSize.animationFast.rawValue) ).delay(0.0))
                        */
                        
                        //
                        // Button for rolling starboard.
                        //
                        Button( action: {
                            withAnimation {
                                
                                rcsButtons.rollStarboardButtonPressed = true
                                //print("Rolling Starboard")
                                
                            }
                            
                            //aircraft.rollStarboard()
                            self.changeOrientation()
                            
                            /*
                            // Code to do something goes here
                            aircraft.rcsRollStarboardUp.birthRate   = rcsButtons.aircraftRCSDefaultBirthrate
                            aircraft.rcsRollPortDown.birthRate      = rcsButtons.aircraftRCSDefaultBirthrate

                            // Milliseconds of duration for firing
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(rcsButtons.aircraftRCSMinDuration)) {
                                aircraft.rcsRollStarboardUp.birthRate   = 0
                                aircraft.rcsRollPortDown.birthRate      = 0
                            }
                             */
                            
                        }) {
                            Image(systemName: "arrow.clockwise")
                                /*.frame(width: CircleButtonSize.diameter.rawValue, height: CircleButtonSize.diameter.rawValue, alignment: .center)*/
                                .imageScale(.large)
                                .accessibility(label: Text("Roll starboard."))
                        }
                        .zIndex(2)
                        .frame(
                            width: sizeClass == .compact ? CircleButtonSize.diameterCompact.rawValue : CircleButtonSize.diameter.rawValue,
                            height: sizeClass == .compact ? CircleButtonSize.diameterCompact.rawValue : CircleButtonSize.diameter.rawValue, alignment: .center)
                        .background(CircleButtonColor.offWithBackground.rawValue)
                        .clipShape(Circle())
                        .background(Capsule().stroke(Color.blue, lineWidth: 1))
                        .transition( sizeClass == .compact ? CircleButtonHelper.transition60DegreeButtonCompact() : CircleButtonHelper.transition60DegreeButton() )
                        .position(
                            x: sizeClass == .compact ? CircleButtonHelper.position60DegreeButtonCompact().x : CircleButtonHelper.position60DegreeButton().x ,
                            y: sizeClass == .compact ? CircleButtonHelper.position60DegreeButtonCompact().y : CircleButtonHelper.position60DegreeButton().y )
                        .animation(.ripple(buttonIndex: 2), value: rcsButtons.showRotationButtons)
                        //.animation(.easeInOut(duration: Double( CircleButtonSize.animationFast.rawValue) ).delay(0.0))
                        
                        
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
                                .frame(width: CircleButtonSize.diameter.rawValue, height: CircleButtonSize.diameter.rawValue, alignment: .center)
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
                        //.animation(.easeInOut(duration: Double( CircleButtonSize.animationFast.rawValue) ).delay(0.0))
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
                                .frame(width: CircleButtonSize.diameter.rawValue, height: CircleButtonSize.diameter.rawValue, alignment: .center)
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
                        //.animation(.easeInOut(duration: Double( CircleButtonSize.animationFast.rawValue) ).delay(0.0))
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
                                .frame(width: CircleButtonSize.diameter.rawValue, height: CircleButtonSize.diameter.rawValue, alignment: .center)
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
                        //.animation(.easeInOut(duration: Double( CircleButtonSize.animationFast.rawValue) ).delay(0.0))
                        */
                        

                        //
                        // Button for rolling port.
                        //
                        Button( action: {
                            withAnimation {
                                
                                self.rcsButtons.rollPortButtonPressed = true
                                print("Roll Port")
                            }
                            
                            //aircraft.rollPort()
                            self.changeOrientation()
                            
                            /*
                            // Code to do something goes here
                            aircraft.rcsRollPortUp.birthRate        = rcsButtons.aircraftRCSDefaultBirthrate
                            aircraft.rcsRollStarboardDown.birthRate = rcsButtons.aircraftRCSDefaultBirthrate

                            // Milliseconds of duration for firing
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(rcsButtons.aircraftRCSMinDuration)) {
                                aircraft.rcsRollPortUp.birthRate        = 0
                                aircraft.rcsRollStarboardDown.birthRate = 0
                            }
                             */
                        }) {
                            Image(systemName: "arrow.counterclockwise")
                                /*.frame(width: CircleButtonSize.diameter.rawValue, height: CircleButtonSize.diameter.rawValue, alignment: .center)*/
                                .imageScale(.large)
                                .accessibility(label: Text("Rolling port."))
                        }
                        .zIndex(2)
                        .frame(
                            width: sizeClass == .compact ? CircleButtonSize.diameterCompact.rawValue : CircleButtonSize.diameter.rawValue,
                            height: sizeClass == .compact ? CircleButtonSize.diameterCompact.rawValue : CircleButtonSize.diameter.rawValue, alignment: .center)
                        .background(CircleButtonColor.offWithBackground.rawValue)
                        .clipShape(Circle())
                        .background(Capsule().stroke(Color.blue, lineWidth: 1))
                        .transition(sizeClass == .compact ? CircleButtonHelper.transition300DegreeButtonCompact() : CircleButtonHelper.transition300DegreeButton())
                        .position(
                            x: sizeClass == .compact ? CircleButtonHelper.position300DegreeButtonCompact().x : CircleButtonHelper.position300DegreeButton().x,
                            y: sizeClass == .compact ? CircleButtonHelper.position300DegreeButtonCompact().y : CircleButtonHelper.position300DegreeButton().y)
                        .animation(.ripple(buttonIndex: 2), value: rcsButtons.showRotationButtons)
                        //.animation(.easeInOut(duration: Double( CircleButtonSize.animationFast.rawValue) ).delay(0.0))
                        
                }
                    .animation(.easeInOut(duration: Double( CircleButtonSize.animationFast.rawValue) ).delay(0.0), value: rcsButtons.showRotationButtons)

                }

            }
            .frame(
                width: sizeClass == .compact ? CircleButtonSize.widthHeightCompact.rawValue : CircleButtonSize.widthHeight.rawValue,
                height: sizeClass == .compact ? CircleButtonSize.widthHeightCompact.rawValue : CircleButtonSize.widthHeight.rawValue,
                alignment: .bottomTrailing)
            //.background(Color.blue)

        }
        .frame(
            width: sizeClass == .compact ? CircleButtonSize.widthHeightCompact.rawValue : CircleButtonSize.widthHeight.rawValue,
            height: sizeClass == .compact ? CircleButtonSize.extendedHeightCompact.rawValue : CircleButtonSize.extendedHeight.rawValue,
            alignment: .bottomTrailing)
        .padding(.init(top: 5, leading: 5, bottom: 5, trailing: 5))
        //.background(Color.red)

    }


    
    //
    // Escaping closure to push change from the AircraftSceneRendererDelegate functions to set camera name and node.
    //
    // Because of the way SwiftUI works, AircraftSceneRendererDelegate functions can't call the SwiftUI SceneView
    // SCNScene parameters. It's a real pain!
    //
    func modifyOrientation(closure: @escaping () -> Void) {
        closure()
    }
    
    
    
    private func changeOrientation() -> Void {
        print("\n\(#function)")

        modifyOrientation { [self] in

            //print("Changing orientation of aircraft.")

            if rcsButtons.rollStarboardButtonPressed {
                //print("\(#function): rcsButtons.rollStarboardButtonPressed: \(rcsButtons.rollStarboardButtonPressed)")
                //self.aircraftDelegate.setAircraftNode(node: aircraft.aircraftNode)
                //self.aircraftDelegate.aircraftNode            = aircraft.aircraftNode
                
                self.aircraft.rollStarboard()
                
                self.aircraftDelegate.aircraftDeltaQuaternion   = aircraftState.singleImpulseRollStarboard()
            }

            if rcsButtons.rollPortButtonPressed {
                //print("\(#function): rcsButtons.rollPortButtonPressed: \(rcsButtons.rollPortButtonPressed)")
                //self.aircraftDelegate.aircraftNode            = aircraft.aircraftNode
                
                self.aircraft.rollPort()
                
                self.aircraftDelegate.aircraftDeltaQuaternion   = aircraftState.singleImpulseRollPort()
            }
        }
        rcsButtons.rollStarboardButtonPressed   = false
        rcsButtons.rollPortButtonPressed        = false
    }
}



/*
struct BottomRightButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        AircraftRCSButtonsView().environmentObject(AircraftRCSButtons())
    }
}
*/
