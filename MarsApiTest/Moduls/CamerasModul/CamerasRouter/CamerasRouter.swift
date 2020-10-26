//
//  CamerasRouter.swift
//  MarsApiTest
//
//  Created by Malygin Georgii on 23.10.2020.
//

import UIKit

protocol CamerasRouterInput {
    func startApp()
}

protocol CamerasRouterOutput {
}

class CamerasRouter: NSObject, CamerasRouterInput {
    var navigationBar: UINavigationController?
    private var assembly: CamerasAssembly
    var context: UIWindow?
    func startApp() {
        let viewController = assembly.startAppRoute()
        let navigationController = UINavigationController(
            rootViewController: viewController)
        context?.rootViewController = navigationController
        context?.makeKeyAndVisible()
    }
    init(assembly: CamerasAssembly) {
        self.assembly = assembly
    }
}
