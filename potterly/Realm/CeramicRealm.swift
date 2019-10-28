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
    case trim, dry, bisqued, glazed, done
}

class Pot: Object {
    @objc dynamic var id = 0
    @objc dynamic var status = Status.dry
    @objc dynamic var lastEdited = Date().removeTimeStamp()
    @objc dynamic var photo: Data? = nil
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

protocol CeramicData {
    func saveItem(pot: Pot)
    func getPotteryData(status: Status) -> Results<Pot>
    func getSections(status: Status) -> Int
    func progressItem(pot: Pot)
    func deletePot(potID: Int)
    func updateItem(pot: Pot)
}

class CeramicRealmData: CeramicData {
    
    func getSections(status: Status) -> Int {
        return 4
    }
    
    
    func deletePot(potID: Int) {
           let oldPot = realm.objects(Pot.self).filter("id = %@", potID)
           if let oldPot = oldPot.first {
               try! realm.write {
                   realm.delete(oldPot)
                    print("pot deleted")
               }
           }
       }
    
    func progressItem(pot: Pot) {
        let oldPot = realm.objects(Pot.self).filter("id = %@", pot.id)
        if let oldPot = oldPot.first {
            try! realm.write {
                oldPot.lastEdited = Date().removeTimeStamp()
                oldPot.status = pot.status.getNextStatus()
            }
        }
    }

    func saveItem(pot: Pot) {
        do {
            let maxID = self.realm.objects(Pot.self).max(ofProperty: "id") as Int? ?? 0
            pot.id = maxID + 1
            try self.realm.write {
                self.realm.add(pot)
            }
        }
        catch {
            print(error)
        }
    }
    
    func updateItem(pot: Pot) {
        let oldPot = realm.objects(Pot.self).filter("id = %@", pot.id)
          if let oldPot = oldPot.first {
          try! realm.write {
            oldPot.lastEdited = pot.lastEdited.removeTimeStamp()
            oldPot.status = pot.status
            oldPot.photo = pot.photo
          }
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
