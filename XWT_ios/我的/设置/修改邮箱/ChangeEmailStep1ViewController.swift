//
//  ChangeEmailStep1ViewController.swift
//  todayNews
//
//  Created by xushiqi on 2020/3/4.
//  Copyright © 2020 xushiqi. All rights reserved.
//

import UIKit

class ChangeEmailStep1ViewController: FathViewController {
    //修改类型 1.手机 2.邮箱
    var type = 1
    //图标
    @IBOutlet weak var icon: UIImageView!
    //提示tips
    @IBOutlet weak var tips: UILabel!
    //账户名
    @IBOutlet weak var accountName: UILabel!
    //认更换按钮
    @IBOutlet weak var btnConfirm: UIButton!
    //点击确认更换按钮
    @IBAction func btnClick(_ sender: Any) {
        var tipsTitle = ""
        
        //1.手机
        if type == 1 {
            tipsTitle = "修改手机前需要验证您的密码"
        //2.邮箱
        }else if type == 2{
            tipsTitle = "修改邮箱前需要验证您的密码"
        }
        
        showCustomPromptBox1(title: tipsTitle) { (str) in
            print("点击更换邮箱地址:\(str)")
            let changeEmailVC2 = ChangeEmailStep2ViewController()
            changeEmailVC2.type = self.type
            self.navigationController?.pushViewController(changeEmailVC2, animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        //1.手机
        if type == 1 {
            self.navigationItem.title = "修改手机"
            self.icon.image = UIImage(named: "iconphoneshape")
            self.tips.text = "您目前的手机号码："
            self.accountName.text = "18268200000"
            self.btnConfirm.setTitle("更换手机号码", for: .normal)
        //2.邮箱
        }else if type == 2{
            self.navigationItem.title = "修改邮箱"
            self.icon.image = UIImage(named: "iconemailadress")
            self.tips.text = "您的邮箱地址："
            self.accountName.text = "xxxxxxxxx@qq.com"
            self.btnConfirm.setTitle("更换邮箱地址", for: .normal)
        }
        
    }
}
