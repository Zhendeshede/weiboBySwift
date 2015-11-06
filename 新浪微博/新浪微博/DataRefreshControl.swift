//
//  DataRefreshControl.swift
//  新浪微博
//
//  Created by 李旭飞 on 15/10/28.
//  Copyright © 2015年 lee. All rights reserved.
//

import UIKit



private let offsetY:CGFloat = -60
class DataRefreshControl: UIRefreshControl {


    


    override func endRefreshing() {
       
        super.endRefreshing()
       

        refLoad.stopRptate()
         refPull.hidden = false
     

    }
        
    
    
    
    //MARK:- 监听方法
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if frame.origin.y > 0{
            return
        }
        
        if refreshing{
        refPull.hidden = true
        refLoad.startRotate()
        
        }
       
        if frame.origin.y < offsetY && refPull.rotateFlog == true{
            refPull.rotateFlog = false
            
        }else if frame.origin.y > offsetY && refPull.rotateFlog == false{
           refPull.rotateFlog = true
        
        }
        
        
        
    }
    

    override init(){
    super.init()
    
    setupSubviews()
    }

    private func setupSubviews(){
    
        tintColor = UIColor.clearColor()
        addSubview(refLoad)
        addSubview(refPull)
        addObserver(self, forKeyPath: "frame", options: NSKeyValueObservingOptions.New, context: nil)
        refLoad.ff_Fill(self)
        refPull.ff_Fill(self)
    
    }
    
    deinit{
    
    removeObserver(self, forKeyPath: "frame")
    
    }
    
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }
    
    
    
    private lazy var refLoad:RefreshView = RefreshView(title: "正在刷新", img:"tableview_loading")

    
    private lazy var refPull:RefreshView = RefreshView(title: "下拉刷新", img:"tableview_pull_refresh")

    
    
}
class RefreshView:UIView{
    ///旋转标记
    private var rotateFlog = false{
        didSet{
        
        rotateImgV()
        
        }
    
    
    }
   ///MARK:- imgV旋转动画
    private func rotateImgV(){
        let angle = rotateFlog ? CGFloat(M_PI-0.01) : CGFloat(-M_PI+0.01)

    UIView.animateWithDuration(0.5, animations: { () -> Void in
        
        self.imgV.transform = CGAffineTransformRotate(self.imgV.transform,angle)
        }, completion: nil)
    
    }
    
    private lazy var imgV=UIImageView()
  
    init(title:String,img:String){
      //TODO:为什么呢
       super.init(frame: CGRectZero)
      imgV.image = UIImage(named: img)
       let label=UILabel(texts: title,color:UIColor.orangeColor())
        backgroundColor = UIColor.whiteColor()
        addSubview(imgV)
        addSubview(label)
        imgV.ff_AlignInner(type: ff_AlignType.CenterLeft, referView: self, size: nil, offset: CGPoint(x: 120, y: 0))
        label.ff_AlignHorizontal(type: ff_AlignType.CenterRight, referView: imgV, size: nil, offset: CGPoint(x: 30, y: 0))
        
    }
 
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK:- 刷新数据时图片旋转
    private func startRotate(){
       
        if imgV.layer.animationForKey("refresh") != nil{
        
        return
        }
        
    let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.repeatCount = MAXFLOAT
        anim.duration = 0.8
        anim.toValue = 2 * M_PI
        imgV.layer.addAnimation(anim, forKey: "refresh")
    
    
    }
    private func stopRptate(){
    
     imgV.layer.removeAllAnimations()
    
    }
    

}