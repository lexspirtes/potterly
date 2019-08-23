//
//  AddViewModel.swift
//  potterly
//
//  Created by Alexandra Spirtes on 7/16/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import Foundation
import ReactiveSwift
import ReactiveCocoa
import Result

class AddViewModel {
    let CeramicData: CeramicData
    var photo: Data?
    let (navSignal, navObserver) = Signal<(), NoError>.pipe()
    
    init(CeramicData: CeramicData) {
        self.CeramicData = CeramicData
        self.photo = nil
    }
    
    func tapNav() {
        navObserver.send(value: ())
        print("im tapped")
    }
    
    func getAddCeramicViewModel() -> AddCeramic {
        return AddCeramic(CeramicData: self.CeramicData, photo: self.photo)
    }
}
