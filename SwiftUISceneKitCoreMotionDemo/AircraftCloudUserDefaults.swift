//
//  AircraftCloudUserDefaults.swift
//  SwiftUISceneKitCoreMotionDemo
//
//  Created by James Hillhouse IV on 4/9/22.
//

import SwiftUI



///
///  From Paul Hudson's
///
///  [Storing preferences efficiently](https://www.hackingwithswift.com/plus/making-the-most-of-foundation/storing-preferences-efficiently)
///
///  Paul shows a way for storing user preferences in UserDefaults that stores them on iCloud and, when changed locally, pushes them to the remote user's app when it opens.
///
///  I modified it a little to conform it to ObservableObject and an @Published variable parameter, as written about on the blog [Simple Swift Guide](https://simpleswiftguide.com) in the post [How to use UserDefaults in Swift](https://www.simpleswiftguide.com/how-to-use-userdefaults-in-swiftui/).
///
///  This offers the best of both worlds.
///
///  1. There is a singleton that is posting UserDefaults changes remotely and locally as needed.
///  2. Conforming to ObservableObject means an instance of this singleton can be wrapped in an @StateObject property wrapper
///
///  I've used it as follows:
///
///  1. The instance of this singleton is wrapped in the @main App struct as an @StateObject variable property and declared as an .environmentObject.
///  2. AircraftCloudUserDefaults is wrapped as an @EnvironmentObject property and is available where needed.
///  3. In AircraftCloudUserDefaults, user preferences are wrapped as @Published property variables.
///  4. Since the user preferences are wrapped as an @Published properties, changes via, say, in clicking a button, will automatically update.
///
///  To my mind, this gives the app a great deal of flexibility with no downside, other than the time it took my tiny brain to wrap itselft around the whole
///  UserDefaults concept.
///
final class AircraftCloudUserDefaults: ObservableObject {
    static let shared = AircraftCloudUserDefaults()
    
    private var ignoreLocalChanges: Bool    = false
    
    
    @Published var gyroOrientationControl: Bool {
        didSet {
            print("\(#function): now setting to \(String(describing: UserDefaults.standard.object(forKey: AircraftUserSettings.pfGyroOrientationControl.rawValue)))")
            UserDefaults.standard.set(gyroOrientationControl, forKey: AircraftUserSettings.pfGyroOrientationControl.rawValue)
        }
    }
    
    
    
    private init() {
        self.gyroOrientationControl = UserDefaults.standard.object(forKey: AircraftUserSettings.pfGyroOrientationControl.rawValue) as? Bool ?? true
                
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
        print("function: \(#function), line: \(#line)– gyroOrientationControl : \(gyroOrientationControl)")
        print("function: \(#function), line: \(#line)– pfGyroOrientationControl : \(String(describing: UserDefaults.standard.object(forKey: AircraftUserSettings.pfGyroOrientationControl.rawValue)))")

        print("Now watching an singleton of AircraftCloudUserDefaults")
        
        NotificationCenter.default.addObserver(forName: NSUbiquitousKeyValueStore.didChangeExternallyNotification, object: NSUbiquitousKeyValueStore.default, queue: .main, using: updateLocal)
        
        NotificationCenter.default.addObserver(forName: UserDefaults.didChangeNotification, object: nil, queue: .main, using: updateRemote)
    }
    
    

    private func updateRemote(note: Notification) {
        
        print("\n\(#function) Line: \(#line)")
        
        guard ignoreLocalChanges == false else { return }

        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
            
            guard key.hasPrefix("pf") else { continue }
            
            print("\(#function): Updating remove value of \(key) to \(value)")
            
            NSUbiquitousKeyValueStore.default.set(value, forKey: key)
        }
    }
    
    
    
    private func updateLocal(note: Notification) {
 
        print("\n\(#function) Line: \(#line)")

        ignoreLocalChanges = true
        
        for (key, value)  in NSUbiquitousKeyValueStore.default.dictionaryRepresentation {
            
            guard key.hasPrefix("pf") else { continue }
            
            print("\(#function): Updating local value of \(key) to \(value)")
            
            UserDefaults.standard.set(value, forKey: key)
        }
        
        ignoreLocalChanges = false
    }

}
