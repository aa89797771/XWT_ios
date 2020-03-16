//
//  forgetPsdViewController.swift
//  todayNews
//
//  Created by xushiqi on 2020/3/3.
//  Copyright © 2020 xushiqi. All rights reserved.
//

import UIKit

class forgetPsdViewController: FathViewController {

    @IBAction func toSetNewPsdPage(_ sender: Any) {
        let setNewPageVC = ConfirmPsdViewController()
        self.navigationController?.pushViewController(setNewPageVC, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "忘记密码"
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
