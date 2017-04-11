//
//  NSData+Convert.swift
//  airmosphere
//
//  Created by ekachai limpisoot on 4/30/16.
//  Copyright © 2016 com.airasia. All rights reserved.
//

import Foundation
extension NSData
{
    class func convertDateFormString(dateStr : String, format : String) -> Date? {
        let dateFormatter = DateFormatter()
        //        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: dateStr)
        return date;
    }
    
    class func stringFromTimeInterval(interval: TimeInterval) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        return String(format: "%02d:%02d:%02d", hours, minutes,seconds)
    }
}
