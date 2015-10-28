//
//  originateTableViewCell.swift
//  新浪微博
//
//  Created by 李旭飞 on 15/10/20.
//  Copyright © 2015年 lee. All rights reserved.
//

import UIKit

class originateTableViewCell: WeiboTableViewCell {

    override func setupInterface() {
    
        super.setupInterface()
            ///配图的约束
             let constraintsList = pictureView.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: contentLabel, size: CGSize(width: textWidth, height: textWidth), offset: CGPoint(x: 0, y: margin))
        
              pictureWidthCon = pictureView.ff_Constraint(constraintsList, attribute: NSLayoutAttribute.Width)
              pictureHeightCon = pictureView.ff_Constraint(constraintsList, attribute: NSLayoutAttribute.Height)
              pictureTopCon = pictureView.ff_Constraint(constraintsList, attribute: NSLayoutAttribute.Top)
        
        
    }
}
