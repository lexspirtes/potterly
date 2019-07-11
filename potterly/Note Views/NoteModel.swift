//
//  NoteModel.swift
//  potterly
//
//  Created by Alexandra Spirtes on 6/5/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import os.log
import RealmSwift



////placeholder API
//class NoteAPI2 {
//    static func getNotes() -> [Note]{
//        let notes = [
//            Note(title: "Glazes", text: "i think i want to try frose", lastEdited: Date(), id: 1),
//            Note(title: "to Make", text: "stuff to make", lastEdited: Date(), id: 8),
//            Note(title: "Comissions", text: "aduhfjhsdgfaksdfgakdjsgfakdjshgfakjsdgfakds", lastEdited: Date(), id: 2),
//            Note(title: "for Friends", text: "butter holder", lastEdited: Date(), id: 3),
//            Note(title: "Trimming", text: "jars", lastEdited: Date(), id: 9),
//            Note(title: "Christmas Market", text: "make sure you get booth!", lastEdited: Date(), id: 4),
//            Note(title: "Slip", text: "try pedros black", lastEdited: Date(), id: 5),
//            Note(title: "Luster Fire", text: "will happen in may", lastEdited: Date(), id: 6),
//            Note(title: "Retreats", text: "upstate new york thing", lastEdited: Date(), id: 7),
//        ]
//        return notes
//    }
//
//}

//struct Note {
//    let title: String
//    let text: String
//    let lastEdited: Date
//    let id: Int
//}


class Note: Object {
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var lastEdited = Date()
    @objc dynamic var text = ""

    override static func primaryKey() -> String? {
        return "id"
    }
}


