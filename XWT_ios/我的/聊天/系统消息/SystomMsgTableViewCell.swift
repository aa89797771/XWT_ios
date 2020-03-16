//
//  SystomMsgTableViewCell.swift
//  todayNews
//
//  Created by xushiqi on 2020/3/9.
//  Copyright © 2020 xushiqi. All rights reserved.
//

import UIKit
import SwiftyJSON
protocol SystomMsgCellDelegate:NSObjectProtocol {
    func seeAllToggle(isOpen:Bool, indexPathRow:Int)
}
class SystomMsgTableViewCell: UITableViewCell {
    @IBOutlet weak var dialogBox: UIView!
    @IBOutlet weak var msgTitle: UILabel!
    @IBOutlet weak var msgContent: UILabel!
    @IBOutlet weak var seeAllBtn: UIButton!
    var isOpen = false    //是否展开
    var indexPathRow = 0    //当前对话框在table中的下标
    
    weak var delegate:SystomMsgCellDelegate?
    
    @IBAction func seeAllClick(_ sender: Any) {
        delegate?.seeAllToggle(isOpen: !isOpen, indexPathRow: indexPathRow)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
//        if !self.isOpen {
//            self.msgContent.numberOfLines = 2
////            self.seeAllBtn.setTitle("全文", for: .normal)
//        }else{
//            self.msgContent.numberOfLines = 0
////            self.seeAllBtn.setTitle("收起", for: .normal)
//        }
    }
    
}
