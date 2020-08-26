//
//  TableViewCell.swift
//  BnetTestGM
//
//  Created by Malygin Georgii on 19.08.2020.
//  Copyright © 2020 Malygin Georgii. All rights reserved.
//

import UIKit

class MainViewCell: UITableViewCell {
    
    static let reuseId = "noteCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(note: Note) {
        textLabel?.text = note.body
        textLabel?.numberOfLines = 0
        textLabel?.lineBreakMode = .byWordWrapping
        textLabel?.text = String(note.body.prefix(200))
        let createdDate = Double(note.da)?.convertToTimeAndDate()
        let modificateDate = Double(note.dm)?.convertToTimeAndDate()
        
        if createdDate == modificateDate {
            detailTextLabel?.text = "Дата создания: \(createdDate ?? "Дата не найдена")"
        } else {
            detailTextLabel?.text = "Дата изменения: \(modificateDate ?? "Дата не найдена")"
        }
    }
}
