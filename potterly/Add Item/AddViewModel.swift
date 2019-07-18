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
    let (photoSignal, photoTapped) = Signal<(), NoError>.pipe()
    let (librarySignal, libraryTapped) = Signal<(), NoError>.pipe()
    let (navSignal, navObserver) = Signal<(), NoError>.pipe()
    
    init(CeramicData: CeramicData) {
        self.CeramicData = CeramicData
        self.photo = nil
    }
    
    func tapPhoto() {
        photoTapped.send(value: ())
    }
    
    func tapLibrary() {
        libraryTapped.send(value: ())
    }
    
    
    func getAddCeramicViewModel() -> AddCeramic {
        let newVC = AddCeramic(photo: self.photo, CeramicData: self.CeramicData)
        newVC.addSignal.observeValues { _ in self.navObserver.send(value: ())}
        return newVC
    }
}
