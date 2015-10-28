//
//  RelayTableViewCell.swift
//  新浪微博
//
//  Created by 李旭飞 on 15/10/20.
//  Copyright © 2015年 lee. All rights reserved.
//

import UIKit
let textWidth:CGFloat = 300
class RelayTableViewCell: WeiboTableViewCell {
   override var statuses:WeiboData?{
        didSet{
        
            let name = statuses?.retweeted_status?.user?.name
            let text = statuses?.retweeted_status?.text

            relayLabel.text = " @ \(name) # \(text) "
        
        }
    
    
    }
   override func setupInterface(){
    super.setupInterface()
    
    contentView.insertSubview(backButton, belowSubview: pictureView)
    contentView.insertSubview(relayLabel, aboveSubview: backButton)

    backButton.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: contentLabel, size: nil,offset:CGPoint(x: -margin, y: margin))
    backButton.ff_AlignVertical(type: ff_AlignType.TopRight, referView: bottomView, size: nil)
    ///转发文字

    relayLabel.ff_AlignInner(type: ff_AlignType.TopLeft, referView: backButton, size: nil, offset: CGPoint(x: margin, y: margin))
    
    
    
    let constraintsList = pictureView.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: relayLabel, size: CGSize(width: textWidth, height: textWidth), offset: CGPoint(x: 0, y: margin))
          pictureWidthCon = pictureView.ff_Constraint(constraintsList, attribute: NSLayoutAttribute.Width)
          pictureHeightCon = pictureView.ff_Constraint(constraintsList, attribute: NSLayoutAttribute.Height)
          pictureTopCon = pictureView.ff_Constraint(constraintsList, attribute: NSLayoutAttribute.Top)
    
    
    

    
    }
    
    private lazy var relayLabel:UILabel = {
        
        let label = UILabel(color: UIColor.blackColor(), fontSize: 15)
        label.numberOfLines=0
        label.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width-2 * margin
        return label
        }()
    private lazy var backButton:UIButton = {
        
        let but = UIButton()
        but.backgroundColor=UIColor(white: 0.95, alpha: 1.0)
        
        return but
        
        }()
    
}
