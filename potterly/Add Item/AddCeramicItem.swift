//
//  AddCeramicItem.swift
//  potterly
//
//  Created by Alexandra Spirtes on 7/15/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift
import ReactiveCocoa

class AddPhotoViewModel {
    let photo: Data?
    let status: MutableProperty<Status>
    let CeramicData: CeramicData
    let dateAdded: MutableProperty<Date>
    
    init(photo: Data?, CeramicData: CeramicData) {
        self.CeramicData = CeramicData
        self.photo = photo
        self.status = MutableProperty(Status.trim)
        self.dateAdded = MutableProperty(Date())
    }
}
