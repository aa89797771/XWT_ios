//
//  ChangeTextViewController.swift
//  todayNews
//
//  Created by xushiqi on 2020/3/12.
//  Copyright © 2020 xushiqi. All rights reserved.
//

import UIKit

class ChangeTextViewController: CustomAlertViewController {
    //nav右侧保存按钮是否可点击
    var isBtnEnabled = false
    //修改类型 - 1.昵称 - 2.公司名
    var type = 1
    //文本输入框
    @IBOutlet weak var nameText: UITextField!
    //文本输入框 底部边线
    @IBOutlet weak var borderBottom: UILabel!
    
    //文本输入框 输入事件
    @IBAction func inputNameText(_ sender: Any) {
        let btn = sender as! UITextField
        //选中区域 - 实行光标图片的定位?
        print(nameText.selectedTextRange!)
        //手机号码格式正确时,发送验证码按钮才可点击
        //test - 判断条件需改变
        if btn.text!.count > 0 {
            if !self.isBtnEnabled{
                self.isBtnEnabled = true
                self.navigationItem.rightBarButtonItem = self.createRightBtn(isEnabled: self.isBtnEnabled)
            }
        }else{
            if self.isBtnEnabled{
                self.isBtnEnabled = false
                self.navigationItem.rightBarButtonItem = self.createRightBtn(isEnabled: self.isBtnEnabled)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.type == 1{
            self.navigationItem.title="更改昵称"
            self.nameText.text = "无敌火箭队少女"
        }else if self.type == 2{
            self.navigationItem.title="更改公司名称"
            self.nameText.text = "温州新联实业有限公司"
        }
        //导航栏 自定义设置
        setNavBarStyle()
        
        setUI()
    }
    
    //手指触控事件
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //input退出编辑状态
        self.view.endEditing(true)
    }
    
    private func setUI(){
        //光标颜色
        nameText.tintColor = RGBColor(r: 245, g: 92, b: 82)
        nameText.delegate = self
    }
    
}

//导航栏 自定义设置
extension ChangeTextViewController{
    // 设置导航栏 返回按钮
    private func setNavBarStyle(){
        
        // 隐藏导航栏下面的黑线
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.view.backgroundColor = UIColor.white
        // 隐藏系统返回按钮
        self.navigationController?.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        // 自定义返回按钮样式
        let leftBtn:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "iconjiantou")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(actionBack))
        self.navigationItem.leftBarButtonItem = leftBtn
        
        //创建nav 右侧按钮
        self.navigationItem.rightBarButtonItem = createRightBtn(isEnabled: self.isBtnEnabled)
    }
    
    //返回按钮事件
    @objc func actionBack(){
        self.navigationController?.popViewController(animated: true);
    }
    
    //创建nav 右侧按钮
    func createRightBtn(isEnabled: Bool) -> UIBarButtonItem {
        print("创建nav 右侧按钮")
        let btnCustom:UIButton = UIButton.init(frame: CGRect(x: 40, y: 0, width: customLayer(num: 60), height: customLayer(num: 24)))
        btnCustom.setTitle("保存", for: .normal)
        if isEnabled {
            btnCustom.setTitleColor(RGBColor(r: 255, g: 255, b: 255), for: .normal)
            btnCustom.backgroundColor = RGBColor(r: 245, g: 92, b: 82)
        }else{
            btnCustom.setTitleColor(RGBColor(r: 102, g: 102, b: 102), for: .normal)
            btnCustom.backgroundColor = RGBColor(r: 221, g: 221, b: 221)
        }
        
        btnCustom.titleLabel?.font = customFont(font: 13)
        btnCustom.layer.cornerRadius = customLayer(num: 12)
        btnCustom.layer.masksToBounds = true
        btnCustom.addTarget(self, action: #selector(save), for: .touchUpInside)
        btnCustom.isUserInteractionEnabled = isEnabled
        let rightBtn:UIBarButtonItem = UIBarButtonItem(customView: btnCustom)

        return rightBtn
    }
    
    //保存事件
    @objc func save(){
        showCustomAlertView1(title: "是否确认保存？") { (value) in
            self.isBtnEnabled = false
            //移除添加好友按钮
           
            print("模拟保存成功")
            self.isBtnEnabled = false
            self.navigationItem.rightBarButtonItem = self.createRightBtn(isEnabled: self.isBtnEnabled)
        }
    }
}

//输入框代理事件
extension ChangeTextViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("focus")
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("endEditing")
    }
}
