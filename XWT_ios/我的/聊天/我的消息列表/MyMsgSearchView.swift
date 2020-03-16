//
//  MyMsgSearchView.swift
//  todayNews
//
//  Created by xushiqi on 2020/3/10.
//  Copyright © 2020 xushiqi. All rights reserved.
//

import UIKit

class MyMsgSearchView: UIView {
    @IBOutlet weak var msgCount: UILabel!
    
    
    override func layoutSubviews() {
        msgCount.layer.cornerRadius = 8
        msgCount.layer.masksToBounds = true
    }
}
extension MyMsgSearchView{
    class func loadFromNib()->MyMsgSearchView{
        return Bundle.main.loadNibNamed("MyMsgSearchView", owner: nil, options: nil)?[0] as! MyMsgSearchView
    }
}
