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
    func getPotteryData(status: Status) -> Results<Pot>
}

class CeramicRealmData: CeramicData {
    func saveItem(pot: Pot) {
        do {
            let maxID = self.realm.objects(Pot.self).max(ofProperty: "id") as Int? ?? 0
            pot.id = maxID + 1
            try self.realm.write {
                self.realm.add(pot)
            }
            print("added pot!!")
        }
        catch {
            print(error)
        }
    }
    
    func getPotteryData(status: Status) -> Results<Pot> {
        let statusEnum = status.getEnum()
        let pots = realm.objects(Pot.self).filter("status == \(statusEnum)").sorted(byKeyPath: "lastEdited", ascending: false)
        return pots
    }
    
    let realm: Realm!
    init(context: Realm){
        self.realm = context
    }
}
