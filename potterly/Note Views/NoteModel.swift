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


//note Model
struct Note {
    var title: String?
    var text: String?
    var date: String?
}


//placeholder API
class NoteAPI {
    static func getNotes() -> [Note]{
        let notes = [
            Note(title: "Glazes", text: "i think i want to try frose", date: "Friday"),
            Note(title: "to Make", text: "stuff to make", date: "06.01.19"),
            Note(title: "Comissions", text: "aduhfjhsdgfaksdfgakdjsgfakdjshgfakjsdgfakds", date: "05.30.19"),
            Note(title: "for Friends", text: "butter holder", date: "05.23.19"),
            Note(title: "Trimming", text: "jars", date: "05.20.19"),
            Note(title: "Christmas Market", text: "make sure you get booth!", date: "04.13.18"),
            Note(title: "Slip", text: "try pedros black", date: "03.12.18"),
            Note(title: "Luster Fire", text: "will happen in may", date: "03.11.18"),
            Note(title: "Retreats", text: "upstate new york thing", date: "03.10.18"),
        ]
        return notes
    }
}
