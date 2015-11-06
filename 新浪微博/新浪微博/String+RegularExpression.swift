//
//  String+RegularExpression.swift
//  新浪微博
//
//  Created by 李旭飞 on 15/11/6.
//  Copyright © 2015年 lee. All rights reserved.
//

import Foundation
extension String{

    func hrefLink()->(link:String?,text:String?){
        let pattern="<a href=\"(.*?)\".*?>(.*?)</a>"
        
    
        
        let regular = try! NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.DotMatchesLineSeparators)
          
        if let result = regular.firstMatchInString(self, options: NSMatchingOptions(rawValue: 0), range:NSRange(location: 0,length: self.characters.count)){
        
    
        let link=(self as NSString).substringWithRange(result.rangeAtIndex(1))
        let text=(self as NSString).substringWithRange(result.rangeAtIndex(2))
            return (link,text)
        
        }
        
        return (nil,nil)
        
    }



}