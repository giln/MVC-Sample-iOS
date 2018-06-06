//
//  AppDelegate.swift
//  ModernMVC
//
//  Created by Gil Nakache on 04/06/2018.
//  Copyright © 2018 Viseo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let rootController = MainCoordinatorViewController()
        let navController = UINavigationController(rootViewController: rootController)

        window?.rootViewController = navController
        window?.makeKeyAndVisible()

        return true
    }
}
