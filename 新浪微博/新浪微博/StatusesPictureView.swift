//
//  StatusesPictureView.swift
//  新浪微博
//
//  Created by 李旭飞 on 15/10/18.
//  Copyright © 2015年 lee. All rights reserved.
//

import UIKit
private let identifier = "collectioncell"


class StatusesPictureView: UICollectionView,UICollectionViewDataSource {
    
     var status:WeiboData?{
            didSet{
                //        "thumbnail_pic": "http://ww2.sinaimg.cn/thumbnail/62c0e6e6jw1ex5longw2fj20yi0puk0e.jpg"

               sizeToFit()
                //要刷新数据
                reloadData()
            }
            
        }
    override func sizeThatFits(size: CGSize) -> CGSize {
        return itemsizeWith()
    }
    
      func itemsizeWith()->CGSize{
        let iSize = CGSize(width: 90, height: 90)
        
        let rowCount = 3
        let margin:CGFloat = 10
        let count = status?.pictures?.count ?? 0
        
        pictureLayout.itemSize = iSize

        if count == 0{
        
        return CGSizeZero
        }
        if count == 1{
            let key = status!.pictures![0]
            let image = ImageDS.imgCache(key)
            
            var size = CGSize(width: 90, height: 90)

            if image != nil{
            size = image!.size
            
            }
            //防止出现过宽或过窄
            size.width = size.width < 40 ? 40 :size.width
            size.width = size.width > UIScreen.mainScreen().bounds.width ? 150 :size.width
         pictureLayout.itemSize = size
        return size
        }
                if count == 4{
            let w = iSize.width*2 + margin
        return CGSize(width: w, height:w )
            
        }
        let row = (count-1)/rowCount + 1
        let h = CGFloat(row) * iSize.height + CGFloat(row-1) * margin
        let w = CGFloat(rowCount) * iSize.width + CGFloat(rowCount-1) * margin

        return CGSize(width: w, height: h)
    
    }
    ///collectionview布局
    private let pictureLayout:UICollectionViewFlowLayout={
        
        let layout=UICollectionViewFlowLayout()
        layout.minimumLineSpacing=10
        layout.minimumInteritemSpacing=10
        
        return layout
        }()
        
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
            super.init(frame: frame, collectionViewLayout: pictureLayout)
            backgroundColor=UIColor(white: 0.98, alpha: 1.0)
            registerClass(StatusesCollectionCell.self, forCellWithReuseIdentifier: identifier)
            dataSource = self
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    //MARK:- 数据源方法
        func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

            return status?.pictures?.count ?? 0
    }
        func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
            let cell=collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! StatusesCollectionCell
                cell.imageURL = status!.pictures![indexPath.item]
            
            return cell
        }
        
    
}

private class StatusesCollectionCell:UICollectionViewCell{

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    
    private func setupUI(){
    
     contentView.addSubview(imgView)
    imgView.translatesAutoresizingMaskIntoConstraints=false
        let dict=["imgView":imgView]
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[imgView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[imgView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict))
        
        
    }
    var imageURL:NSURL?{
        didSet{
            
            imgView.image = nil
        
            if let img = ImageDS.imgCache(imageURL!){
            
            imgView.image = img
               
                return

            }
      
        NSURLSession.sharedSession().downloadTaskWithURL(imageURL!) { (location, _, error) -> Void in
           
            if error != nil{
                print("设置站位图片")
                return
            }
            
            let data = NSData(contentsOfURL: location!)
            let img = UIImage(data:data!)

            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.imgView.image = img
                
            })
            
            }.resume()
        }

    }
    
    private lazy var imgView:UIImageView={
        let img = UIImageView()
        
        img.contentMode = UIViewContentMode.ScaleAspectFill
        img.clipsToBounds = true
        return img
        }()
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



}