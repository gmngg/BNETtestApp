//
//  ViewController.swift
//  BnetTestGM
//
//  Created by Malygin Georgii on 03.09.2020.
//  Copyright © 2020 Malygin Georgii. All rights reserved.
//

import Foundation

protocol MainViewModelInterface {
    var showMassege: (() -> Void)? {get set}
    var updateNote: (() -> Void)? {get set}
    func fullNote(note: Note?)
    func addNewNote()
    var noteList: [Note]? {get set}
    var sessionId: String? {get set}
    func getSession()
    func dataConfigure(note: Note?) -> String
}

protocol MainViewModelOutput {
    func addNewNote(session: String)
    func tapOnFullView(note: Note)
}

class MainViewModel: MainViewModelInterface {
    var updateNote: (() -> Void)?
    
    var showMassege: (() -> Void)?
    
    func fullNote(note: Note?) {
        guard let note = note else {
            return
        }
        output.tapOnFullView(note: note)
    }
    
    func addNewNote() {
        guard let sessionId = sessionId else {
            return
        }
        output.addNewNote(session: sessionId)
    }
    
    
    func dataConfigure(note: Note?) -> String {
        var data: String
        guard let da = note?.da, let dm = note?.dm else {
            data = "Дата не найдена"
            return(data)
        }
        if da == dm {
            let dam = Double(da)?.convertToTimeAndDate()
            data = "Дата создания: \(dam!)"
        } else {
            let dmm = Double(dm)?.convertToTimeAndDate()
            data = "Дата изменения: \(dmm!)"
        }
        
        return data
    }
    
    func getSession() {
        sessionId = userDefaults.string(forKey: "sessionId")
        if sessionId == nil {
            createdSession()
        } else {
            getNotes()
        }
    }
    
    var sessionId: String?
    var noteList: [Note]? {
        didSet {
            self.updateNote?()
        }
    }
    
    let userDefaults = UserDefaults.standard
    
    private let interactor: InteractorInput
    private let output: MainViewModelOutput
    
    required init(container: Container) {
        interactor = container.interactor
        output = container.output
    }
    
    func createdSession() {
        interactor.getSession(success: {  (sessionData) in
            self.sessionId = sessionData?.data?.session
            self.userDefaults.set(self.sessionId, forKey: "sessionId")
        }, failure: { (error) in
            print(error)
        })
    }
    
    func getNotes() {
        guard let sessionId = sessionId else {
            return
        }
        interactor.getNotes(session: sessionId, success: { [weak self] (noteData) in
            self?.noteList = noteData?.data.first
            }, failure: { [weak self] error in
                self?.showMassege?()
        })
    }
}

extension MainViewModel {
    struct Container {
        let interactor: InteractorInput
        let output: MainViewModelOutput
    }
}
