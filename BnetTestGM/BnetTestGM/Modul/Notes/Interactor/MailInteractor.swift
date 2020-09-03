//
//  MailInteractor.swift
//  BnetTestGM
//
//  Created by Malygin Georgii on 19.08.2020.
//  Copyright © 2020 Malygin Georgii. All rights reserved.
//

import Foundation
//{"status":1,"data":{"token":"Mq9aOiL-c0-tx4xq4S"}}
protocol InteractorInput {
    func getSession(success: ((SessionData?) -> Void)?, failure: ((Error) -> Void)?)
    func getNotes(session: String, success: (((NoteData)?) -> Void)?, failure:((Error) -> Void)?)
    func addNewNote(session: String, text: String, success: ((SessionData?) -> Void)?, failure: ((Error) -> Void)?)
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

extension Interactor: InteractorInput {
    func getSession(success: ((SessionData?) -> Void)?, failure: ((Error) -> Void)?) {
        networkServise.getSession(completion: { (response) in
            switch response {
                case .success(let session):
                    success?(session)
                case .failure(let error):
                    failure?(error)
            }
        })
    }
    
    func getNotes(session: String, success: (((NoteData)?) -> Void)?, failure: ((Error) -> Void)?) {
        networkServise.getNotes(session: session, completion: {(response) in
            switch response {
                case .success(let noteData):
                    success?(noteData)
                case .failure(let error):
                    failure?(error)
            }
        })
    }
    
    func addNewNote(session: String, text: String, success: ((SessionData?) -> Void)?, failure: ((Error) -> Void)?) {
        networkServise.addEntry(session: session,
                                body: text,
                                completion: { (response) in
            switch response {
            case .success(let sessionData):
                success?(sessionData)
            case .failure(let error):
                failure?(error)
            }
        })
    }
    
    
}
