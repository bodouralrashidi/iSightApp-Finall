//
//  AppDelegate.swift
//  Socket
//
//  Created by dalal aljassem on 10/19/21.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
var window: UIWindow?

    override init() {
                FirebaseApp.configure()
        }

        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            let db = Firestore.firestore()
            return true
        }
}
