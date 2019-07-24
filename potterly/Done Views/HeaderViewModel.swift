//
//  HeaderViewModel.swift
//  potterly
//
//  Created by Alexandra Spirtes on 7/18/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import ReactiveCocoa
import ReactiveSwift

class SectionViewModel {
    let date: String
    
    init(date: Date) {
        self.date = SectionViewModel.DateFormat(date: date)
    }
    
    class func DateFormat(date: Date) -> String{
        let today = Date()
        let formatter = DateFormatter()
        //set from data timestamp
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = formatter.string(from: date)
        let newDate = formatter.date(from: dateString)
        if today.days(from: date) < 1 {
            return "Today"
        }
        else if today.days(from: date) < 2 {
            return "Yesterday"
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
}
