//
//  AddCeramicItem.swift
//  potterly
//
//  Created by Alexandra Spirtes on 7/15/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import ReactiveSwift
import ReactiveCocoa
import Result

class AddCeramic {
    let photo: Data?
    var status: Status
    let CeramicData: CeramicData
    let date: MutableProperty<Date>
    let (toggleSignal, toggleTapped) = Signal<Status, NoError>.pipe()
    let (addSignal, addTapped) = Signal<(), NoError>.pipe()
    
    init(photo: Data?, CeramicData: CeramicData) {
        self.CeramicData = CeramicData
        self.photo = photo
        self.status = Status.dry
        self.date = MutableProperty(Date())
    }
    
    
    func toggleTap(buttonTitle: Status) {
        self.toggleTapped.send(value: buttonTitle)
        self.status = buttonTitle
    }
    
    func addTap() {
        self.addTapped.send(value: ())
        let newPot = Pot()
        newPot.status = self.status
        newPot.photo = self.photo
        newPot.lastEdited = self.date.value
        self.CeramicData.saveItem(pot: newPot)
        }

    func getHomeViewModel() -> HomeViewModel {
        return HomeViewModel(CeramicData: self.CeramicData)
    }
}

