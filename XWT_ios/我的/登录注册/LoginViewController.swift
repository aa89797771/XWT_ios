//
//  LoginViewController.swift
//  todayNews
//
//  Created by xushiqi on 2020/3/2.
//  Copyright © 2020 xushiqi. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginViewController: FathViewController {
    //登录类型: (1)账号登录、(2)验证码登录
    var loginType = 1
    
    //发请求时的参数
    var requestData = [String: Any]()
    
    //账号登录view
    @IBOutlet weak var accountLoginView: UIView!
    //账号输入框
    @IBOutlet weak var accountInputView: UIView!
    @IBOutlet weak var accountInputText: UITextField!
    @IBOutlet weak var accountInputBorder: UILabel!
    @IBOutlet weak var accountErrorInfo: UILabel!
    //密码输入框
    @IBOutlet weak var accountPsdView: UIView!
    @IBOutlet weak var accountPsdText: UITextField!
    @IBOutlet weak var showPsdBtn: UIButton!
    @IBOutlet weak var accountPsdBorder: UILabel!
    
    //验证码登录view
    @IBOutlet weak var codeLoginView: UIView!
    //手机号输入框
    @IBOutlet weak var phoneInputView: UIView!
    @IBOutlet weak var phoneInputText: UITextField!
    @IBOutlet weak var phoneInputBorder: UILabel!
    @IBOutlet weak var phoneErrorInfo: UILabel!
    
    //验证码输入框
    @IBOutlet weak var codeInputView: UIView!
    @IBOutlet weak var codeInputText: UITextField!
    @IBOutlet weak var getCodeBtn: UIButton!
    
    //登录按钮
    @IBOutlet weak var loginBtn: UIButton!
    //忘记密码按钮
    @IBOutlet weak var forgetPsdBtn: UIButton!
    //去手机注册按钮
    @IBOutlet weak var toRegisterBtn: UIButton!
    //其他登录方式
    @IBOutlet weak var otherLoginTypeView: UIView!
    
    
    //其他登录方式 - 微信登录\验证码登录\账号登录
    @IBOutlet weak var otherLoginType_XW: UIView!
    @IBOutlet weak var otherLoginType_code: UIView!
    @IBOutlet weak var otherLoginType_account: UIView!
    
    //提示文字 同意协议
    @IBOutlet weak var privacyTipsView: UIView!
    //用户协议按钮
    @IBOutlet weak var agreementBtn: UIButton!
    //隐私条款按钮
    @IBOutlet weak var privacyBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        self.navigationItem.title = "登录"
    }
    //手指触控事件
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //input退出编辑状态
        self.view.endEditing(true)
    }
}

//账号、密码、登录相关
extension LoginViewController{
    //账号输入事件
    @IBAction func inputAccount(_ sender: Any) {
        let btn = sender as! UITextField
        print(btn.text!)
        
        //只要输入,错误信息就重置
        self.accountErrorInfo.isHidden = true
        self.accountInputBorder.backgroundColor = RGBColor(r: 221, g: 221, b: 221)

        //判断登录按钮是否可点击
        judgeLoginBtnEnabled(type: 1)
    }
    //密码输入事件
    @IBAction func inputPsd(_ sender: Any) {
        let btn = sender as! UITextField
        print(btn.text!)
        //判断登录按钮是否可点击
        judgeLoginBtnEnabled(type: 1)
    }
    //判断登录按钮是否可点击
    //type(1):进行判断操作 (2):直接赋值为不可点击
    private func judgeLoginBtnEnabled(type: NSInteger){
        if type == 1{
            //输入框有错误信息时,不可点击
            if !accountErrorInfo.isHidden || !phoneErrorInfo.isHidden{
                //登录按钮灰色显示
                loginBtn.backgroundColor = RGBColor(r: 221, g: 221, b: 221)
                loginBtn.isEnabled = false
            }else
            //test - 判断条件需改变
            if (phoneInputText.text!.count > 0 && codeInputText.text!.count > 0) || (accountInputText.text!.count > 0 && accountPsdText.text!.count > 0){
                //登录按钮可点击 - 渐变色显示
                loginBtn.isEnabled = true
//                gradientBtn(loginBtn, 22)
                loginBtn.backgroundColor = RGBColor(r: 245, g: 82, b: 1)
            }else{
                //登录按钮灰色显示
                loginBtn.backgroundColor = RGBColor(r: 221, g: 221, b: 221)
                loginBtn.isEnabled = false
            }
        }else if type == 2{
            //登录按钮灰色显示
            loginBtn.backgroundColor = RGBColor(r: 221, g: 221, b: 221)
            loginBtn.isEnabled = false
        }
    }
    
