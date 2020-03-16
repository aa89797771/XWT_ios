//
//  ChangeEmailStep2ViewController.swift
//  todayNews
//
//  Created by xushiqi on 2020/3/4.
//  Copyright © 2020 xushiqi. All rights reserved.
//

import UIKit

class ChangeEmailStep2ViewController: FathViewController {
    //修改类型 1.手机 2.邮箱
    var type = 1
    //账户名 label
    @IBOutlet weak var accountLabel: UILabel!
    //账户名 input
    @IBOutlet weak var accountName: UITextField!
    //确认按钮
    @IBOutlet weak var btnConfirm: UIButton!
    //点击确认更换按钮
    @IBAction func btnClick(_ sender: Any) {
        let changeEmailVC3 = ChangeEmailStep3ViewController()
        changeEmailVC3.type = self.type
        self.navigationController?.pushViewController(changeEmailVC3, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //1.手机
        if type == 1 {
            self.navigationItem.title = "输入新手机"
            self.accountLabel.text = "手机号码"
            self.accountName.placeholder = "请输入新手机"
        //2.邮箱
        }else if type == 2{
            self.navigationItem.title = "输入新邮箱"
            self.accountLabel.text = "邮箱地址"
            self.accountName.placeholder = "请输入邮箱地址"
        }
    }

}
