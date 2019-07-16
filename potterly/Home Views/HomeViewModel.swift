//
//  HomeViewModel.swift
//  potterly
//
//  Created by Alexandra Spirtes on 7/16/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import ReactiveCocoa
import ReactiveSwift

class HomeViewModel {
    let CeramicData: CeramicData
    
    init(CeramicData: CeramicData) {
        self.CeramicData = CeramicData
    }
    
    func getChildViewModel() -> StageViewModel {
        return StageViewModel(CeramicData: self.CeramicData)
    }
}
