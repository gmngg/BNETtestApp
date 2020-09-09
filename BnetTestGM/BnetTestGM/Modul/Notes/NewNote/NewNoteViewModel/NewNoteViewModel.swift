//
//  NewNoteViewModel.swift
//  BnetTestGM
//
//  Created by Malygin Georgii on 05.09.2020.
//  Copyright © 2020 Malygin Georgii. All rights reserved.
//

import Foundation

protocol NewNoteViewModelInterfase {
    var showMessage: (() -> Void)? {get set}
    func tapSaveNote(text: String)
    func backTap()
}

protocol NewNoteViewModelOutput {
    func popToRoot()
}

class NewNoteViewModel: NewNoteViewModelInterfase {
    func backTap() {
        output.popToRoot()
    }
    
    var showMessage: (() -> Void)?
    var sessionId: String
    var interactor: InteractorInput
    var output: NewNoteViewModelOutput
    
    func tapSaveNote(text: String) {
            interactor.addNewNote(session: sessionId,
                              text: text,
                              success: { [weak self] (session) in
                                self?.output.popToRoot()
        },
                              failure: { [weak self] (error) in
                                self?.showMessage?()
        })
    }
    
    required init(container: Container) {
        interactor = container.interactor
        output = container.output
        sessionId = container.sessionId
    }
}
extension NewNoteViewModel {
    struct Container {
        let interactor: InteractorInput
        let output: NewNoteViewModelOutput
        let sessionId: String
    }
}
