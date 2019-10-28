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
    var status: Status
    let CeramicData: CeramicData
    let date: MutableProperty<Date>
    var photo: Data?
    let id: Int
    let (toggleSignal, toggleTapped) = Signal<Status, NoError>.pipe()
    let (addSignal, addTapped) = Signal<(), NoError>.pipe()
    let (photoSignal, photoTapped) = Signal<(), NoError>.pipe()
    
    init(CeramicData: CeramicData, pot: Pot) {
        self.CeramicData = CeramicData
        self.photo = pot.photo
        self.status = pot.status
        self.date = MutableProperty(pot.lastEdited)
        self.id = pot.id
    }
    
    func changePhoto(photo: Data) {
        self.photo = photo
    }
    
    func getEnum() -> Int {
        let stat: Int
        switch self.status {
        case Status.dry:
            stat = 0
        case Status.trim:
            stat = 1
        case Status.bisqued:
            stat = 2
        case Status.glazed:
            stat = 3
        default:
            stat = 4
        }
        return stat
    }
    
    func segmentTap(buttonTitle: String) {
        let status: Status
        switch buttonTitle {
        case "to dry":
           status = Status.dry
        case "to trim":
            status = Status.trim
        case "bisqued":
            status = Status.bisqued
        case "glazed":
            status = Status.glazed
        default:
            status = Status.done
        }
        self.toggleTapped.send(value: status)
        self.status = status
    }
    
    func photoTap() {
        self.photoTapped.send(value: ())
    }
    
    func cancelTap() {
        self.addTapped.send(value: ())
    }
    
    func addTap() {
        //first check if allowed
        self.addTapped.send(value: ())
        let newPot = Pot()
        newPot.status = self.status
        newPot.photo = self.photo
        newPot.lastEdited = self.date.value.removeTimeStamp()
        //if new then create new pot
        if self.id == 0 {
            self.CeramicData.saveItem(pot: newPot)
            }
        // if edit, then edit
        else {
            newPot.id = self.id
            self.CeramicData.updateItem(pot: newPot)
            }
    }

}

