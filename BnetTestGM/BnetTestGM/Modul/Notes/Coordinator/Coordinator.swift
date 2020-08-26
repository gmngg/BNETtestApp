//
//  Coordinator.swift
//  BnetTestGM
//
//  Created by Malygin Georgii on 19.08.2020.
//  Copyright © 2020 Malygin Georgii. All rights reserved.
//

import Foundation

@objc(SNTDashboardCoordinatorInput)
protocol CoordinatorInput {
    weak var output: CoordinatorOutput? { get set }
    func start()
}

@objc
protocol CoordinatorOutput {
    
}

class Coordinator: NSObject {
    weak var output: CoordinatorOutput?
    weak var interactor: InteractorInput?
    
    var router: RouterInput!
}

extension Coordinator: CoordinatorInput {
    func start() {
        router.routeToRoot()
    }
}