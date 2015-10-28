//
//  UserAccess.swift
//  新浪微博
//
//  Created by 李旭飞 on 15/10/11.
//  Copyright © 2015年 lee. All rights reserved.
//

import UIKit

class UserAccess: NSObject,NSCoding {
//用户是否登录标记
    class var userLogin : Bool{
    
    return loadUserAccount != nil
    
    }
    //    接口获取授权后的token
     var access_token:String?
    //  当前授权用户的UID
    var uid:String?

    
//    token的生命周期，单位是秒数
   private var expires_in:NSTimeInterval=0{
        didSet{
        expiresDate=NSDate(timeIntervalSinceNow: expires_in)
        }
    }
    private var expiresDate:NSDate?
    
    //用户昵称
    var name:String?
//    用户头像
    var avatar_large:String?
    //MARK:- 用字典加载模型
    init(dictionary:[String:AnyObject]){
    super.init()
    setValuesForKeysWithDictionary(dictionary)
    //MARK:- 为全局账户赋值，重点（不赋值会从本地去加载，会卡顿）
      UserAccess.useraccount=self
    }
    //防止字典的键与模型属性不对应时奔溃
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    override var description: String {
    //对对象对描述
    let properties=["access_token","expires_in","uid","expiresDate"]
    return "\(dictionaryWithValuesForKeys(properties))"
    }
    
    
    ///账户信息本地保存路径
     private static let accountPath=NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!.stringByAppendingString("token.plist")
    
    //MARK :- 加载用户信息
    func loadUserInfo(finished:(error:NSError?)->()){
        self.saveAccount()

NetworkTool.shareNetworkTool.loadUserInfo(uid!) { (result, error) -> () in
            if error != nil{
            finished(error: error)
            return
            }
    
            self.name=result!["name"] as? String
            self.avatar_large=result!["avatar_large"] as? String
    
    
            self.saveAccount()
    
            finished(error: nil)
        }
        
        
    }
    
    //MARK:- 保存用户账号授权
    func saveAccount(){

  
      NSKeyedArchiver.archiveRootObject(self, toFile: UserAccess.accountPath)
    }
   /// 定义全局的用户信息变量
    private static var useraccount:UserAccess?
    
    //MARK:- 获取用户账号授权
    class var loadUserAccount:UserAccess?{
    
    print(UserAccess.accountPath)
        //判断账户是否存在
    if useraccount==nil{
        useraccount = NSKeyedUnarchiver.unarchiveObjectWithFile(accountPath) as? UserAccess
    }
//        判断日期是否过期
    if let date = useraccount?.expiresDate where date.compare(NSDate()) == NSComparisonResult.OrderedAscending{
    
         useraccount = nil
    }
    
        return useraccount
    }
    
    
    //MARK:- 归档，解档
     required init?(coder aDecoder: NSCoder) {
        
      access_token = aDecoder.decodeObjectForKey("access_token") as? String
      expiresDate = aDecoder.decodeObjectForKey("expiresDate") as? NSDate
      uid = aDecoder.decodeObjectForKey("uid") as? String
      expires_in = aDecoder.decodeDoubleForKey("expires_in")
     name = aDecoder.decodeObjectForKey("name") as? String
     avatar_large = aDecoder.decodeObjectForKey("avatar_large") as? String
        
    }
    //归档
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeObject(expiresDate, forKey: "expiresDate")
        aCoder.encodeObject(uid, forKey: "uid")
        aCoder.encodeDouble(expires_in, forKey: "expires_in")
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(avatar_large, forKey: "avatar_large")
    }

}
