//
//  WelcomeViewController.swift
//  新浪微博
//
//  Created by 李旭飞 on 15/10/14.
//  Copyright © 2015年 lee. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
  
    //MARK:- 懒加载头像，昵称
    private lazy var backgroudImgView:UIImageView=UIImageView(image: UIImage(named: "ad_background"))
   private lazy var iconView:UIImageView={
        let icon=UIImageView(image: UIImage(named: "avatar_default_big"))
        icon.layer.masksToBounds=true
        icon.layer.cornerRadius=45
    

   
    
        return icon
        }()
    private lazy var label:UILabel={
        
        let lab=UILabel()
        lab.text=UserAccess.loadUserAccount!.name
        lab.sizeToFit()
        return lab
        
        }()
   private var iconBottomC : NSLayoutConstraint?
    private func prepareForView(){
    
       view.addSubview(backgroudImgView)
        view.addSubview(iconView)
       view.addSubview(label)
        backgroudImgView.translatesAutoresizingMaskIntoConstraints=false
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[subview]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["subview":backgroudImgView]))
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[subview]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["subview":backgroudImgView]))
        //头像约束
        iconView.translatesAutoresizingMaskIntoConstraints=false
        view.addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.Width, multiplier: 1.0, constant: 90))
        view.addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 90))
        
        view.addConstraint(NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 150))
        
        iconBottomC=view.constraints.last
        
        label.translatesAutoresizingMaskIntoConstraints=false
        view.addConstraint(NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10))
        view.addConstraint(NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0))
        
        

    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       prepareForView()
    
            
            

        if let urlString = UserAccess.loadUserAccount?.avatar_large{
        NSURLSession.sharedSession().downloadTaskWithURL(NSURL(string: urlString)!, completionHandler: { (location, _, error) -> Void in
            if error != nil{
            
            //网络不给力
            return
            }
            
            if let data=NSData(contentsOfURL: location!){
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                self.iconView.image=UIImage(data: data)
                self.label.text = UserAccess.loadUserAccount!.name
                
                
            })
                
            }
            
            }).resume()
        
        
        
        }
        
        
        

        }
    
    


   
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        iconBottomC?.constant=UIScreen.mainScreen().bounds.height-iconBottomC!.constant - 100
      
        
            UIView.animateWithDuration(1.2, delay: 0.2, usingSpringWithDamping: 0.8, initialSpringVelocity: 5.0, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
                
               
                self.view.layoutIfNeeded()
                },completion: {(_) -> Void in
            NSNotificationCenter.defaultCenter().postNotificationName(SwitchMainInterfaceNotification, object: true)
  
                    
            })
        

        }
        
    

    }
