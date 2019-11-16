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
    var distinctDates: [Date]
    let (singleSignal, singleObserver) = Signal<(IndexPath), NoError>.pipe()
    let (doubleSignal, doubleObserver) = Signal<(), NoError>.pipe()
    let (deleteSignal, deleteObserver) = Signal<(IndexPath), NoError>.pipe()
    let (editSignal, editObserver) = Signal<(IndexPath), NoError>.pipe()
    let (reloadSignal, reloadObserver) = Signal<(), NoError>.pipe()
    var ceramicViewModels : [Int:CeramicCellViewModel]
    var collectionPots : [Date:Results<Pot>]

    let status: Status
  //  let potsBySection: [Results<Pot>]
    
    init(CeramicData: CeramicData, status: Status) {
        print("start")
        self.CeramicData = CeramicData
        self.status = status
        self.pots = self.CeramicData.getPotteryData(status: status).sorted(byKeyPath: "lastEdited", ascending: false)
        self.distinctDates = []
        self.collectionPots = [:]
        print("end")
        self.ceramicViewModels = [:]
        self.setDates()
        self.reducePots()
    }
    func reloadVM() {
        let newDates = self.getDates()
        if !newDates.elementsEqual(self.distinctDates) {
            self.setDates()
            self.reducePots()
        }
    }
    func reducePots() {
        for date in self.distinctDates {
            let predicate = NSPredicate(format: "lastEdited == %@", date as CVarArg)
            self.collectionPots[date] = self.pots.filter(predicate).sorted(byKeyPath: "lastEdited", ascending: false)
        }
    }

    
    //make data into list of lists that knows whether to delete lists or not?
    
    func getItemsCount(section: Int) -> Int {
        if self.status == Status.glazed  {
            print(self.pots)
        }
        let date = self.distinctDates[section]
        return self.collectionPots[date]?.count ?? 0
    }
    
    func getSectionCount() -> Int {
        return self.collectionPots.keys.count
    }
    
    func doubleTap(indexPath: IndexPath) {
        print("in double tap")
        doubleObserver.send(value: ())
        let pot = self.collectionPots[self.distinctDates[indexPath.section]]![indexPath.row]
        if self.status == Status.done {}
        else {
            self.CeramicData.progressItem(pot: pot)
        }
    }
    func singleTap(indexPath: IndexPath) {
        singleObserver.send(value: (indexPath))
        print("will go into view")
    }
    
    func edit(indexPath: IndexPath) -> AddCeramic {
      //  editObserver.send(value: (indexPath))
        let pot = self.collectionPots[self.distinctDates[indexPath.section]]![indexPath.row]
        return AddCeramic(CeramicData: CeramicData, pot: pot)
    }
    
    func getAddCeramicViewModel(indexPath: IndexPath) -> AddCeramic {
        let pot = self.collectionPots[self.distinctDates[indexPath.section]]![indexPath.row]
        return AddCeramic(CeramicData: CeramicData, pot: pot)
    }
    
    func goView(indexPath: IndexPath) {
        print("view")
    }
    
    func delete(indexPath: IndexPath) {
        deleteObserver.send(value: (indexPath))
        let potID = self.collectionPots[self.distinctDates[indexPath.section]]![indexPath.row].id
            self.CeramicData.deletePot(potID: potID)
        }
    

    func getCeramicSectionViewModel(index: IndexPath) -> CeramicCellViewModel {
        let myDate = self.distinctDates[index.section]
        let curPot = self.collectionPots[myDate]![index.row]
        if self.ceramicViewModels[curPot.id] == nil {
            self.ceramicViewModels[curPot.id] = CeramicCellViewModel(ceramic: curPot)
        }
        let before = self.ceramicViewModels[curPot.id]!
        return CeramicCellViewModel(ceramic: curPot)
    }
    
    func getEnlargedViewModel(indexPath: IndexPath) -> enlargedViewModel {
        let pot = self.collectionPots[self.distinctDates[indexPath.section]]![indexPath.row]
        return enlargedViewModel(ceramicData: CeramicData, photo: pot.photo!)
    }
    
    func getDates() -> [Date] {
        func helper(p: Pot) -> Date {
            return p.lastEdited
        }
        var datesArray = Array(self.pots.distinct(by: ["lastEdited"]).sorted(byKeyPath: "lastEdited", ascending: false).map(helper))
        datesArray.sort(by: >)
        return datesArray
    }
    
    func setDates() {
        self.distinctDates = getDates()
    }
    
    
    func getSectionViewModel(date: Date) -> SectionViewModel {
        return SectionViewModel(date: date)
    }
}

