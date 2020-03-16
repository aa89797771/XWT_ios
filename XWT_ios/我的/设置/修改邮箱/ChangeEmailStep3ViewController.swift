//
//  ChangeEmailStep3ViewController.swift
//  todayNews
//
//  Created by xushiqi on 2020/3/4.
//  Copyright © 2020 xushiqi. All rights reserved.
//

import UIKit

class ChangeEmailStep3ViewController: FathViewController {
    //修改类型 1.手机 2.邮箱
    var type = 1
    //提示信息 label
    @IBOutlet weak var tips: UILabel!
    //验证码
    @IBOutlet weak var accountName: UITextField!
    //确认按钮
    @IBOutlet weak var btnConfirm: UIButton!
    //点击确认更换按钮
    @IBAction func btnClick(_ sender: Any) {
        showCustomAlertView2(title: "修改成功，请重新登录！") { (value) in
            print("重新登录")
            let toSetsPage = SetsViewController()
            self.navigationController?.pushViewController(toSetsPage, animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "填写验证码"
        //1.手机
        if type == 1 {
            self.tips.text = "验证码已发送至18268000000"
            self.accountName.placeholder = "请输入手机中的验证码"
        //2.邮箱
        }else if type == 2{
            self.tips.text = "验证码已发送至308*****86@qq.com"
            self.accountName.placeholder = "请输入邮箱中的验证码"
        }
    }

}
