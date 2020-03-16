//
//  MyMsgTableViewCell.swift
//  todayNews
//
//  Created by xushiqi on 2020/3/10.
//  Copyright © 2020 xushiqi. All rights reserved.
//

import UIKit
import SwiftyJSON

class MyMsgTableViewCell: UITableViewCell {
    //头像
    @IBOutlet weak var headerImg: UIImageView!
    //名字
    @IBOutlet weak var name: UILabel!
    //内容
    @IBOutlet weak var content: UILabel!
    //时间
    @IBOutlet weak var time: UILabel!
    //未读消息数量
    @IBOutlet weak var msgCount: UILabel!
    
    override func layoutSubviews() {
        setUI()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setUI(){
        //未读消息 圆角
        msgCount.layer.cornerRadius = 8
        msgCount.layer.masksToBounds = true
    }
    
    //cell赋值操作
    public func setCellData(data:JSON){
        self.headerImg.kf.setImage(with: URL(string: data["url"].stringValue), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        name.text = data["name"].stringValue
        
        //内容字符串前需要拼接 [已读] [未读] 信息
        //content.text = data["content"].stringValue
        let isRead = data["isRead"].boolValue
        let prefixContent = isRead ? "[已读]" : "[未读]"
        let contentMain = data["content"].stringValue
        content.attributedText = getAttributedString(title: prefixContent,
            subtitle: contentMain,
            isRead: isRead)
        
        //时间
        time.text = data["time"].stringValue
        
        //小气泡 - 未读信息数
        if data["count"].stringValue == "" {
            msgCount.isHidden = true
        }else{
            msgCount.text = "  \(data["count"].stringValue)  "
        }
        
    }
    //获取条目属性文本
    func getAttributedString(title: String, subtitle: String, isRead: Bool) -> NSAttributedString {
        //字体1样式 - 已读为灰色 - 未读为蓝色
        var titleColor = RGBColor(r: 41, g: 99, b: 190)
        if isRead {
            titleColor = RGBColor(r: 153, g: 153, b: 153)
        }
        let titleAttributes =
            [ NSAttributedString.Key.foregroundColor: titleColor]
        
        //字体2样式
        let subtitleColor = RGBColor(r: 153, g: 153, b: 153)
        let subtitleAttributes =
            [NSAttributedString.Key.foregroundColor: subtitleColor]
        
        //拼接并获取最终文本
        let titleString = NSMutableAttributedString(string: title,
            attributes: titleAttributes)
        let subtitleString = NSAttributedString(string: subtitle,
                                                attributes: subtitleAttributes)
        titleString.append(subtitleString)
        return titleString
    }
}

