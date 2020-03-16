//
//  SetsViewController.swift
//  todayNews
//
//  Created by xushiqi on 2020/3/3.
//  Copyright © 2020 xushiqi. All rights reserved.
//

import UIKit
import SwiftyJSON

class SetsViewController: FathViewController {
    //左侧文字数组 mainTxtArr
    var arrList = NSArray()
    //存放右侧文字的数组 detailTxtArray
    var detailArray = NSMutableArray()
    //可变高度数组 - 存放table每个cell的高度
    var heightArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "设置"
        self.view.addSubview(tableV)       // 添加表格
        createDatas()                   // 默认文字数据
    }
    
    private lazy var tableV:UITableView = {
        let table = UITableView.init(frame: CGRect(x: 0, y: kNavigationBarH, width: kScreenW, height: kScreenH - kNavigationBarH), style: .grouped)
        table.delegate = self
        table.dataSource = self
        //有多少内容就创建多少cell
        table.tableFooterView = UIView.init()
        
        return table
    }()
}
extension SetsViewController{
    private func createDatas(){
        arrList = [
            ["邮箱","手机号码","修改密码","语言"],
            ["清除缓存"]
        ]
        detailArray = [
            ["1203609994@qq.com","18757097990","","简体中文"],
            [""]
        ]
        //配置置高度信息
        for (curInt,array) in self.arrList.enumerated(){
            let curArr = NSMutableArray()
            for _ in 0..<(array as AnyObject).count{
                if curInt == 0{
                    curArr.add(customLayer(num: 56))
                }else{
                    curArr.add(customLayer(num: 60))
                }
            }
            self.heightArray.add(curArr)
        }
    }
}
//table高度
extension SetsViewController{
    //显示的宽高
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 15 : 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return customLayer(num: 47)
        return (self.heightArray[indexPath.section] as! Array)[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 1 ? 100 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
//
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let foot_view = UIView()
        let foot_label = UILabel(frame: CGRect(x: 20, y: 83, width: kScreenW-40, height: 14))
        foot_label.text = "All Right's Reserved By Toutiao.com"
        foot_label.font = customFont(font: 14)
        foot_label.textColor = RGBColor(r: 153, g: 153, b: 153)
        foot_label.textAlignment = .center
        foot_view.addSubview(foot_label)

        return section == 1 ? foot_view : nil
    }
}

//table数量 及 cell内容
extension SetsViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.arrList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.arrList[section] as! NSArray).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //显示左右文字
        var cellValue = tableView.dequeueReusableCell(withIdentifier: "sellValue")
        if cellValue == nil{
            cellValue = UITableViewCell.init(style: .value1, reuseIdentifier: "sellValue")
        }
        //含有右侧文字
        cellValue?.textLabel?.text = ((self.arrList[indexPath.section] as! NSArray)[indexPath.row] as! String)
        cellValue?.textLabel?.font = customFont(font: 16)
        cellValue?.textLabel?.textColor = RGBColor(r: 34, g: 34, b: 34)
        
        cellValue?.detailTextLabel?.text = ((self.detailArray[indexPath.section] as! NSArray)[indexPath.row] as! String)
        cellValue?.detailTextLabel?.font = customFont(font: 14)
        cellValue?.detailTextLabel?.textColor = RGBColor(r: 153, g: 153, b: 153)
        //含有右侧箭头
        if indexPath.section == 0 {
            cellValue?.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        }
        
        return cellValue!
    }
    
    //点击事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //点击后显示灰色背景 - 这样写只会闪一下
        tableView.deselectRow(at: indexPath, animated: true)
        
        let labenName = (self.arrList[indexPath.section] as! NSArray)[indexPath.row] as? String
        if labenName == "邮箱"{
            print("邮箱")
            let changeEmailVC = ChangeEmailStep1ViewController()
            changeEmailVC.type = 2
            self.navigationController?.pushViewController(changeEmailVC, animated: true)
            
        }else if labenName == "手机号码"{
            print("手机号码")
            let changeEmailVC = ChangeEmailStep1ViewController()
            changeEmailVC.type = 1
            self.navigationController?.pushViewController(changeEmailVC, animated: true)
            
        }else if labenName == "修改密码"{
            print("修改密码")
            let ChangePsdVC = ChangePsdViewController()
            self.navigationController?.pushViewController(ChangePsdVC, animated: true)
            
        }else if labenName == "语言"{
            print("语言")
            let selectLanguageVC = SelectLanguageViewController()
            self.navigationController?.pushViewController(selectLanguageVC, animated: true)
            
        }else if labenName == "清除缓存"{
            showCustomAlertView1(title:"确认要清除缓存吗？") { (str) in
                print("这里是清除缓存 回调函数")
            }
        }
    }
}
