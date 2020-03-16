//
//  HeadMineBoxView.swift
//  todayNews
//
//  Created by xushiqi on 2020/3/12.
//  Copyright © 2020 xushiqi. All rights reserved.
//

import UIKit

class HeadMineBoxView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
extension HeadMineBoxView{
    class func loadFromNib()->HeadMineBoxView{
        return Bundle.main.loadNibNamed("HeadMineBoxView", owner: nil, options: nil)?[0] as! HeadMineBoxView
    }
}
