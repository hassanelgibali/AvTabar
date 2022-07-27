//
//  DateExtension.swift
//  Ana Vodafone
//
//  Created by Ahmed Nasser on 6/10/19.
//  Copyright © 2019 Vodafone Egypt. All rights reserved.
//

import Foundation
import VUIComponents

extension Date {
    static func from(year: Int, month: Int, day: Int) -> Date? {
        let calendar = Calendar(identifier: .gregorian)
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        return calendar.date(from: dateComponents) ?? nil
    }
    
    func getStringFromDate(format:String =  "yyyy-MM-dd'T'HH:mm:ss" , isEnglish:Bool = false) ->String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        var  locale = ""
        if isEnglish {
            locale = "US_POSIX"
        }else{
            locale = (LanguageHandler.sharedInstance.currentLanguage() == .arabic) ? "ar" :"US_POSIX"
        }
        dateFormatter.locale = Locale(identifier: locale) // set locale to reliable US_POSIX
        if isEnglish{
            dateFormatter.amSymbol = "AM"
            dateFormatter.pmSymbol = "PM"
        }else{
            dateFormatter.amSymbol = LanguageHandler.sharedInstance.string(forKey: "AM")
            dateFormatter.pmSymbol = LanguageHandler.sharedInstance.string(forKey: "PM")
        }
        return  dateFormatter.string(from: self)
    }
    // compare between two dates
    func compareWithDate(_ date2:Date ,by: Set<Calendar.Component>) ->DateComponents{
        let calendar = NSCalendar.current
        let components = calendar.dateComponents(by, from: self, to: date2)
        return components
    }
    
    func toMilliSecond() -> Int64 {
        return Int64((self.timeIntervalSince1970 * 1000).rounded())
    }
    
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    
    func isToday() -> Bool {
        
        return (self.getStringFromDate(format: "dd MMM", isEnglish: true) == Date().getStringFromDate(format: "dd MMM", isEnglish: true) )
    }
    func isYesterday() -> Bool {
        
        return (self.getStringFromDate(format: "dd MMM", isEnglish: true) == Date().dayBefore.getStringFromDate(format: "dd MMM", isEnglish: true) )
    }
    
    func increasingBy(type:Calendar.Component = .day,
                      numberOfDays:Int) -> Date
    {
        
        let calendar = Calendar.current

        return calendar.date(byAdding: type, value: numberOfDays, to: Date()) ?? Date()
    }

}

extension Int64 {
    func dateFromMilliseconds() -> Date {
        return Date(timeIntervalSince1970: TimeInterval(self)/1000)
    }
}
