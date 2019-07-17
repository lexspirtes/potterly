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
    let sections: Int
    let distinctDates: Results<Pot>
    
    init(CeramicData: CeramicData, status: Status) {
        self.CeramicData = CeramicData
        self.pots = self.CeramicData.getPotteryData(status: status)
        self.distinctDates = self.pots.distinct(by: ["lastEdited"])
        self.sections = distinctDates.count
     //   print(self.sections)
    }
    
    func getCeramicCellViewModel(atIndex: Int) -> CeramicCellViewModel {
        return CeramicCellViewModel(ceramic: self.pots[atIndex])
    }
    
    func getSectionCount(section: Int) -> Int {
        return  1
    }
}
