//
//  CoreDataHelpers.swift
//  potterly
//
//  Created by Alexandra Spirtes on 7/3/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import RealmSwift
import UIKit


class Note: Object {
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var lastEdited = Date()
    @objc dynamic var text = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class NoteRealmData: NoteData {
    let realm: Realm!
    
    func deleteNote(noteID: Int) {
        let oldNote = realm.objects(Note.self).filter("id = %@", noteID)
        if let oldNote = oldNote.first {
            try! realm.write {
                realm.delete(oldNote)
            }
        }
    }
    
    func getNoteData() -> Results<Note> {
        let notes = realm.objects(Note.self).sorted(byKeyPath: "lastEdited", ascending: false)
        return notes
    }
    
    func updateNote(note: Note) {
        let oldNote = realm.objects(Note.self).filter("id = %@", note.id)
        if let oldNote = oldNote.first {
            try! realm.write {
                oldNote.lastEdited = Date()
                oldNote.title = note.title
                oldNote.text = note.text
            }
        }
    }
    
    func saveNote(note: Note) {
        do {
            let maxID = self.realm.objects(Note.self).max(ofProperty: "id") as Int? ?? 0
            note.id = maxID + 1
            try self.realm.write {
            self.realm.add(note)
            }
        }
        catch {
            print(error)
        }
    }
    
    init(context: Realm) {
        self.realm = context
    }
}

protocol NoteData {
    func saveNote(note: Note)
    func getNoteData() -> Results<Note>
    func deleteNote(noteID: Int)
    func updateNote(note: Note)
}

