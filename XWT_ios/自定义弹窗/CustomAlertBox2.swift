//
//  CustomAlertBox2.swift
//  todayNews
//
//  Created by xushiqi on 2020/3/4.
//  Copyright © 2020 xushiqi. All rights reserved.
//

import UIKit

protocol CustomAlertBox2Delegate:NSObjectProtocol {
    func Alert2Cancel(value:NSInteger)
    func Alert2Confirm(value:NSInteger)
}

class CustomAlertBox2: UIView {
    //最外层的包裹框
    @IBOutlet weak var viewWrap: UIView!
    //alert的提示文字
    @IBOutlet weak var tipsContent: UILabel!
    //确认按钮
    @IBOutlet weak var confirmBtn: UIButton!
    
    weak var delegate:CustomAlertBox2Delegate?
    
    @IBAction func cancel(_ sender: Any) {
        delegate?.Alert2Cancel(value: 1)
    }
    @IBAction func confirm(_ sender: Any) {
        delegate?.Alert2Confirm(value: 1)
    }
    //设置提示内容
    func setTipsContent(value: String){
        tipsContent.text = value
    }
    override func layoutSubviews() {
        setUI()
    }
    
    private func setUI(){

    }
}
extension CustomAlertBox2{
    class func loadFromNib()->CustomAlertBox2{
        return Bundle.main.loadNibNamed("CustomAlertBox2", owner: nil, options: nil)?[0] as! CustomAlertBox2
    }
}
