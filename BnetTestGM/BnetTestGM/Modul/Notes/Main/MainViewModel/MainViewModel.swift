//
//  TableViewCell.swift
//  BnetTestGM
//
//  Created by Malygin Georgii on 19.08.2020.
//  Copyright © 2020 Malygin Georgii. All rights reserved.
//

import Foundation

protocol MainViewModelInterface {
    var noteList: NoteData? {get set}
    var sessionId: String? {get set}
    func getSession()
    func getNote()
}

protocol MainViewModelOutput {
    func addNewNote()
    func tapOnFullView()
}

class MainViewModel: MainViewModelInterface {
    
    func getNote() {
        interactor.getNotes(session: sessionId!, seccess: { (noteLists) in
            self.noteList = noteLists
          }
            , failure: {(error) in
                print(error)
        })
    }
    
    func getSession() {
        sessionId = userDefaults.string(forKey: "sessionId")
        if sessionId == nil {
            createdSession()
        } else {
            getNote()
        }
    }
    
    var sessionId: String?
    var noteList: NoteData?
    
    let userDefaults = UserDefaults.standard
    
    private let interactor: InteractorInput
    private let output: MainViewModelOutput
    
    required init(container: Container) {
        interactor = container.interactor
        output = container.output
    }
    
    func createdSession() {
        interactor.newSession(success: { (newSessionId) in
            self.userDefaults.set(newSessionId, forKey: "sessionId")
            self.getSession()
        }
        ,failure: { (error) in
            print(error)
        }
        )
    }
    
    func notesCrea() {
        
        interactor.getNotes(session: sessionId!, seccess: { notes in
            self.noteList = notes
        }, failure: { error in
            print(error)
        }
        )
    }
}
extension MainViewModel {
    struct Container {
        let interactor: InteractorInput
        let output: MainViewModelOutput
    }
}

extension MainViewModel: MainViewModelOutput {
    func addNewNote() {
        <#code#>
    }
    
    func tapOnFullView() {
        <#code#>
    }
}
