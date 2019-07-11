//
//  TableViewModel.swift
//  potterly
//
//  Created by Alexandra Spirtes on 6/28/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//
import ReactiveSwift
import ReactiveCocoa
import Result
import RealmSwift

class NotesTableViewModel {
    let (buttonSignal, buttonTapped) = Signal<(), NoError>.pipe()
    var notes: Results<Note>
    let NoteData: NoteData
    
    init(NoteData: NoteData) {
        self.NoteData = NoteData
        self.notes = self.NoteData.getNoteData()
    }
    func tapButton() {
        self.buttonTapped.send(value: ())
    }
    
    func deleteNote(atIndex: Int) {
        let noteID = self.notes[atIndex].id
        self.NoteData.deleteNote(noteID: noteID)
    }
    
    func getNoteViewModel(atIndex: Int) -> NoteViewModel {
        return NoteViewModel(note: self.notes[atIndex], NoteData: self.NoteData)
    }
    
    func getNewNoteViewModel() -> NoteViewModel {
        let note = Note()
        note.title = ""
        note.text = ""
        return NoteViewModel(note: note, NoteData: self.NoteData)
    }
    
    func getNoteCellViewModel(atIndex: Int)-> NoteCellViewModel{
        return NoteCellViewModel(withNote: self.notes[atIndex])
    }
}

