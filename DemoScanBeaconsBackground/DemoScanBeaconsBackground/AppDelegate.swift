//
//  AppDelegate.swift
//  DemoScanBeaconsBackground
//
//  Created by Duy Tran N. on 12/9/20.
//  Copyright © 2020 MBA0204. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        window = UIWindow(frame: UIScreen.main.bounds)

        if let window = window {
            window.makeKeyAndVisible()
            window.backgroundColor = .systemOrange
            window.rootViewController = HomeViewController()
        }

        return true
    }
}
