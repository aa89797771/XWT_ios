//
//  HeadMineView.swift
//  todayNews
//
//  Created by xushiqi on 2020/3/5.
//  Copyright © 2020 xushiqi. All rights reserved.
//

import UIKit

class HeadMineView: UIView {

    @IBOutlet weak var wrapView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBAction func testClick(_ sender: Any) {
        print("click")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
extension HeadMineView{
    class func loadFromNib()->HeadMineView{
        return Bundle.main.loadNibNamed("HeadMineView", owner: nil, options: nil)?[0] as! HeadMineView
    }
}
