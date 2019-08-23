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
import Result

class StageViewModel {
    let CeramicData: CeramicData
    var pots: Results<Pot>
    let distinctDates: Results<Pot>
    let (singleSignal, singleObserver) = Signal<(), NoError>.pipe()
    let status: Status
  //  let potsBySection: [Results<Pot>]
    
    init(CeramicData: CeramicData, status: Status) {
        self.CeramicData = CeramicData
        self.status = status
        self.pots = self.CeramicData.getPotteryData(status: status)
        self.distinctDates = self.pots.distinct(by: ["lastEdited"]).sorted(byKeyPath: "lastEdited", ascending: false)
    //    self.potsBySection = self.getTotalForDates()
     //   print(self.sections)
    }
    
    func getCeramicCellViewModel(atIndex: Int) -> CeramicCellViewModel {
        return CeramicCellViewModel(ceramic: self.pots[atIndex])
    }
    
    //make data into list of lists that knows whether to delete lists or not?
    
    func getItemsCount(section: Int) -> Int {
        return getTotalForDates()[section].count
    }
    
    func getSectionCount() -> Int {
        return self.distinctDates.count
    }
    
    func singleTap(section: Int, row: Int) {
        singleObserver.send(value: ())
        let pot = self.getTotalForDates()[section][row]
        if self.status == Status.done {}
        else {
            self.CeramicData.updateItem(pot: pot)
        }
        
    }
    
    func getCeramicSectionViewModel(section: Int, atIndex: Int) -> CeramicCellViewModel {
        let myPots = self.getTotalForDates()[section]
        return CeramicCellViewModel(ceramic: myPots[atIndex])
    }
    
    func getDistinctSection(section: Int) -> Int {
        return 4
            //self.distinctDates[section]
    }
    
    func getDates() -> [Date] {
        var dateList = [Date]()
        for pot in self.distinctDates {
            dateList.append(pot.lastEdited)
        }
        return dateList
    }
    
    func getTotalForDates() -> [Results<Pot>] {
        let dateList = self.getDates()
        var potList = [Results<Pot>]()
        for date in dateList {
            let predicate = NSPredicate(format: "lastEdited == %@", date as CVarArg)
            potList.append(self.pots.filter(predicate).sorted(byKeyPath: "lastEdited", ascending: false))
        }
        return potList
    }
    
    func getSectionViewModel(date: Date) -> SectionViewModel {
        return SectionViewModel(date: date)
    }
}

