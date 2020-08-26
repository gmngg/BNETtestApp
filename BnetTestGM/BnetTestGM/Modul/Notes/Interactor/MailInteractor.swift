//
//  MailInteractor.swift
//  BnetTestGM
//
//  Created by Malygin Georgii on 19.08.2020.
//  Copyright © 2020 Malygin Georgii. All rights reserved.
//

import Foundation
//{"status":1,"data":{"token":"Mq9aOiL-c0-tx4xq4S"}}
@objc
protocol InteractorInput {
    
}

protocol InteractorOutput {
    
}
class Interactor: Injectable {
    let networkServise: NetworkDataProtocol
    
    required init(container: Container) {
        networkServise = container.networkServise
    }
}

extension Interactor {
    struct  Container {
        let networkServise: NetworkDataProtocol
    }
}
