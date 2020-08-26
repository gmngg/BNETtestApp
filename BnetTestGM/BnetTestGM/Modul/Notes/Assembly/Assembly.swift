//
//  Assembly.swift
//  BnetTestGM
//
//  Created by Malygin Georgii on 19.08.2020.
//  Copyright © 2020 Malygin Georgii. All rights reserved.
//
import UIKit

class Assembly {
    weak var interactorCashe: Interactor?
    weak var routerCashe: Router?
    weak var coordinatorCashe: Coordinator?
    
    lazy var interactor: Interactor = {
        guard let interactor = interactorCashe else {
            let interactor = Interactor(
                container: Interactor.Container(
                    networkServise: NetworkData.networkData
                    )
                )
            interactorCashe = interactor
            return interactorCashe!
        }
        return interactor
    }()
    
    lazy var router: Router = {
        guard let router = routerCashe else {
            let router = Router(assembly: self)
            
            routerCashe = router
            return routerCashe!
        }
        return router
    }()
    
    lazy var coordinator: Coordinator = {
        guard let coordinator = coordinatorCashe else {
            let coordinator = Coordinator()
            
            coordinatorCashe = coordinator
            return coordinatorCashe!
        }
        return coordinator
    }()
    
    func coordinator(with context: UIWindow?) -> CoordinatorInput {
        let router = self.router
        router.context = context
        
        let coordinator = self.coordinator
        coordinator.router = router
        coordinator.interactor = interactor
        return coordinator
    }
    
    func mainViewController() -> UIViewController {
        let viewModel = MainModel(
            container: MainModel.Container(
                interactor: interactor,
                output: coordinator)
        )
        
        let viewController = MainViewController(
            container: MainViewController.Container(viewModel: viewModel)
        )
        return viewController
    }
}
