//
//  TestTableViewCell1.swift
//  todayNews
//
//  Created by xushiqi on 2020/3/6.
//  Copyright © 2020 xushiqi. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher

class TestTableViewCell1: UITableViewCell {
    @IBOutlet weak var userHeader: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // cell赋值
    public func cellData(value: SortObjectModel) {
        self.userHeader?.kf.setImage(with: URL(string: value.imgUrl!), placeholder: UIImage(named: "iconuser"), options: nil, progressBlock: nil, completionHandler: nil)
        self.userName.text = value.objValue!
    }
}
