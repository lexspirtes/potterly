//
//  File.swift
//  potterly
//
//  Created by Alexandra Spirtes on 7/16/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import RealmSwift
import UIKit

@objc enum Status: Int {
    case trim, dry, bisqued, glazed
}

class Pot: Object {
    @objc dynamic var id = 0
    @objc dynamic var status = Status.trim
    @objc dynamic var lastEdited = Date()
    @objc dynamic var photo: Data? = nil
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

protocol CeramicData {
    func saveItem(pot: Pot)
    func convertToData(photo: UIImage) -> Data?
}

class CeramicRealmData: CeramicData {
    func saveItem(pot: Pot) {
        print("save pot")
    }
    
    func convertToData(photo: UIImage) -> Data? {
        return photo.jpegData(compressionQuality: 1.0) ?? nil
    }
    
    let realm: Realm!
    init(context: Realm){
        self.realm = context
    }
}
