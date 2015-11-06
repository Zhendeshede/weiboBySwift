//
//  WeiboTableViewCell.swift
//  新浪微博
//
//  Created by 李旭飞 on 15/10/17.
//  Copyright © 2015年 lee. All rights reserved.
//

import UIKit
let margin:CGFloat = 8.0
class WeiboTableViewCell: UITableViewCell {

///    创建用于接收微博数据的对象
    var statuses:WeiboData?{
        didSet{
        topView.status = statuses
         contentLabel.text = statuses?.text
        pictureView.status = statuses
        pictureWidthCon?.constant = pictureView.bounds.width
            
        pictureHeightCon?.constant=pictureView.bounds.height
        pictureTopCon?.constant = pictureView.bounds.height==0 ? 0 : margin
        }
    
    }
    ///配图宽度约束
    var pictureWidthCon:NSLayoutConstraint?
    ///配图高度约束
    var pictureHeightCon:NSLayoutConstraint?
    ///配图顶部约束
    var pictureTopCon:NSLayoutConstraint?
    
    //MARK:- 计算行高
    func rowHeightAuto(status:WeiboData)->CGFloat{
      statuses=status
        //强制更新，所有控件的布局都会变化
     layoutIfNeeded()
    return CGRectGetMaxY(bottomView.frame)
    
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupInterface()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- 添加并布局控件
   func setupInterface(){
    
      contentView.addSubview(topSeparateView)
      contentView.addSubview(topView)
      contentView.addSubview(contentLabel)
       contentView.addSubview(pictureView)
       contentView.addSubview(bottomView)
 
    
        topSeparateView.ff_AlignInner(type: ff_AlignType.TopLeft, referView: contentView, size: CGSize(width:UIScreen.mainScreen().bounds.width , height: margin))
        
    
    topView.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: topSeparateView, size: nil)
    contentView.addConstraint(NSLayoutConstraint(item: topView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 51))
     
    
    
  
        contentLabel.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: topView, size: nil ,offset:CGPoint(x: margin, y: 4))
//     contentView.addConstraint(NSLayoutConstraint(item: contentLabel, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Width, multiplier: 1.0, constant: -2 * margin))
    
    
    
//    ///配图的约束
//     let constraintsList = pictureView.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: contentLabel, size: CGSize(width: 300, height: 300), offset: CGPoint(x: 0, y: margin))
//    
//      pictureWidthCon = pictureView.ff_Constraint(constraintsList, attribute: NSLayoutAttribute.Width)
//      pictureHeightCon = pictureView.ff_Constraint(constraintsList, attribute: NSLayoutAttribute.Height)
//      pictureTopCon = pictureView.ff_Constraint(constraintsList, attribute: NSLayoutAttribute.Top)
    
   
            bottomView.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: pictureView, size: CGSize(width: UIScreen.mainScreen().bounds.width, height: 44),offset:CGPoint(x: -margin, y: margin))
        
    
    
    }
    //MARK:- 懒加载控件
    private lazy var topView:StatusesTopView = StatusesTopView()
    
    /// 子类中需要的属性
    lazy var contentLabel:UILabel={
        
        let label=UILabel(color: UIColor.darkGrayColor(), fontSize: 15)
        label.numberOfLines=0
        label.preferredMaxLayoutWidth=UIScreen.mainScreen().bounds.width - 2 * margin
        
        return label
        }()
     lazy var bottomView:StatusesBottomView = StatusesBottomView()
    lazy var pictureView:StatusesPictureView = StatusesPictureView()

    ///增加cell分隔视图
    
    private lazy var topSeparateView:UIView={
        let separate = UIView()
        separate.backgroundColor=UIColor.lightGrayColor()
        
        return separate
        }()
    ///配图视图
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}




//MARK:- 微博顶部视图
private class StatusesTopView:UIView{
   private var status:WeiboData?{
        didSet{
            iconview.image=nil
            if let url = status?.user!.profile_image_url{
            


                
                NSURLSession.sharedSession().downloadTaskWithURL(NSURL(string: url)!, completionHandler: { (location, _, error) -> Void in
                    if error != nil{
                    print("网络错误")
                    return
                    }
                    let data = NSData(contentsOfURL: location!)
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.iconview.image = UIImage(data:data!)
                    })
                    
                }).resume()
                
            
            
            }else{
            
            
            iconview.image=UIImage(named: "avatar_default_big")
            }
            iconview.layer.cornerRadius = 5
            iconview.layer.masksToBounds = true
        nameLabel.text=status?.user?.name ?? ""
        vipIconView.image=status?.user?.vipImage
        memberIconView.image=status?.user?.memberImage
        
