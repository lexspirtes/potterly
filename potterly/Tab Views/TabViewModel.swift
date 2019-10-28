//
//  NavigationViewModel.swift
//  potterly
//
//  Created by Alexandra Spirtes on 7/3/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import Foundation


class TabBarViewModel {
    let NoteData: NoteData
    let CeramicData: CeramicData
    
    init(NoteData: NoteData, CeramicData: CeramicData) {
        self.NoteData = NoteData
        self.CeramicData = CeramicData
    }
    
    func getNoteViewModel() -> NotesTableViewModel {
        return NotesTableViewModel(NoteData: self.NoteData)
    }
    
//    func getAddViewModel() -> AddViewModel {
//        return AddViewModel(CeramicData: self.CeramicData)
//    }
    
    func getHomeViewModel() -> HomeViewModel {
        return HomeViewModel(CeramicData: self.CeramicData)
    }
    
    func getStageViewModel() -> StageViewModel {
        return StageViewModel(CeramicData: self.CeramicData, status: Status.done)
    }
    
//    func getPickerViewModel() -> AddViewModel {
//        return AddViewModel(CeramicData: self.CeramicData)
//    }
    
    func getAddCeramicViewModel() -> AddCeramic{
        let pot = Pot()
        pot.id = 0
        return AddCeramic(CeramicData: self.CeramicData, pot: pot)
    }
}
