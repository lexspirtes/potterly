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
        if NoteCellViewModel.compareDate(date1: today, date2: date) < 24 {
            formatter.dateFormat = "h:mm a"
        }
        else if NoteCellViewModel.compareDate(date1: today, date2: date) < 168 {
            formatter.dateFormat = "EEEE"
            }
            
        else {
            formatter.dateFormat = "MM.dd.YY"
            }
        
        let formattedString = formatter.string(from: newDate!)
        return formattedString
        }
    
    
    class func compareDate(date1:Date, date2:Date) -> Int {
        let units = Set<Calendar.Component>([.hour, .year, .minute, .second])
        let cal = NSCalendar.current
        let return_value = cal.dateComponents(units, from: date1, to: date2)
        return return_value.hour!
    }
    
    init(withNote note: Note){
        self.title = note.title
        self.text = note.text
        self.date = NoteCellViewModel.DateFormat(date: note.lastEdited)
    }
}
