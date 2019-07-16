//
//  StageViewModel.swift
//  potterly
//
//  Created by Alexandra Spirtes on 7/16/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import ReactiveSwift
import ReactiveCocoa
import RealmSwift


class StageViewModel {
    let CeramicData: CeramicData
    var pots: Results<Pot>
    
    init(CeramicData: CeramicData, status: Status) {
        self.CeramicData = CeramicData
        self.pots = self.CeramicData.getPotteryData(status: status)
    }
    
}
