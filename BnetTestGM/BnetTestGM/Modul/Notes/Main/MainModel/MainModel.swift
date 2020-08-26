//
//  TableViewCell.swift
//  BnetTestGM
//
//  Created by Malygin Georgii on 19.08.2020.
//  Copyright © 2020 Malygin Georgii. All rights reserved.
//

import Foundation

protocol MainModelInterface {
    var textNotes: String? {get set}
    var dataCreated: Double? {get set}
    var dataModificated: Double? {get set}
    var sessionId: String? {get set}
    func getData()
        
}

protocol MainModelOutput {
}

class MainModel: MainModelInterface {
    func getData() {
        <#code#>
    }
    
    var sessionId: String?
    
    var textNotes: String?
    
    var dataCreated: Double?
    
    var dataModificated: Double?
    
    let userDefaults = UserDefaults.standard
    
    private let interactor: InteractorInput
    private let output: MainModelOutput
    
    required init(container: Container) {
        interactor = container.interactor
        output = container.output
    }
    
}
extension MainModel {
    struct Container {
        let interactor: InteractorInput
        let output: MainModelOutput
    }
}
