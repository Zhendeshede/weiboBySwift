//
//  NetworkTool.swift
//  新浪微博
//
//  Created by 李旭飞 on 15/10/10.
//  Copyright © 2015年 lee. All rights reserved.
//

import UIKit

private let ErrorDomain="network.error"
//网络访问错误枚举
private enum NetworkError:Int{
    
    case emptyDataError = -1
    case emptyTokenError = -2
    
    ///错误描述
    private var errorDescription:String{
    
        switch self {
        case .emptyDataError: return "空数据"
        case .emptyTokenError: return "没有权限"
            
        }
        
    }
    ///根据枚举类型返回错误信息
    private func error()->NSError{
        
        return NSError(domain: ErrorDomain, code: rawValue, userInfo:[ErrorDomain:errorDescription])
        
    }
    
}



class NetworkTool: NSObject {
  
    //MARK:- 检查token
    private func checkToken(finished:FinishedCallBack)->[String:AnyObject]?{
        if UserAccess.loadUserAccount?.access_token == nil{
            let error = NetworkError.emptyTokenError.error()
            finished(result: nil, error: error)
            return nil
        }
    
            //返回字典时为啦包成参数，这样直接再添加额外参数就可
    return ["access_token":UserAccess.loadUserAccount!.access_token!]
    }
    
    //MARK:- 加载微博数据
    func loadWeiboData(since_id:Int,max_id:Int,finished:FinishedCallBack){
    
        guard var param=checkToken(finished) else{
        
        return
        }
        if since_id>0{
            param["since_id"]="\(since_id)";
        
        
        }
        if max_id>0{
        
        
            param["max_id"]="\(max_id-1)";
        }
        
        
        
       let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
       
        networkRequest(.GET, URLString: urlString, paramater: param, finished: finished)
    }
    
    
    
    static let shareNetworkTool=NetworkTool()
    //MARK: - OAuth授权
    private let clientId="2260003661"
    private let appSecret="84630ccd2050db7da66f9d1e7c25d105"

    let redirectURL="http://www.baidu.com"
    
   func oauthURL()->NSURL{

    let path=NSURL(string: "https://api.weibo.com/oauth2/authorize?client_id=\(clientId)&redirect_uri=\(redirectURL)")
    
    return path!
    }
    
    //MARK:- 获取用户信息
    
    func loadUserInfo(uid:String,finished:FinishedCallBack){
    
   //判断token是否存在
        guard var param = checkToken(finished) else{
         finished(result: nil, error: NetworkError.emptyTokenError.error())
        return
        }
        
        
        let url="https://api.weibo.com/2/users/show.json"
         param["uid"]=uid

        networkRequest(.GET, URLString: url, paramater: param, finished: finished)


    }
    
//    MARK:- 获取授权码token

    func oauthToken(code:String,finished:FinishedCallBack){
        
        
        let dict=["client_id":clientId,
                  "client_secret":appSecret,
                  "grant_type":"authorization_code",
                  "code":code,
                  "redirect_uri":redirectURL]
        let url="https://api.weibo.com/oauth2/access_token"
        networkRequest(.POST, URLString: url, paramater: dict, finished: finished)
    
    
    }
    //                                              这里要加问号，有可能为空
    typealias FinishedCallBack = (result:AnyObject?,error:NSError?)->()
   ///网络请求方式枚举
     enum HttpMethod:String{
       case GET = "GET"
        case POST = "POST"
    
    }
    //MARK:- 封装网络请求方法
    func networkRequest(methed:HttpMethod,URLString:String,paramater:[String:AnyObject],finished:FinishedCallBack){
        var body = ""
        for (key,value) in paramater{
        body += "\(key)=\(value as! String)&"
        
        }
        body = (body as NSString).substringToIndex(body.characters.count-1)
        
        let request = NSMutableURLRequest()

        switch methed{
        case .POST :
            request.URL = NSURL(string: URLString)
            request.HTTPMethod = "POST"
            request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)
        case .GET :
            request.URL = NSURL(string: "\(URLString)?\(body)")
            request.HTTPMethod = "GET"
        }
        
        NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            
            
            if error != nil || data == nil{

            finished(result: nil, error: error)
            
            return
            }
            do{
                let obj = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0))
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in

                    finished(result: obj, error: nil)
                })
                
            }catch{

                finished(result: nil, error: NetworkError.emptyDataError.error())
            }
            
        }.resume()
        
    
    }
    
    
}