//
//  UIButton+Extension.swift
//  新浪微博
//
//  Created by 李旭飞 on 15/10/18.
//  Copyright © 2015年 lee. All rights reserved.
//

import UIKit
extension UIButton{

    convenience init(image:String?,title:String?,fontSize:CGFloat?,titleColor:UIColor?){
    
      self.init()
        setImage(UIImage(named: image ?? "timeline_icon_retweet"), forState: UIControlState.Normal)
        setTitle(title, forState: UIControlState.Normal)
        setTitleColor(titleColor, forState: UIControlState.Normal)
        titleLabel?.font=UIFont.systemFontOfSize(fontSize ?? 12)
        
    }



}
