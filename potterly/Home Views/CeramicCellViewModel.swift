//
//  CeramicCellViewModel.swift
//  potterly
//
//  Created by Alexandra Spirtes on 7/17/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import ReactiveCocoa
import ReactiveSwift

class CeramicCellViewModel {
    let date: Date
    let photo: Data?
    let status: Status
    
    init(ceramic: Pot) {
        self.date = ceramic.lastEdited
        self.photo = ceramic.photo
        self.status = ceramic.status
    }
}
