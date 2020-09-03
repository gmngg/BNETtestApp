//
//  ViewController.swift
//  BnetTestGM
//
//  Created by Malygin Georgii on 03.09.2020.
//  Copyright © 2020 Malygin Georgii. All rights reserved.
//

import Foundation

protocol MainViewModelInterface {
    func updateView()
    var noteList: [Note]? {get set}
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
    var noteList: [Note]? {
        didSet {
            updateView()
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
        interactor.getSession(success: { [weak self] (sessionData) in
            self?.sessionId = sessionData?.data?.id
            self?.userDefaults.set(self?.sessionId, forKey: "sessionId")
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
            }, failure: { error in
                print(error)
        })
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
    }
    
    func tapOnFullView() {
    }
}
