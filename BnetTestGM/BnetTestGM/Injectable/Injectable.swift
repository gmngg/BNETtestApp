//
//  TableViewCell.swift
//  BnetTestGM
//
//  Created by Malygin Georgii on 19.08.2020.
//  Copyright © 2020 Malygin Georgii. All rights reserved.
//

import Foundation

protocol Injectable {
    associatedtype Container
    init(container: Container)
}
