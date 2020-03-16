//
//  DialogInputBarView.swift
//  todayNews
//
//  Created by xushiqi on 2020/3/11.
//  Copyright © 2020 xushiqi. All rights reserved.
//

import UIKit

protocol DiaLogInputBarDelegate: NSObjectProtocol {
    func send(type: Int, value: String)
}
class DialogInputBarView: UIView {
    @IBOutlet weak var inputText: UITextField!
    
    weak var delegate:DiaLogInputBarDelegate?
    
    @IBAction func emojiBtnClick(_ sender: Any) {
        print("添加表情")
    }
    @IBAction func addOtherClick(_ sender: Any) {
        print("添加其他")
    }
    
    override func layoutSubviews() {
        inputText.delegate = self
        inputText.returnKeyType = .send
    }
}
extension DialogInputBarView{
    class func loadFromNib()->DialogInputBarView{
        return Bundle.main.loadNibNamed("DialogInputBarView", owner: nil, options: nil)?[0] as! DialogInputBarView
    }
}

//键盘按钮点击事件
extension DialogInputBarView:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("send2")
        textField.resignFirstResponder()
        
        delegate?.send(type: 1, value: inputText.text!)
        inputText.text = ""
        return true
    }
}
