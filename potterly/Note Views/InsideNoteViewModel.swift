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

class NoteViewModel {
    let note: MutableProperty<String>
    let title: MutableProperty<String>
    let date: Date
    let NoteData: NoteData
    let id : Int
    let total: String
    
    init(note: Note, NoteData: NoteData) {
        self.title = MutableProperty(note.title)
        self.note = MutableProperty(note.text)
        self.total = note.title + note.text
        self.id = note.id
        self.date = Date()
        self.NoteData = NoteData
    }
    
    func saveNote() {
        let newNote = Note()
        newNote.title = self.title.value == "" ? "No Title" :  self.title.value
        newNote.text = self.note.value
        newNote.lastEdited = self.date
        if self.id == 0 {
            if (newNote.title == "No Title" && newNote.text == "") {}
            else {
                self.NoteData.saveNote(note: newNote)
            }
        }
        else {
            if (self.total == newNote.title + newNote.text) { }
            else {
                newNote.id = self.id
                self.NoteData.updateNote(note: newNote)
            }
        }
    }
}
