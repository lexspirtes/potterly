//
//  enlargedViewModel.swift
//  potterly
//
//  Created by Alexandra Spirtes on 10/25/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import ReactiveCocoa
import ReactiveSwift
import Result

class enlargedViewModel {
    let photo: Data
    let (tapSignal,tapObserver) = Signal<(), NoError>.pipe()
    
    init(ceramicData: CeramicData, photo: Data) {
        self.photo = photo
    }
    
    func singleTap() {
        self.tapObserver.send(value: ())
        print("gesture recognized")
    }
}