    //登录按钮点击
    @IBAction func loginClick(_ sender: Any) {
        print("login")
    }
}

//手机号码、验证码 相关事件
extension LoginViewController{
    //手机号码输入事件
    @IBAction func inputPhone(_ sender: Any) {
        let btn = sender as! UITextField
        print(btn.text!)
        //手机号码格式正确时,发送验证码按钮才可点击
        //test - 判断条件需改变
        if btn.text!.count > 0 {
            changeStyle_getCodeBtn(type: 1)
        }else{
            changeStyle_getCodeBtn(type: 2)
        }
        
        //只要输入,错误信息就重置
        self.phoneErrorInfo.isHidden = true
        self.phoneInputBorder.backgroundColor = RGBColor(r: 221, g: 221, b: 221)

        //判断登录按钮是否可点击
        judgeLoginBtnEnabled(type: 1)
    }
    //验证码输入事件
    @IBAction func inputCode(_ sender: Any) {
        let btn = sender as! UITextField
        print(btn.text!)
        //判断登录按钮是否可点击
        judgeLoginBtnEnabled(type: 1)
    }
    
    //点击发送验证码事件
    @IBAction func getCodeClick(_ sender: Any) {
        print("发送验证码")
        //点击后改为不可点击状态
        changeStyle_getCodeBtn(type: 2)
        
        //倒计时用
        var remainCount:Int = 6{
            willSet{
                getCodeBtn.setTitle("重新发送\((newValue))", for: .normal)
                if newValue<=0{
                    getCodeBtn.setTitle("发送验证码", for: .normal)
                }
            }
        }
        //计时器
        let codeTimer = DispatchSource.makeTimerSource()
        codeTimer.schedule(deadline: .now(), repeating: .seconds(1))
        codeTimer.setEventHandler {
            DispatchQueue.main.async {
                remainCount -= 1
                if remainCount<=0{
                    codeTimer.cancel()
                    self.changeStyle_getCodeBtn(type: 1)
                }
            }
        }
        codeTimer.resume()
        
        //发起获取验证码请求
        getCodeRequest()
    }
    //发起获取验证码请求
    //test
    func getCodeRequest(){
        let phone = phoneInputText.text!
        requestData = ["countryCode":86,"fromSite":"xwt","phone":phone]
        HttpDatas.shareInstance.requestDatas(.post, URLString: "http://xwt.xiegg.cn/sso/member/valid_phone/send_short_message", parameters: requestData ) { (res) in
            
            print("请求code成功")
            print(res)
            let jsonData = JSON(res)
        //                    jsonData["code"].stringValue == "100"
            print("jsonData = \(jsonData)")
            if jsonData["ret"].stringValue != "1"{
                print("请求code的ret != 1")
                return
            }
            print("请求code的ret = 1")
        }
    }
    
    //改变 发送验证码 按钮的样式
    //type(1):可以点击 (2):不可点击 (3):倒计时
    private func changeStyle_getCodeBtn(type: NSInteger){
        //初始化发送验证码按钮 样式
        getCodeBtn.layer.cornerRadius = 12.5
        getCodeBtn.layer.borderWidth = 1
        getCodeBtn.layer.masksToBounds = true
        
        //可以使用
        if type == 1{
            getCodeBtn.isEnabled = true
            getCodeBtn.backgroundColor = RGBColor(r: 245, g: 92, b: 82)
            getCodeBtn.layer.borderColor = RGBColor(r: 245, g: 92, b: 82).cgColor
        //手机号未填写 - 按钮为灰色
        }else if type == 2{
            getCodeBtn.isEnabled = false
            getCodeBtn.backgroundColor = RGBColor(r: 221, g: 221, b: 221)
            getCodeBtn.layer.borderColor = RGBColor(r: 221, g: 221, b: 221).cgColor
        }
    }
}

