//
//  NoteModel.swift
//  potterly
//
//  Created by Alexandra Spirtes on 6/5/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import RealmSwift


class Note: Object {
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var lastEdited = Date()
    @objc dynamic var text = ""

    override static func primaryKey() -> String? {
        return "id"
    }
}


