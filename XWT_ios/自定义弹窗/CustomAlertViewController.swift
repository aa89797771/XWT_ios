//
//  CustomAlertViewController.swift
//  todayNews
//
//  Created by xushiqi on 2020/3/4.
//  Copyright © 2020 xushiqi. All rights reserved.
//

import UIKit

//自定义弹窗
class CustomAlertViewController: UIViewController {
    //弹窗1 - 懒加载的话标题改不了
    private var customAlertBox1:CustomAlertBox1?
    private var customAlertBox1W = 250
    private var customAlertBox1H = 180
    
    //弹窗3
    private var customAlertBox2:CustomAlertBox2?
    private var customAlertBox2W = 255
    private var customAlertBox2H = 146
    
    //弹窗Prompt1
    private var customPromptBox1:CustomPromptBox1?
    private var customPromptBox1W = 255
    private var customPromptBox1H = 146
    
    
    
    //确认事件回调函数
    private var customConfirmCallback : ((_ text:String) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //模态背景
        KeyWindow!.addSubview(grayView)
    }
    
    //model层
    private lazy var grayView:UIView = {
        let gray = UIView(frame: KeyWindow!.bounds)
        gray.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.5)
        gray.alpha = 0
        
        return gray
    }()
    
    
}

//弹窗1
//是否确认清楚缓存
extension CustomAlertViewController:CustomAlertBox1Delegate{
    //显示alert弹窗1
    public func showCustomAlertView1(title: String,confirm: @escaping (String) -> ()){
        //回调函数赋值在当前页 - 代理方法中调用
        customConfirmCallback = confirm
        
        //init弹窗样式
        let alertBox = CustomAlertBox1.loadFromNib()
        alertBox.center = CGPoint(x: kScreenW/2, y: kScreenH + CGFloat(customAlertBox1H/2))
        alertBox.setTipsContent(value: title)
        alertBox.delegate = self
        customAlertBox1 =  alertBox
        KeyWindow!.addSubview(customAlertBox1!)
        
        //从下往上显示
        UIView.animate(withDuration: 0.3) {
            //登陆弹窗滚动显示
            self.customAlertBox1!.center = CGPoint(x: kScreenW/2, y: kScreenH/2 - 40)
            self.grayView.alpha = 1
        }
    }
    //隐藏alert弹窗1
    public func hideCustomAlertView1(){
        UIView.animate(withDuration: 0.3) {
            //登陆弹窗滚动显示
            self.customAlertBox1!.center = CGPoint(x: kScreenW/2, y: kScreenH + CGFloat(self.customAlertBox1H/2))
            self.grayView.alpha = 0
        }
    }
    
    //取消事件
    func Alert1Cancel(value: NSInteger) {
        //隐藏弹窗
        hideCustomAlertView1()
    }
    
    //确认事件
    func Alert1Confirm(value: NSInteger) {
        //隐藏弹窗
        hideCustomAlertView1()
        //确认回调事件的触发
        customConfirmCallback!("弹窗1")
    }
}


//弹窗2
//含输入框 - 修改邮箱前的输入密码事件
extension CustomAlertViewController:CustomPromptBox1Delegate{
    //显示alert弹窗2
    public func showCustomPromptBox1(title: String,confirm: @escaping (String) -> ()){
        //回调函数赋值在当前页 - 代理方法中调用
        customConfirmCallback = confirm
        
        //init弹窗样式
        let alertBox = CustomPromptBox1.loadFromNib()
        alertBox.center = CGPoint(x: kScreenW/2, y: kScreenH + CGFloat(customPromptBox1H/2))
        alertBox.setTipsContent(value: title)
        alertBox.delegate = self
        customPromptBox1 =  alertBox
        KeyWindow!.addSubview(customPromptBox1!)
        
        //从下往上显示
        UIView.animate(withDuration: 0.3) {
            //登陆弹窗滚动显示
            self.customPromptBox1!.center = CGPoint(x: kScreenW/2, y: kScreenH/2 - 40)
            self.grayView.alpha = 1
        }
    }
    //隐藏alert弹窗2
    public func hideCustomPromptBox1(){
        UIView.animate(withDuration: 0.3) {
            //登陆弹窗滚动显示
            self.customPromptBox1!.center = CGPoint(x: kScreenW/2, y: kScreenH + CGFloat(self.customPromptBox1H/2))
            self.grayView.alpha = 0
        }
    }
    func prompt1Cancel(value: NSInteger) {
        //隐藏弹窗
        hideCustomPromptBox1()
    }
    
    func prompt1Confirm(value: String) {
        //隐藏弹窗
        hideCustomPromptBox1()
        //确认回调事件的触发
        customConfirmCallback!(value)
    }
}


//弹窗3
//是否确认清楚缓存
extension CustomAlertViewController:CustomAlertBox2Delegate{
    //显示alert弹窗3
    public func showCustomAlertView2(title: String,confirm: @escaping (String) -> ()){
        //回调函数赋值在当前页 - 代理方法中调用
        customConfirmCallback = confirm
        
        //init弹窗样式
        let alertBox = CustomAlertBox2.loadFromNib()
        alertBox.center = CGPoint(x: kScreenW/2, y: kScreenH + CGFloat(customAlertBox2H/2))
        alertBox.setTipsContent(value: title)
        alertBox.delegate = self
        customAlertBox2 =  alertBox
        KeyWindow!.addSubview(customAlertBox2!)
        
        //从下往上显示
        UIView.animate(withDuration: 0.3) {
            //登陆弹窗滚动显示
            self.customAlertBox2!.center = CGPoint(x: kScreenW/2, y: kScreenH/2 - 40)
            self.grayView.alpha = 1
        }
    }
    //隐藏alert弹窗3
    public func hideCustomAlertView2(){
        UIView.animate(withDuration: 0.3) {
            //登陆弹窗滚动显示
            self.customAlertBox2!.center = CGPoint(x: kScreenW/2, y: kScreenH + CGFloat(self.customAlertBox2H/2))
            self.grayView.alpha = 0
        }
    }
    
    //取消事件
    func Alert2Cancel(value: NSInteger) {
        //隐藏弹窗
        hideCustomAlertView2()
    }
    
    //确认事件
    func Alert2Confirm(value: NSInteger) {
        //隐藏弹窗
        hideCustomAlertView2()
        //确认回调事件的触发
        customConfirmCallback!("弹窗3")
    }
}