            //TODO:
            
//          let timeStr = status?.created_at?.componentsSeparatedByString(" ")[3]
//            timeLabel.text = timeStr!
            
            
           
            if status?.created_at != nil && status!.created_at != ""{
            timeLabel.text =  NSDate.Date(status!.created_at)!.dateDescription()

            }
            
            if status?.source != nil && status!.source != ""{
//           var sourceStr:String? = status?.source?.componentsSeparatedByString("<")[1]
//                sourceStr = sourceStr?.componentsSeparatedByString(">").las
//                sourceLabel.text = "来自 " + sourceStr!
                
                sourceLabel.text = "来自 " + status!.source!
            }
            
            
            
            
//         source  -> "<a href=\"http://app.weibo.com/t/feed/2o92Kh\" rel=\"nofollow\">vivo_X5Max</a>"
//         time ->  "Sun Oct 18 12:40:06 +0800 2015"
        }
    
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        
    }
    private func setupUI(){
    
        addSubview(iconview)
        addSubview(nameLabel)
        addSubview(vipIconView)
        addSubview(memberIconView)
        addSubview(timeLabel)
        addSubview(sourceLabel)
        
        //布局
        iconview.ff_AlignInner(type: ff_AlignType.TopLeft, referView: self, size: CGSizeMake(35, 35), offset: CGPointMake(margin , margin))
        nameLabel.ff_AlignHorizontal(type: ff_AlignType.TopRight, referView: iconview, size: nil, offset: CGPointMake(margin, 0))
        timeLabel.ff_AlignHorizontal(type: ff_AlignType.BottomRight, referView: vipIconView, size: nil, offset: CGPointMake(margin, 0))
        vipIconView.ff_AlignInner(type: ff_AlignType.BottomRight, referView: iconview, size: nil, offset: CGPointMake(3, 2))
        memberIconView.ff_AlignHorizontal(type: ff_AlignType.TopRight, referView: nameLabel, size: nil, offset: CGPointMake( margin,0 ))
        sourceLabel.ff_AlignHorizontal(type: ff_AlignType.BottomRight, referView: timeLabel, size: nil, offset: CGPointMake(margin, 0))
    
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//MARK:- 顶部视图懒加载控件
    ///头像
   private lazy var iconview=UIImageView()
   ///昵称
    private lazy var nameLabel:UILabel = UILabel(color: UIColor.darkGrayColor(), fontSize: 14)
    ///vip图标
    private lazy var vipIconView = UIImageView()
    ///会员图标
    private lazy var memberIconView:UIImageView = UIImageView(image: UIImage(named: "common_icon_membership_level1"))
    ///时间
    private lazy var timeLabel = UILabel(color: UIColor.orangeColor(), fontSize: 10)
    ///来源
    private lazy var sourceLabel = UILabel(color: UIColor.darkGrayColor(), fontSize: 10)

}



//MARK:- 微博底部视图
class StatusesBottomView:UIView{

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    private func  setupUI(){
        backgroundColor=UIColor(white: 0.97, alpha: 0.9)
        addSubview(retweet)
        addSubview(like)
        addSubview(comment)
    ff_HorizontalTile([like,retweet,comment], insets: UIEdgeInsets(top: 2, left: 20, bottom: 2, right: 20))
    }
       required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var retweet:UIButton = UIButton(image: "timeline_icon_retweet", title: " 评论", fontSize: 13, titleColor: UIColor.lightGrayColor())
    
    private lazy var like:UIButton = UIButton(image: "timeline_icon_unlike", title: " 赞", fontSize: 13, titleColor: UIColor.lightGrayColor())
    
    private lazy var comment:UIButton = UIButton(image: "timeline_icon_comment", title: " 回复", fontSize: 13, titleColor: UIColor.lightGrayColor())

}
