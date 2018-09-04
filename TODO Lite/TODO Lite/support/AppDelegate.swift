//
//  AppDelegate.swift
//  TODO Lite
//
//  Created by Anton Developer on 8/31/18.
//  Copyright © 2018 Anton Developer. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        let controller = TodoListRouter.initializeModule()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
        return true
    }
}

