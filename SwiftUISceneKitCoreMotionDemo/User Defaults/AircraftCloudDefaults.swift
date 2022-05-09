//
//  AircraftCloudDefaults.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 4/6/22.
//

import Foundation




final class AircraftCloudDefaults: ObservableObject {
    
    static let shared = AircraftCloudDefaults()
    
    private var ignoreLocalChanges: Bool    = false
    
    @Published var gyroOrientationControl: Bool {
        didSet {
            UserDefaults.standard.set(gyroOrientationControl, forKey: AircraftUserSettings.pfGyroOrientationControl.rawValue)
        }
    }

    
    private init() {
        
        //AircraftCloudDefaults.shared.addSuite(named: AircraftGroupSettings.aircraftGroupSuiteName.rawValue)
        
        self.gyroOrientationControl = UserDefaults.standard.object(forKey: AircraftUserSettings.pfGyroOrientationControl.rawValue) as? Bool ?? true
        
        self.start()
        
    }
    
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
        
        print("Now watching an instance of AircraftCloudDefaults")
        
        NotificationCenter.default.addObserver(forName: NSUbiquitousKeyValueStore.didChangeExternallyNotification, object: NSUbiquitousKeyValueStore.default, queue: .main, using: updateLocal)
        
        NotificationCenter.default.addObserver(forName: UserDefaults.didChangeNotification, object: nil, queue: .main, using: updateRemote)
    }
    
    
    
    private func updateRemote(notification: Notification) {
        
        guard ignoreLocalChanges == false else { return }
        
        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
            guard key.hasPrefix("pf-") else { continue }
            
            print("Updating remove value of \(key) to \(value)")
            
            NSUbiquitousKeyValueStore.default.set(value, forKey: key)
        }
    }
    
    
    
    private func updateLocal(note: Notification) {
        
        ignoreLocalChanges = true
        
        for (key, value)  in NSUbiquitousKeyValueStore.default.dictionaryRepresentation {
            guard key.hasPrefix("pf-") else { continue }
            
            print("Updating remove value of \(key) to \(value)")
            
            UserDefaults.standard.set(value, forKey: key)
        }
        
        ignoreLocalChanges = false
    }
}
