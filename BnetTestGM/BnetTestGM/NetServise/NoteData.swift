//
//  TableViewCell.swift
//  BnetTestGM
//
//  Created by Malygin Georgii on 21.08.2020.
//  Copyright © 2020 Malygin Georgii. All rights reserved.
//

import Foundation

struct NoteData: Codable {
    
    let status: Int
    let data: [[Note]]
    
    enum CodingKeys: String, CodingKey  {
        case status = "status"
        case data = "data"
    }
}

struct Note: Codable {
    let id: String
    let body: String
    let da: String
    let dm: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case body = "body"
        case da = "da"
        case dm = "dm"
    }
}
