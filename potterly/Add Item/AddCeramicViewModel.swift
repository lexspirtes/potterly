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
    let (toggleSignal, toggleTapped) = Signal<Status, NoError>.pipe()
    let (addSignal, addTapped) = Signal<(), NoError>.pipe()
    let (photoSignal, photoTapped) = Signal<(), NoError>.pipe()
    
    init(CeramicData: CeramicData, photo: Data?) {
        self.CeramicData = CeramicData
        self.photo = photo
        self.status = Status.dry
        self.date = MutableProperty(Date())
    }
    
    func changePhoto(photo: Data) {
        self.photo = photo
        print("photo changed")
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
    
    func addTap() {
        //first check if allowed
        self.addTapped.send(value: ())
        let newPot = Pot()
        newPot.status = self.status
        newPot.photo = self.photo
        newPot.lastEdited = self.date.value.removeTimeStamp()
        print(newPot.lastEdited)
        self.CeramicData.saveItem(pot: newPot)
        }

}

