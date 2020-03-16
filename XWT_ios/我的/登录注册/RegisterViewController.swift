//
//  RegisterViewController.swift
//  todayNews
//
//  Created by xushiqi on 2020/3/3.
//  Copyright © 2020 xushiqi. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    //用户角色 (-1):没有选择
    var roleType = -1
    //选择角色btn
    @IBOutlet weak var selectRoleBtn: UIButton!
    @IBAction func selectRoleClick(_ sender: Any) {
        let sheetTitle = "选择用户角色"
        let arrSheet = ["buyer","辅料商","鞋企"]
        createSheetUI(title: sheetTitle, titleArray: arrSheet as NSArray)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "快速注册"
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
//弹窗设置 roleType
extension RegisterViewController{
    //alert弹窗设置
    private func createSheetUI(title:String, titleArray:NSArray){
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        
        for alertString in titleArray{
            let alertAct = UIAlertAction(title: alertString as? String, style: .default) { (alert) in
                print(alert.title!)
//                self.loadDetiArray(value: alert.title!, curIndex: currentRow)
                self.selectRoleBtn.setTitle(alert.title, for: .normal)
                
            }
            alertController.addAction(alertAct)
        }
        let alertAct = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        alertController.addAction(alertAct)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    //点击sheet后,更改对应的内容
//    private func loadDetiArray(value:String, curIndex: NSInteger){
//        guard curIndex == 1 else {
//            //deti_Arr为不可变数组,没有replace方法,需要循环添加进可变数组
//            var deti_Arr = self.detailArray[0] as! NSArray
//            let deti_array = NSMutableArray()
//
//            for curSting in deti_Arr{
//                deti_array.add(curSting)
//            }
//
//            deti_array.replaceObject(at: curIndex, with: value)
//            deti_Arr = deti_array
//
//            self.detailArray.replaceObject(at: 0, with: deti_Arr)
//            tableV.reloadData()
//
//            return
//        }
//    }
}
