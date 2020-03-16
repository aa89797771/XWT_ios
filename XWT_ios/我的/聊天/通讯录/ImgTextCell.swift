//
//  ImgTextCell.swift
//  todayNews
//
//  Created by xushiqi on 2020/3/6.
//  Copyright © 2020 xushiqi. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher

class ImgTextCell: UITableViewCell {
    @IBOutlet weak var userHeader: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // cell赋值
    public func cellData(value: SortObjectModel) {
        self.userHeader?.kf.setImage(with: URL(string: value.imgUrl!), placeholder: UIImage(named: "iconuser"), options: nil, progressBlock: nil, completionHandler: nil)
        self.userName.text = value.objValue!
    }
}
