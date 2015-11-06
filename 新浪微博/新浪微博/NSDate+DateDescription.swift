//
//  NSDate+DateDescription.swift
//  新浪微博
//
//  Created by 李旭飞 on 15/11/6.
//  Copyright © 2015年 lee. All rights reserved.
//

import Foundation
extension NSDate{
    
    class func Date(string:String?)->NSDate?{
       
//        Sun Oct 18 12:40:06 +0800 2015
        let dateForm=NSDateFormatter()
        dateForm.locale=NSLocale(localeIdentifier: "ch")
        dateForm.dateFormat="EEE MMM dd HH:mm:ss zzz yyyy"
        
        return dateForm.dateFromString(string!) ?? nil
    }
    
    func dateDescription()->String{
    
    let cal=NSCalendar.currentCalendar()
       
        if cal.isDateInToday(self){
           let interval = Int(NSDate().timeIntervalSinceDate(self))
            if interval<60{
            
            return "刚刚"
            }
            if interval<3600{
            return "\(interval/60)分钟前"
            
            }
            return String(interval/3600) + "小时前"
            
    
        }
        
        var formString = "HH:mm"
        if cal.isDateInYesterday(self){
       
            formString = "昨天 " + formString
        }else{
           formString = "MM/dd " + formString
            
            
         let com = cal.components(NSCalendarUnit.Year, fromDate: NSDate(), toDate: self, options: NSCalendarOptions(rawValue: 0))
            if com.year != 0{
            
            formString = "yyyy/MM/dd " + formString
            
            }
            
        }
        let dateForm=NSDateFormatter()
        dateForm.locale=NSLocale(localeIdentifier: "ch")
        dateForm.dateFormat = formString
        
        return dateForm.stringFromDate(self)
      
    }
    


}