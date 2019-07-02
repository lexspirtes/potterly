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



//placeholder API
class NoteAPI2 {
    static func getNotes() -> [Note]{
        let notes = [
            Note(title: "Glazes", text: "i think i want to try frose", lastEdited: Date()),
            Note(title: "to Make", text: "stuff to make", lastEdited: Date()),
            Note(title: "Comissions", text: "aduhfjhsdgfaksdfgakdjsgfakdjshgfakjsdgfakds", lastEdited: Date()),
            Note(title: "for Friends", text: "butter holder", lastEdited: Date()),
            Note(title: "Trimming", text: "jars", lastEdited: Date()),
            Note(title: "Christmas Market", text: "make sure you get booth!", lastEdited: Date()),
            Note(title: "Slip", text: "try pedros black", lastEdited: Date()),
            Note(title: "Luster Fire", text: "will happen in may", lastEdited: Date()),
            Note(title: "Retreats", text: "upstate new york thing", lastEdited: Date()),
        ]
        return notes
    }
    
}


//class Note: NSObject, NSCoding {
//
//    //MARK: Properties
//
//    var title: String
//    var text: String
//    var lastEdited: Date
//
//    //MARK: Archiving Paths
//    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
//    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("notes")
//
//    //MARK: Types
//
//    struct PropertyKey {
//        static let title = "title"
//        static let text = "text"
//        static let lastEdited = "lastEdited"
//    }
//
//    //MARK: Initialization
//
//    init?(title: String, text: String, lastEdited: Date) {
//
//        // The name must not be empty
//        guard !title.isEmpty else {
//            return nil
//        }
//
//        // Initialization should fail if there is no name or if the rating is negative.
//        if title.isEmpty {
//            return nil
//        }
//
//        // Initialize stored properties.
//        self.title = title
//        self.text = text
//        self.lastEdited = lastEdited
//
//    }
//
//    //MARK: NSCoding
//
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(title, forKey: PropertyKey.title)
//        aCoder.encode(text, forKey: PropertyKey.text)
//        aCoder.encode(lastEdited, forKey: PropertyKey.lastEdited)
//    }
//
//    required convenience init?(coder aDecoder: NSCoder) {
//
//        // The name is required. If we cannot decode a name string, the initializer should fail.
//        guard let title = aDecoder.decodeObject(forKey: PropertyKey.title) as? String else {
//            os_log("Unable to decode the title for a Note object.", log: OSLog.default, type: .debug)
//            return nil
//        }
//
//        // Because photo is an optional property of Meal, just use conditional cast.
//        guard let text = aDecoder.decodeObject(forKey: PropertyKey.text) as? String else {
//            os_log("Unable to decode the text for a Note object.", log: OSLog.default, type: .debug)
//            return nil
//        }
//
//        guard let lastEdited = aDecoder.decodeObject(forKey: PropertyKey.lastEdited) as? Date else {
//            os_log("Unable to decode the lastEdited for a Note object.", log: OSLog.default, type: .debug)
//            return nil
//        }
//
//        // Must call designated initializer.
//        self.init(title: title, text: text, lastEdited: lastEdited)
//
//    }
//}
