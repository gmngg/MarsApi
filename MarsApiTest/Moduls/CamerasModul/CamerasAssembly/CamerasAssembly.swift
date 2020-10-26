//
//  CamerasAssembly.swift
//  MarsApiTest
//
//  Created by Malygin Georgii on 23.10.2020.
//

import UIKit

class CamerasAssembly {
    weak var interactorCash: CamerasInteractor?
    weak var coordinatorCash: CamerasCoordinator?
    weak var routerCash: CamerasRouter?
    lazy var interactor: CamerasInteractor = {
        guard let interactor = interactorCash else {
            let interactor = CamerasInteractor(
                container: CamerasInteractor.Container(
                    networkServise: NetworkServise.networkServise
                )
            )
            interactorCash = interactor
            return interactor
        }
        return interactor
    }()
    lazy var router: CamerasRouter = {
        guard let router = routerCash else {
            let router = CamerasRouter(assembly: self)
            routerCash = router
            return router
        }
        return router
    }()
    lazy var coordinator: CamerasCoordinator = {
        guard let coordinator = coordinatorCash else {
            let coordinator = CamerasCoordinator()
            coordinatorCash = coordinator
            return coordinator
        }
        return coordinator
    }()
    func coordinator(with context: UIWindow?) -> CamerasCoordinatorInput {
        let router = self.router
        router.context = context
        
        let coordinator = self.coordinator
        coordinator.router = router
        coordinator.interactor = interactor
        
        return coordinator
    }
    func startAppRoute() -> UIViewController {
        let viewModel = CamerasViewModel(
            container: CamerasViewModel.Container(output: coordinator)
        )
        let viewController = CamerasViewController(
            container: CamerasViewController.Container(
                viewModel: viewModel)
        )
        return viewController
    }
    
}
