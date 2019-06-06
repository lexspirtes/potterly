//
//  DataHelpers.swift
//  potterly
//
//  Created by Alexandra Spirtes on 6/5/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import Foundation
import CoreData

//extension of Date class to create seconds
extension Date {
    func toSeconds() -> Int64 {
        return Int64((self.timeIntervalSince1970).rounded())
    }
    init(seconds:Int64!){
        self = Date(timeIntervalSince1970: TimeInterval(Double.init(seconds)))
    }
}

//date Helper
class PotterlyDateHelper {
    
    static func convertDate(date: Date) -> String {
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        //let myString = formatter.string(from: Date()) // string purpose I add here
        let myString = formatter.string(from: date) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format which type of output you need
        formatter.dateFormat = "EEEE, MMM d, yyyy, hh:mm:ss"
        // again convert date to string
        let myStringafd = formatter.string(from: yourDate!)
        return myStringafd
    }
}
