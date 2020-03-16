//
//  MsgTipsTableViewCell.swift
//  todayNews
//
//  Created by xushiqi on 2020/3/11.
//  Copyright © 2020 xushiqi. All rights reserved.
//

import UIKit
import SwiftyJSON

class MsgTipsTableViewCell: UITableViewCell {
    @IBOutlet weak var tips: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    //cell赋值操作
    public func setCellData(data:JSON){
        self.tips.text = data["tipsContent"].stringValue
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
