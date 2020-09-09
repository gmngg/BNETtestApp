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
    
    func configure(note: Note, data: String) {
        textLabel?.text = note.body
        textLabel?.numberOfLines = 0
        textLabel?.lineBreakMode = .byWordWrapping
        textLabel?.text = String(note.body.prefix(200))
        textLabel?.font = .systemFont(ofSize: 14)
        detailTextLabel?.text = data
    }
}
