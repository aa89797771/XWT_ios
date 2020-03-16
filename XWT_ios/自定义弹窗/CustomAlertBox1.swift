//
//  CustomAlert.swift
//  todayNews CustomAlertBox1Delegate
//
//  Created by xushiqi on 2020/3/4.
//  Copyright © 2020 xushiqi. All rights reserved.
//

import UIKit


protocol CustomAlertBox1Delegate:NSObjectProtocol {
    func Alert1Cancel(value:NSInteger)
    func Alert1Confirm(value:NSInteger)
}

class CustomAlertBox1: UIView {

    //最外层的包裹框
    @IBOutlet weak var viewWrap: UIView!
    //alert的提示文字
    @IBOutlet weak var tipsContent: UILabel!
    //取消按钮
    @IBOutlet weak var cancelBtn: UIButton!
    //确认按钮
    @IBOutlet weak var confirmBtn: UIButton!
    
    weak var delegate:CustomAlertBox1Delegate?
    
    @IBAction func cancel(_ sender: Any) {
        delegate?.Alert1Cancel(value: 1)
    }
    @IBAction func confirm(_ sender: Any) {
        delegate?.Alert1Confirm(value: 1)
    }
    //设置提示内容
    func setTipsContent(value: String){
        tipsContent.text = value
    }
    
    override func layoutSubviews() {
        setUI()
    }
    
    private func setUI(){
        viewWrap.layer.cornerRadius = customLayer(num: 3)
        viewWrap.layer.masksToBounds = true
        
        cancelBtn.layer.cornerRadius = customLayer(num: 3)
        cancelBtn.layer.masksToBounds = true
        
        confirmBtn.layer.cornerRadius = customLayer(num: 3)
        confirmBtn.layer.masksToBounds = true
    }
}

extension CustomAlertBox1{
    class func loadFromNib()->CustomAlertBox1{
        return Bundle.main.loadNibNamed("CustomAlertBox1", owner: nil, options: nil)?[0] as! CustomAlertBox1
    }
}
