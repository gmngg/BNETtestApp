//
//  FullNoteViewModel.swift
//  BnetTestGM
//
//  Created by Malygin Georgii on 07.09.2020.
//  Copyright © 2020 Malygin Georgii. All rights reserved.
//

import Foundation

protocol FullNoteViewModelInterface {
    func dataCreating() -> String
    func configure() -> Note
    func backTap()
}

protocol FullNoteViewModelOutput {
    func backRootView()
}

class FullNoteViewModel: FullNoteViewModelInterface {
    func backTap() {
        output.backRootView()
    }
    
    func dataCreating() -> String {
        var data: String
        let dataCreated = note.da
        let dataModif = note.dm
        if dataCreated == dataModif {
            guard let sdata = Double(dataCreated)?.convertToTimeAndDate() else {
                data = "Дата не найдена"
                return data
            }
            data = "Дата создания: \(sdata)"
        } else {
            guard let sdata = Double(dataCreated)?.convertToTimeAndDate() else {
                data = "Дата не найдена"
                return data
            }
            data = "Дата изменения: \(sdata)"
        }
        return data
    }
    
    var notes: Note? {
        return note
    }
    
    let interactor: Interactor
    let output: FullNoteViewModelOutput
    var note: Note
    
    func configure() -> Note {
        return self.note
    }
        
    required init(container: Container) {
        interactor = container.interactor
        output = container.output
        note = container.note
    }
}

extension FullNoteViewModel {
    struct Container {
        let interactor: Interactor
        let output: FullNoteViewModelOutput
        var note: Note
    }
}
