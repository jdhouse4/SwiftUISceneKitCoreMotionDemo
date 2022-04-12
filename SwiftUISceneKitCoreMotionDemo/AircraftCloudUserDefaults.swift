//
//  AircraftCloudUserDefaults.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 4/9/22.
//

import SwiftUI



/*
extension UserDefaults {
    static var shared: UserDefaults {
        guard let defaults = UserDefaults(suiteName: AircraftGroupSettings.aircraftGroupSuiteName.rawValue) else {
            return UserDefaults.standard
        }
        
        return defaults
    }
}
*/



final class AircraftCloudUserDefaults: ObservableObject {
    static let shared = AircraftCloudUserDefaults()
    
    private var ignoreLocalChanges: Bool    = false
    //let defaults: UserDefaults
    
    
    @Published var gyroOrientationControl: Bool {
        didSet {
            print("\(#function): now setting to \(String(describing: UserDefaults.standard.object(forKey: AircraftUserSettings.pfGyroOrientationControl.rawValue)))")
            UserDefaults.standard.set(gyroOrientationControl, forKey: AircraftUserSettings.pfGyroOrientationControl.rawValue)
        }
    }
    
    
    
    private init() {
        self.gyroOrientationControl = UserDefaults.standard.object(forKey: AircraftUserSettings.pfGyroOrientationControl.rawValue) as? Bool ?? true
        
        //self.gyroOrientationControl = true
        
        print("function: \(#function), line: \(#line)– gyroOrientationControl : \(gyroOrientationControl)")
        print("function: \(#function), line: \(#line)– pfGyroOrientationControl is : \(String(describing: UserDefaults.standard.object(forKey: AircraftUserSettings.pfGyroOrientationControl.rawValue)))")

        self.start()
    }
    
    ///
    /// The following commented code is only if you're storing UserDefaults on iCloud. I'll take that up once I have standard and shared working.
    ///
    /// When an instance of this class starts-up, we want to monitor two notification names from Notification Center. If a singleton gets destroyed somehow, we want to
    /// stop watching the two names. The two one should care about are:
    ///
    /// 1. If the iCloud key-value store has changed remotely, i.e. another device has changed the key-store, here's a new value.
    /// 2. When user defaults is changed locally by us.
    ///
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    func start() {
        print("Well, at least we didn't crash getting to function: \(#function), line: \(#line)!")
        
        //UserDefaults.standard.register(defaults: [AircraftUserSettings.pfGyroOrientationControl.rawValue : true])
        
        print("function: \(#function), line: \(#line)– gyroOrientationControl : \(gyroOrientationControl)")
        print("function: \(#function), line: \(#line)– pfGyroOrientationControl : \(String(describing: UserDefaults.standard.object(forKey: AircraftUserSettings.pfGyroOrientationControl.rawValue)))")
        

        
        print("Now watching an instance of AircraftCloudUserDefaults")
        
        
        NotificationCenter.default.addObserver(forName: NSUbiquitousKeyValueStore.didChangeExternallyNotification, object: NSUbiquitousKeyValueStore.default, queue: .main, using: updateLocal)
        
        NotificationCenter.default.addObserver(forName: UserDefaults.didChangeNotification, object: nil, queue: .main, using: updateRemote)
        
        loadSettings()
    }
    
    
    
    private func loadSettings() {
        /// Don't do this, please! While it sets the value for this UserDefault item, that doesn't feed back into the @StateObject AircraftCloudUserDefaults.
        //UserDefaults.standard.set(true, forKey: AircraftUserSettings.pfGyroOrientationControl.rawValue)

        print("function: \(#function), line: \(#line)– gyroOrientationControl : \(gyroOrientationControl)")
        print("function: \(#function), line: \(#line)– pfGyroOrientationControl : \(String(describing: UserDefaults.standard.object(forKey: AircraftUserSettings.pfGyroOrientationControl.rawValue)))")
        
    }
    
    
    
    private func updateRemote(note: Notification) {
        
        print("\n\(#function) Line: \(#line)")
        
        guard ignoreLocalChanges == false else { return }
        
        print("\(#function): ignoreLocalChanges is \(ignoreLocalChanges)")
        

        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
            
            if key.hasPrefix("pf") {
                print("\(#function): key is \(key) and value is \(value)")
            }
            
            guard key.hasPrefix("pf") else { continue }
            
            print("\(#function): Updating remove value of \(key) to \(value)")
            
            NSUbiquitousKeyValueStore.default.set(value, forKey: key)
        }
    }
    
    
    
    private func updateLocal(note: Notification) {
 
        print("\n\(#function) Line: \(#line)")

        ignoreLocalChanges = true
        
        for (key, value)  in NSUbiquitousKeyValueStore.default.dictionaryRepresentation {
            
            if key.hasPrefix("pf") {
                print("\(#function): key is \(key) and value is \(value)")
            }
            
            guard key.hasPrefix("pf") else { continue }
            
            print("Updating remove value of \(key) to \(value)")
            
            UserDefaults.standard.set(value, forKey: key)
        }
        
        ignoreLocalChanges = false
    }

}
