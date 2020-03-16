//
//  AddrDetailViewCellTableViewCell.swift
//  todayNews
//
//  Created by xushiqi on 2020/3/13.
//  Copyright © 2020 xushiqi. All rights reserved.
//

import UIKit

class AddrDetailViewCellTableViewCell: UITableViewCell {
    //左侧详细地址label说明
    @IBOutlet weak var labelLeft: UILabel!
    //地址详情label
    @IBOutlet weak var addrDetailLabel: UILabel!
    //地址详情输入框
    @IBOutlet weak var addrDetailText: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        addrDetailText.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
//AddrDetailViewCellTableViewCell:UITextViewDelegate{
//
//}
