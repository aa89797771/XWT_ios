//
//  CustomPromptBox1.swift
//  todayNews
//
//  Created by xushiqi on 2020/3/4.
//  Copyright © 2020 xushiqi. All rights reserved.
//

import UIKit
protocol CustomPromptBox1Delegate:NSObjectProtocol {
    func prompt1Cancel(value:NSInteger)
    func prompt1Confirm(value:String)
}
class CustomPromptBox1: UIView {
    //最外层的包裹框
    @IBOutlet weak var viewWrap: UIView!
    //alert的提示文字
    @IBOutlet weak var tipsContent: UILabel!
    //输入的文本
    @IBOutlet weak var inputText: UITextField!
    //取消按钮
    @IBOutlet weak var cancelBtn: UIButton!
    //确认按钮
    @IBOutlet weak var confirmBtn: UIButton!
    
    weak var delegate:CustomPromptBox1Delegate?
    
    @IBAction func cancel(_ sender: Any) {
        delegate?.prompt1Cancel(value: 1)
    }
    @IBAction func confirm(_ sender: Any) {
        delegate?.prompt1Confirm(value: inputText.text ?? "")
    }
    //设置提示内容
    func setTipsContent(value: String){
        tipsContent.text = value
    }
    
    override func layoutSubviews() {
        setUI()
    }
    //输入框输入事件 - 确认按钮不可点击,有输入数据后才可点击
    @IBAction func inputChange(_ sender: Any) {
        let inputText = sender as! UITextField
        if inputText.text?.count != 0 {
            confirmBtn.isEnabled = true
        }else{
            confirmBtn.isEnabled = false
        }
    }
    
    private func setUI(){
        viewWrap.layer.cornerRadius = customLayer(num: 3)
        viewWrap.layer.masksToBounds = true
        
        //输入框输入事件 - 确认按钮不可点击,有输入数据后才可点击
        confirmBtn.isEnabled = false
    }

}
extension CustomPromptBox1{
    class func loadFromNib()->CustomPromptBox1{
        return Bundle.main.loadNibNamed("CustomPromptBox1", owner: nil, options: nil)?[0] as! CustomPromptBox1
    }
}
