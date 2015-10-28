//
//  HomeTitleButton.swift
//  新浪微博
//
//  Created by 李旭飞 on 15/10/17.
//  Copyright © 2015年 lee. All rights reserved.
//

import UIKit

class HomeTitleButton: UIButton {
    init(title:String){
        //只能写frame
        super.init(frame:CGRectZero)
        setTitle(title + " ", forState: UIControlState.Normal)
        setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        setImage(UIImage(named: "navigationbar_arrow_down"), forState: UIControlState.Normal)
        setImage(UIImage(named: "navigationbar_arrow_up"), forState: UIControlState.Selected)
        sizeToFit()
        
    
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()

        titleLabel?.frame.origin.x=0
        imageView?.frame.origin.x=titleLabel?.bounds.width ?? 0
    }
    
}
