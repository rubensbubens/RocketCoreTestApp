//
//  Formats.swift
//  RocketCoreTestApp
//
//  Created by Serj Rubens on 09.12.2020.
//

import Foundation
import Then

public extension DateFormatter {
    
    private struct Cache {
        
        static let locale = Locale.autoupdatingCurrent
        
        // Sep 17, 1976
        let main = DateFormatter().then {
            $0.dateFormat = DateFormatter.dateFormat(fromTemplate: "MMMdyyyy", options: 0, locale: locale)
        }
        
        // Monday
        let dayOnly = DateFormatter().then {
            $0.dateFormat = DateFormatter.dateFormat(fromTemplate: "EEEE", options: 0, locale: locale)
        }
        
        // January 1970
        let monthYear = DateFormatter().then {
            $0.dateFormat = "LLLL y"
//            $0.locale = locale
        }
        
        // 17.09.19
        let compact = DateFormatter().then {
            $0.dateFormat = "dd.MM.yy" //DateFormatter.dateFormat(fromTemplate: "MM.dd.yy", options: 0, locale: locale)
        }
        
        // 17 September 2019
        let extended = DateFormatter().then {
            $0.dateFormat = "d MMMM yyyy" //DateFormatter.dateFormat(fromTemplate: "d MMMM yyyy", options: 0, locale: locale)
        }
        
        // 31.12.1970
        let dateAndTime = DateFormatter().then {
            $0.dateFormat = "dd.MM.yy, HH:mm" //DateFormatter.dateFormat(fromTemplate: "d MMMM yyyy", options: 0, locale: locale)
        }
        
        // 31.12
        let short = DateFormatter().then {
            $0.dateFormat = "dd.MM" //DateFormatter.dateFormat(fromTemplate: "dd.MM", options: 0, locale: locale)
        }
        
        // 12:00
        let time = DateFormatter().then {
            $0.dateStyle = .none
            $0.timeStyle = .short
        }
        
        //
        let request = DateFormatter().then {
            $0.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        }
        
        // 5 minutes ago
        let relative = RelativeDateTimeFormatter()
        
        static var instance = Cache()
        
    }
    
    class func reloadCustomFormatters() { Cache.instance = Cache() }
    
    class var main:         DateFormatter { Cache.instance.main }
    class var dayOnly:      DateFormatter { Cache.instance.dayOnly }
    class var monthYear:    DateFormatter { Cache.instance.monthYear }
    class var compact:      DateFormatter { Cache.instance.compact }
    class var extended:     DateFormatter { Cache.instance.extended }
    class var dateAndTime:  DateFormatter { Cache.instance.dateAndTime }
    class var short:        DateFormatter { Cache.instance.short }
    class var time:         DateFormatter { Cache.instance.time }
    class var request:      DateFormatter { Cache.instance.request }
    class var relative:     RelativeDateTimeFormatter { Cache.instance.relative }
}

public extension Date {
    var main: String        { DateFormatter.main.string(from: self) }
    var dayOnly: String     { DateFormatter.dayOnly.string(from: self) }
    var monthYear: String   { DateFormatter.monthYear.string(from: self).capitalized }
    var compact: String     { DateFormatter.compact.string(from: self) }
    var extended: String    { DateFormatter.extended.string(from: self) }
    var dateAndTime: String { DateFormatter.dateAndTime.string(from: self) }
    var short: String       { DateFormatter.short.string(from: self) }
    var time: String        { DateFormatter.time.string(from: self) }
    var request: String     { DateFormatter.request.string(from: self) }
}
