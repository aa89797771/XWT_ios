//
//  FathViewController.swift
//  todayNews
//
//  Created by xushiqi on 2020/3/3.
//  Copyright © 2020 xushiqi. All rights reserved.
//

import UIKit

class FathViewController: CustomAlertViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addBackBtn()
    }
    
    // 设置页返回按钮
    private func addBackBtn(){
        
        // 隐藏导航栏下面的黑线
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.view.backgroundColor = UIColor.white
        // 隐藏系统返回按钮
        self.navigationController?.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        // 自定义返回按钮样式
        let leftBtn:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "iconjiantou")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(actionBack))
        
        self.navigationItem.leftBarButtonItem = leftBtn;
        
    }
    
    //返回按钮事件
    @objc func actionBack(){
        self.navigationController?.popViewController(animated: true);
        
    }

}
