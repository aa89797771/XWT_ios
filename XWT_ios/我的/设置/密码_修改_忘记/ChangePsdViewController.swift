//
//  ChangePsdViewController.swift
//  todayNews
//
//  Created by xushiqi on 2020/3/13.
//  Copyright © 2020 xushiqi. All rights reserved.
//

import UIKit

class ChangePsdViewController: FathViewController {
    @IBOutlet weak var nowPsderror: UILabel!
    @IBOutlet weak var newPsderror: UILabel!
    @IBOutlet weak var now2Psderror: UILabel!
    
    //点击忘记密码
    @IBAction func toForgetPsdPage(_ sender: Any) {
        let forgetPsdVC = forgetPsdViewController()
        self.navigationController?.pushViewController(forgetPsdVC, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "修改密码"
        setUI()
    }
    func setUI(){
        nowPsderror.isHidden = true
        newPsderror.isHidden = true
        now2Psderror.isHidden = true
    }
}
