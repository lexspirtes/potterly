//
//  InsideNoteViewModel.swift
//  potterly
//
//  Created by Alexandra Spirtes on 7/11/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import RealmSwift
import ReactiveCocoa
import ReactiveSwift
import Result

class NoteViewModel {
    let note: MutableProperty<String>
    let title: MutableProperty<String>
    let date: Date
    let (buttonSignal, buttonTapped) = Signal<(), NoError>.pipe()
    let NoteData: NoteData
    let new : Bool
    let id : Int
    
    init(note: Note, NoteData: NoteData) {
        self.title = MutableProperty(note.title)
        self.note = MutableProperty(note.text)
        self.id = note.id
        self.new = NoteViewModel.newNote(title: self.title.value)
        self.date = Date()
        self.NoteData = NoteData
    }
    
    func tapButton() {
        self.buttonTapped.send(value: ())
        print("tapped")
        let newNote = Note()
        newNote.title = self.title.value
        newNote.text = self.note.value
        newNote.lastEdited = self.date
        if self.id == 0 {
            self.NoteData.saveNote(note: newNote)
        }
        else {
            newNote.id = self.id
            self.NoteData.updateNote(note: newNote)
        }
    }
    
    class func newNote(title: String) -> Bool {
        if title.count == 0 {
            return true
        }
        else {
            return false
            
        }
    }
    
}
