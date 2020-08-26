//
//  TableViewCell.swift
//  BnetTestGM
//
//  Created by Malygin Georgii on 21.08.2020.
//  Copyright © 2020 Malygin Georgii. All rights reserved.
//

import Foundation

struct SessionData: Codable {
    let status: String
    let data: Session?
}

struct Session: Codable {
    let id: String?
    let session: String?
}


