//
//  NoteCellViewModel.swift
//  potterly
//
//  Created by Alexandra Spirtes on 6/28/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import Foundation
import ReactiveCocoa
import ReactiveSwift

struct Note {
    let title: String
    let text: String
    let lastEdited: Date
}

class NoteCellViewModel {
    let title: String
    let text: String?
    let date: String
    
    class func DateFormat(date: Date) -> String{
        let formatter = DateFormatter()
        //set from data timestamp
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = formatter.string(from: date)
        let yourDate = formatter.date(from: dateString)
        formatter.dateFormat = "MM.dd.YY"
        let myString = formatter.string(from: yourDate!)
        return myString
    }
    
    init(withNote note: Note){
        self.title = note.title
        self.text = note.text
        self.date = NoteCellViewModel.DateFormat(date: note.lastEdited)
    }
}
