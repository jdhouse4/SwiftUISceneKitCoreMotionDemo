//
//  AircrafCloudDefaults.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 4/6/22.
//

import Foundation




final class AircrafCloudDefaults {
    
    static let shared = AircrafCloudDefaults()
    private var ignoreLocalChanges: Bool    = false
    
    private inti() { }
    
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
        NotificationCenter.default.addObserver(forName: NSUbiquitousKeyValueStore.didChangeExternallyNotification, object: NSUbiquitousKeyValueStore.default, queue: .main, using: updateLocal())
        
        NotificationCenter.default.addObserver(forName: UserDefaults.didChangeNotification, object: nil, queue: .main, using: updateRemote())
    }
    
    
    
    private func updateRemote(note: Notification) {
        
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
