//
//  AppDelegate.swift
//  MarsApiTest
//
//  Created by Malygin Georgii on 22.10.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        prepareWindow()
        return true
    }
    func prepareWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        CamerasAssembly().coordinator(with: window).startApp()
    }
}
