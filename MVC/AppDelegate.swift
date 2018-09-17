//
//  AppDelegate.swift
//  ModernMVC
//
//  Created by Gil Nakache on 04/06/2018.
//  Copyright © 2018 Viseo. All rights reserved.
//

import UIKit

struct Item {
    let title: String
    let description: String
}

extension Item: ListAppDisplayable {
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {


//        let childController = ViewController()
//        childController.list = [Item(title: "test", description: "description")]

        let rootController = MainCoordinatorViewController()
        let navController = UINavigationController(rootViewController: rootController)

        window?.rootViewController = navController
        window?.makeKeyAndVisible()

        return true
    }
}
