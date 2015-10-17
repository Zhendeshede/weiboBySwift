//
//  NewfeatureViewController.swift
//  新浪微博
//
//  Created by 李旭飞 on 15/10/15.
//  Copyright © 2015年 lee. All rights reserved.
//

import UIKit

class NewfeatureViewController: UICollectionViewController {

    
    private let identifity="Cell"
    private let imageCount=4
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.backgroundColor=UIColor.whiteColor()
        self.collectionView!.registerClass(NewfeatureCell.self, forCellWithReuseIdentifier: identifity)

    }
    
    //MARK:- 隐藏状态栏
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    private let layout=NewfeatureLayout()
    
    
    //MARK:- 重写构造方法
    init(){
    super.init(collectionViewLayout: layout)
    
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        return imageCount

    }
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
      let cell=collectionView.dequeueReusableCellWithReuseIdentifier(identifity, forIndexPath: indexPath) as! NewfeatureCell
       cell.imageIndex=indexPath.item
        
        return cell
    }
    override func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        
        

        let path=collectionView.indexPathsForVisibleItems().last!
        //判断是否是最后一页，播放动画
        if path.item==imageCount-1 {
        let cell = collectionView.cellForItemAtIndexPath(path) as! NewfeatureCell
        cell.startButtonAnimation()
        
        }
    }

}
//自定义collectionCell
 class NewfeatureCell : UICollectionViewCell {
    //MARK:- 懒加载控件
    private lazy var iconView = UIImageView()
    
    private lazy var startButton:UIButton={
        
        let but = UIButton()
        but.setBackgroundImage(UIImage(named: "new_feature_finish_button"), forState: UIControlState.Normal)
        but.setBackgroundImage(UIImage(named: "new_feature_finish_button_highlighted"), forState: UIControlState.Highlighted)
        but.setTitle("开始体验", forState: UIControlState.Normal)
        but.addTarget(self, action: "startExperience", forControlEvents: UIControlEvents.TouchUpInside)
        but.hidden=true
        return but
        }()
      func startExperience(){
    
       NSNotificationCenter.defaultCenter().postNotificationName(SwitchMainInterfaceNotification, object: true)
        
    
    }
    //MARK:- 开始体验按钮动画
    private func startButtonAnimation(){
    
        startButton.hidden=false
//        从大变小，再变大
        startButton.transform=CGAffineTransformMakeScale(0, 0)
        startButton.userInteractionEnabled=false
        UIView.animateWithDuration(1.2, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 10, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
            self.startButton.transform=CGAffineTransformIdentity
            }) { (_) -> Void in
                self.startButton.userInteractionEnabled=true
        }
        
        
        
        
        
    }
    //设置item
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupItems()
    }
    private func setupItems(){
    contentView.addSubview(iconView)
        
        iconView.translatesAutoresizingMaskIntoConstraints=false
    contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[subview]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["subview":iconView]))
    contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[subview]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["subview":iconView]))
        
        contentView.addSubview(startButton)
        startButton.translatesAutoresizingMaskIntoConstraints=false
        contentView.addConstraint(NSLayoutConstraint(item: startButton, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: startButton, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: -180))
    
        
        
    }
    required init?(coder aDecoder: NSCoder) {
          super.init(coder: aDecoder)
        setupItems()
    }
    private var imageIndex:Int = 0 {
        didSet{
        
        iconView.image=UIImage(named: "new_feature_\(imageIndex+1)")
        startButton.hidden=true

        }
        
        
        
        
        
        }



}
//自定义流水布局
private class NewfeatureLayout : UICollectionViewFlowLayout{

    private override func prepareLayout() {
     itemSize=collectionView!.bounds.size
      minimumLineSpacing=0
    minimumInteritemSpacing=0
    scrollDirection=UICollectionViewScrollDirection.Horizontal
     collectionView?.bounces=false
     collectionView?.pagingEnabled=true
        collectionView?.showsHorizontalScrollIndicator=true
        
    }


}