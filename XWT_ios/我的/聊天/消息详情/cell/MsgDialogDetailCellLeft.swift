//
//  MsgDialogDetailCellLeft.swift
//  todayNews
//
//  Created by xushiqi on 2020/3/10.
//  Copyright © 2020 xushiqi. All rights reserved.
//

import UIKit
import SwiftyJSON

class MsgDialogDetailCellLeft: UITableViewCell {
    @IBOutlet weak var header: UIImageView!
    @IBOutlet weak var contentBox: UIView!
    @IBOutlet weak var contentText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentBox.snp_makeConstraints{(make) in
            make.top.equalTo(contentText).offset(-10)
            make.right.equalTo(contentText).offset(10)
            make.left.equalTo(contentText).offset(-10)
            make.bottom.equalTo(contentText).offset(10)
        }
    }
    
    //cell赋值操作
    public func setCellData(data:JSON){
        self.header.kf.setImage(with: URL(string: data["url"].stringValue), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        self.contentText.text = data["content"].stringValue
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
