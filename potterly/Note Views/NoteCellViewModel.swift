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


class NoteCellViewModel {
    let title: String
    let text: String?
    let date: String
    
    class func DateFormat(date: Date) -> String{
        let today = Date()
        let formatter = DateFormatter()
        //set from data timestamp
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = formatter.string(from: date)
        let newDate = formatter.date(from: dateString)
        if today.days(from: date) < 1  {
            formatter.dateFormat = "h:mm a"
        }
        else if today.days(from: date) < 7 {
            formatter.dateFormat = "EEEE"
            }
            
        else {
            formatter.dateFormat = "MM.dd.YY"
            }
        
        let formattedString = formatter.string(from: newDate!)
        return formattedString
        }
    
    
    init(withNote note: Note){
        self.title = note.title
        self.text = note.text
        self.date = NoteCellViewModel.DateFormat(date: note.lastEdited)
    }
}
