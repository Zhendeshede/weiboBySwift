//
//  UserInfo.swift
//  新浪微博
//
//  Created by 李旭飞 on 15/10/17.
//  Copyright © 2015年 lee. All rights reserved.
//

import UIKit

class UserInfo: NSObject {
  ///  用户ID
    var id:Int = 0
  /// 友好显示名称
    var name:String?
    ///用户头像地址
    var profile_image_url:String?
    ///是否是微博认证用户
    var verified:Bool?
    /// 认证类型：－1，没有认证；0，认证用户；2，3，5企业认证；220，达人
    var verified_type:Int = -1
    /// 会员等级 1-6
    var mbrank:Int = 0
    
    ///认证头像
    var vipImage:UIImage?{
        switch verified_type{
        
        case 0:
            return UIImage(named: "avatar_vip")
        case 2,3,5:
            return UIImage(named: "avatar_enterprise_vip")
        case 220:
            return UIImage(named: "avatar_grassroot")
        default:
            return nil
        
        }
   }
    ///会员图标
    var memberImage:UIImage?{
    
        if mbrank>0 && mbrank<7{
        
        return UIImage(named: "common_icon_membership_level\(mbrank)")
        }
    
     return nil
    
    }
    init(dict:[String:AnyObject]){
        super.init()
        setValuesForKeysWithDictionary(dict)

    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
   override var description:String{
    
    let keys=["id","name","profile_image_url","verified,verified_type,mbrank"]
    
    return "\(dictionaryWithValuesForKeys(keys))"
    }
    
}
