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
    
    init(NoteData: NoteData) {
        self.NoteData = NoteData
    }
    
    func getNoteViewModel() -> NotesTableViewModel {
        return NotesTableViewModel(NoteData: self.NoteData)
    }
}
