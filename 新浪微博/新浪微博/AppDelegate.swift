//
//  AppDelegate.swift
//  新浪微博
//
//  Created by 李旭飞 on 15/10/7.
//  Copyright © 2015年 lee. All rights reserved.
//

import UIKit
//MARK:- 界面切换通知
let SwitchMainInterfaceNotification="SwitchMainInterfaceNotification"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //MARK: - 注册通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"switchMainInterface:", name: SwitchMainInterfaceNotification, object: nil)
        
        setupAppearance()
        
        // Override point for customization after application launch.
        window=UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor=UIColor.whiteColor()
        window?.rootViewController=defaultController()


        window?.makeKeyAndVisible()
        
        return true
    }
    
    
    func switchMainInterface(notify:NSNotification){
      let isMain = notify.object as! Bool
        window?.rootViewController = isMain ? MainTabBarController() : WelcomeViewController()
    
    
    }
    private func defaultController()->UIViewController{
    
        if UserAccess.userLogin {
        
            return  newUpdate() ?  NewfeatureViewController() : WelcomeViewController()
        }
        return MainTabBarController()
    }
    private func newUpdate()->Bool{
    let bundleVersion=Double(NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String)!
        let sandboxversionKey="sandversionKey"
    let sandboxVersion=NSUserDefaults.standardUserDefaults().doubleForKey(sandboxversionKey)
        NSUserDefaults.standardUserDefaults().setDouble(bundleVersion, forKey: sandboxversionKey)
        
        // iOS 7.0 之后，就不需要同步了，iOS 6.0 之前，如果不同步不会第一时间写入沙盒

//        NSUserDefaults.standardUserDefaults().synchronize()
    
    return bundleVersion > sandboxVersion
    }
    private func setupAppearance(){
        UINavigationBar.appearance().tintColor=UIColor.orangeColor()
        UITabBar.appearance().tintColor=UIColor.orangeColor()
    
    }
    
    //MARK:- 注销通知，只是习惯
    deinit{
    
    NSNotificationCenter.defaultCenter().removeObserver(self)
    
    
    }
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

