//
//  TableViewModel.swift
//  potterly
//
//  Created by Alexandra Spirtes on 6/28/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import Foundation
import ReactiveSwift
import ReactiveCocoa
import Result
import CoreData

class NotesTableViewModel {
    let (buttonSignal, buttonTapped) = Signal<(), NoError>.pipe()
    var notes: [Note]
   // let noteAPI : [Note]
    
    init() {
        self.notes = NoteAPI2.getNotes()
       // self.noteAPI = NotesTableViewModel.resultToNote(dataList: data)
    }
    func tapButton() {
        self.buttonTapped.send(value: ())
        print("hi")
    }
    
//    class func loadNotes() -> [Note]?  {
//        return NSKeyedUnarchiver.unarchiveObject(withFile: Note.ArchiveURL.path) as? [Note]
//    }
    
    class func resultToNote(dataList: [NSManagedObject]) -> [Note] {
        let noteArray = dataList.map {
            Note(title: $0.value(forKey: "title") as! String, text: $0.value(forKey: "text") as! String, lastEdited: $0.value(forKey: "lastEdited") as! Date)
        }
        return noteArray
    }
    
    func getNoteViewModel(atIndex: Int) -> NoteViewModel {
        return NoteViewModel(withNote: self.notes[atIndex])
    }
    
    func getNoteCellViewModel(atIndex: Int)-> NoteCellViewModel{
        return NoteCellViewModel(withNote: self.notes[atIndex])
    }
}


class NotesViewModel {
    let title: MutableProperty<String>
    let text: MutableProperty<String>
    
    init(){
        self.title = MutableProperty("")
        self.text = MutableProperty("")
    }
    
    func getOutputViewModel()-> SavedViewModel{
        return SavedViewModel(title: self.title, text: self.text)
    }
    
}

class SavedViewModel {
    init(title: MutableProperty<String>, text: MutableProperty<String>){
    }
}
