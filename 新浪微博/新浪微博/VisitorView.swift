//
//  VisitorView.swift
//  新浪微博
//
//  Created by 李旭飞 on 15/10/9.
//  Copyright © 2015年 lee. All rights reserved.
//

import UIKit
protocol VisitorViewDelegate:NSObjectProtocol{

    func visitorViewWillLogin()
    func visitorViewWillRegister()

}
class VisitorView: UIView {
    
    
//    定义代理,一定要用weak
  weak var delegate:VisitorViewDelegate?
//    点击注册
    func clickRegister(){
    delegate?.visitorViewWillRegister()
    
    
    }
//    点击登录
   func clickLogin(){
    delegate?.visitorViewWillLogin()
    
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       setting()
    }
    
    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        setting()
    }
    
   
    func settingWithInfo(isHome:Bool,imageName:String,titleL:String,titleB:String?){
        houseImg.image=UIImage(named: imageName)
        introduceLab.text=titleL
        nonLoginBut.setTitle(titleB, forState: UIControlState.Normal)
        
        isHome ? startAnimation() : settingNonloginView()
        
    }
    //MARK:- 设置非主界面视图
  private func settingNonloginView(){
        
        
        coverImg.removeFromSuperview()
        specialImg.removeFromSuperview()
        registerBut.removeFromSuperview()
        loginBut.removeFromSuperview()

        addSubview(nonLoginBut)
        
        //        非登录界面按钮
        nonLoginBut.translatesAutoresizingMaskIntoConstraints=false
        addConstraint(NSLayoutConstraint(item: nonLoginBut, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem:nil, attribute: NSLayoutAttribute.Width, multiplier: 1.0, constant: 120))
        addConstraint(NSLayoutConstraint(item: nonLoginBut, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem:nil, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 35))
        addConstraint(NSLayoutConstraint(item: nonLoginBut, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem:introduceLab, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: nonLoginBut, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem:introduceLab, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant:20))

           }
    //MARK:- 设置主界面动画
   private func startAnimation(){
    
        let animate=CABasicAnimation(keyPath: "transform.rotation")
        animate.duration=20.0
        animate.repeatCount=MAXFLOAT
        animate.toValue=2*M_PI
        //如果界面有动画一定要检退出到桌面后再进入动画是否执行
        animate.removedOnCompletion=false
        specialImg.layer.addAnimation(animate, forKey: nil)
    
    }

   private func setting(){
    
            addSubview(specialImg)
            addSubview(coverImg)
            addSubview(houseImg)
            addSubview(introduceLab)
            addSubview(registerBut)
           addSubview(loginBut)
           backgroundColor=UIColor(white: 237/255.0, alpha: 1)
        
        //        小房子
        houseImg.translatesAutoresizingMaskIntoConstraints=false
        
        addConstraint(NSLayoutConstraint(item: houseImg, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: houseImg, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant:-44))
        
        
        //        消息文本
        introduceLab.translatesAutoresizingMaskIntoConstraints=false
        
        addConstraint(NSLayoutConstraint(item:introduceLab, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: houseImg, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 20))
        addConstraint(NSLayoutConstraint(item:introduceLab, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: houseImg, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant:0))
        addConstraint(NSLayoutConstraint(item: introduceLab, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.Width, multiplier: 1.0, constant: 230))
        //        旋转图标
        specialImg.translatesAutoresizingMaskIntoConstraints=false
        
        addConstraint(NSLayoutConstraint(item:specialImg, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: houseImg, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item:specialImg, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: houseImg, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant:0))
        //        注册按钮
        registerBut.translatesAutoresizingMaskIntoConstraints=false
        addConstraint(NSLayoutConstraint(item: registerBut, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem:introduceLab, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: registerBut, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem:introduceLab, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant:20))
        addConstraint(NSLayoutConstraint(item: registerBut, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem:nil, attribute: NSLayoutAttribute.Width, multiplier: 1.0, constant: 90))
        addConstraint(NSLayoutConstraint(item: registerBut, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem:nil, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 35))
        
        //        登录按钮
        
        loginBut.translatesAutoresizingMaskIntoConstraints=false
        addConstraint(NSLayoutConstraint(item: loginBut, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem:introduceLab, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: loginBut, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem:introduceLab, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant:20))
        addConstraint(NSLayoutConstraint(item: loginBut, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem:nil, attribute: NSLayoutAttribute.Width, multiplier: 1.0, constant: 90))
        addConstraint(NSLayoutConstraint(item: loginBut, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem:nil, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 35))
        //        遮罩
        coverImg.translatesAutoresizingMaskIntoConstraints=false
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[reference]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["reference":coverImg]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[reference]-(-35)-[register]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["reference":coverImg,"register":registerBut]))
        
    
    
    }
    
    
    //MARK: - 懒加载属性
    ///特效图
   private lazy var specialImg:UIImageView={
        let imageV=UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
        
        return imageV
        }()
    
      ///遮罩图
   private lazy var coverImg:UIImageView={
        
       let imageV=UIImageView()
        imageV.image=UIImage(named: "visitordiscover_feed_mask_smallicon")
        
        return imageV
        }()
    ///房子（图）
    private lazy var houseImg:UIImageView={
       let imageV=UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
        
       return imageV
    }()
     ///简介文本
  private lazy var introduceLab:UILabel={
        
        let label=UILabel()
        label.text="我不是很牛逼，我是非常牛逼,不是很牛逼，我是非常牛逼"
        label.numberOfLines=0
        label.textAlignment=NSTextAlignment.Center
        label.font=UIFont.systemFontOfSize(15)
        label.textColor=UIColor.darkGrayColor()
        
        return label
    }()
    ///注册按钮
   private lazy var registerBut:UIButton={
        
        let but = UIButton()
        but.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        but.setTitle("注册", forState: UIControlState.Normal)
        but.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        but.addTarget(self, action: "clickRegister", forControlEvents: UIControlEvents.TouchUpInside)
        return but
        }()
    ///登录按钮
   private lazy var loginBut:UIButton={
        
        let but = UIButton()
        but.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        but.setTitle("登录", forState: UIControlState.Normal)
        but.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        but.addTarget(self, action: "clickLogin", forControlEvents: UIControlEvents.TouchUpInside)
        return but
        }()
    
    ///非主界面按钮
   private lazy var nonLoginBut:UIButton={
        
        let but = UIButton()
        but.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        but.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        
        return but
        }()
    
}

    