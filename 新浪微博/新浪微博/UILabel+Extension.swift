//
//  UILabel+Extension.swift
//  新浪微博
//
//  Created by 李旭飞 on 15/10/18.
//  Copyright © 2015年 lee. All rights reserved.
//

import UIKit
extension UILabel{
   
    convenience init(color:UIColor?,fontSize:CGFloat?){
        
        self.init()
        textColor=color
        font=UIFont.systemFontOfSize(fontSize ?? 13)
        
    }

}