//辅助函数
extension LoginViewController{
    private func setUI(){
        //隐藏navbar、tabbar
        createHiddenNavTabBar(self, isShow: false)
        
        //显示账号登录
        accountLoginView.isHidden = false
        codeLoginView.isHidden = true
        
        //账号、密码输入框
        accountInputText.delegate = self
        accountInputText.tag = 1
        accountPsdText.delegate = self
        accountPsdText.tag = 2
        
        //手机号、验证码输入框
        phoneInputText.delegate = self
        phoneInputText.tag = 11
        codeInputText.delegate = self
        codeInputText.tag = 12
        
        //初始化(重置)全部错误信息 及 数据
        resetErrorInfo()
        
        //密码密文显示
        accountPsdText.isSecureTextEntry = true
        
        //发送验证码按钮 样式
        changeStyle_getCodeBtn(type: 2)
        
        //登录按钮灰色显示
        loginBtn.backgroundColor = RGBColor(r: 221, g: 221, b: 221)
        loginBtn.isEnabled = false
        
        //其他登录方式 - 密码登录按钮隐藏(显示验证码登录按钮)
        otherLoginType_account.isHidden = true
    }
    
    //初始化(重置)全部错误信息 及 数据
    func resetErrorInfo(){
        //重置账号、密码
        self.accountInputText.text = ""
        self.accountErrorInfo.isHidden = true
        self.accountInputBorder.backgroundColor = RGBColor(r: 221, g: 221, b: 221)
        self.accountPsdText.text = ""
        
        //重置手机号、验证码
        self.phoneInputText.text = ""
        self.phoneErrorInfo.isHidden = true
        self.phoneInputBorder.backgroundColor = RGBColor(r: 221, g: 221, b: 221)
        self.codeInputText.text = ""
    }
    
    //点击切换密码明文
    @IBAction func showPsdClick(_ sender: Any) {
        showPsdBtn.isSelected = !showPsdBtn.isSelected
        accountPsdText.isSecureTextEntry = !showPsdBtn.isSelected
    }
    
    
    //去手机注册
    @IBAction func jumpToRegisterPage(_ sender: Any) {
        let RegisterVC = RegisterViewController()
        self.navigationController?.pushViewController(RegisterVC, animated: true)
    }
    //点击忘记密码
    @IBAction func jumpToGetPsdPage(_ sender: Any) {
        let forgetPsdVC = forgetPsdViewController()
        self.navigationController?.pushViewController(forgetPsdVC, animated: true)
    }
}

//第三方登录相关
extension LoginViewController{
    //微信登录点击
    @IBAction func WXLoginClick(_ sender: Any) {}
    
    //点击切换 显示验证码登录
    @IBAction func codeLoginToggle(_ sender: Any) {
        //更改登录类型,并且登录按钮不可点击
        self.loginType = 2
        judgeLoginBtnEnabled(type: 2)
        //初始化(重置)全部错误信息 及 数据
        resetErrorInfo()
        
        //第三方按钮的切换显示
        otherLoginType_account.isHidden = false
        otherLoginType_code.isHidden = true
        
        //显示验证码登录view
        accountLoginView.isHidden = true
        codeLoginView.isHidden = false
        //隐藏忘记密码按钮
        forgetPsdBtn.isHidden = true
    }
    //点击切换 显示账号登录
    @IBAction func accountLoginToggle(_ sender: Any) {
        //更改登录类型,并且登录按钮不可点击
        self.loginType = 1
        judgeLoginBtnEnabled(type: 2)
        //初始化(重置)全部错误信息 及 数据
        resetErrorInfo()
        
        //第三方按钮的切换显示
        otherLoginType_account.isHidden = true
        otherLoginType_code.isHidden = false
        
        //显示账号登录view
        accountLoginView.isHidden = false
        codeLoginView.isHidden = true
        //显示忘记密码按钮
        forgetPsdBtn.isHidden = false
    }
}

//输入框代理事件
extension LoginViewController:UITextFieldDelegate{
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//
//    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        //账号
        if textField.tag == 1{
            //test - 判断条件需改变
            if textField.text!.count != 11{
                self.accountErrorInfo.isHidden = false
                shake(label: self.accountErrorInfo)
                self.accountInputBorder.backgroundColor = RGBColor(r: 230, g: 100, b: 95)
            }
        }
        //手机号
        if textField.tag == 11{
            //test - 判断条件需改变
            if textField.text!.count != 11{
                self.phoneErrorInfo.isHidden = false
                shake(label: self.phoneErrorInfo)
                self.phoneInputBorder.backgroundColor = RGBColor(r: 230, g: 100, b: 95)
            }
        }
        
        //判断登录按钮是否可点击
        judgeLoginBtnEnabled(type: 1)
    }
}

