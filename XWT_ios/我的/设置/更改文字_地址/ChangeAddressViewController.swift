//
//  ChangeAddressViewController.swift
//  todayNews
//
//  Created by xushiqi on 2020/3/13.
//  Copyright © 2020 xushiqi. All rights reserved.
//

import UIKit

class ChangeAddressViewController: CustomAlertViewController {
    //nav右侧保存按钮是否可点击
    var isBtnEnabled = false
    
    //左侧文字数组 mainTxtArr
    var arrList = NSArray()
    //存放右侧文字的数组 detailTxtArray
    var detailArray = NSMutableArray()
    // pick选择器高度
    let pickHeight = 240 + kTabBarH-49
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //导航栏 自定义设置
        setNavBarStyle()
        self.navigationItem.title = "更改地址"
        self.view.addSubview(tableV)
        KeyWindow!.addSubview(grayView)
        KeyWindow!.addSubview(pickView)
        
        
        createDatas()
    }
    
    private func createDatas(){
        arrList = ["国家/地区","省份","城市","详细地址"]
        detailArray = ["中国","浙江省","温州市瓯海区","蛟凤北路5号新联实业"]
    }
    
    // table初始化
    private lazy var tableV : UITableView = {
        
        let table = UITableView.init(frame: CGRect(x: 0, y: kNavigationBarH , width: kScreenW, height: kScreenH - kNavigationBarH), style: .grouped)
        table.delegate = self
        table.dataSource = self

        table.keyboardDismissMode = .onDrag
//        table.backgroundColor = bgGray //UIColor.clear
//        table.separatorStyle = .none
        return table
    }()
    
    //详细地址xib view
    private lazy var detailCellView : AddrDetailCellView = {
        let detailCellView = AddrDetailCellView.loadFromNib()
        detailCellView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: customLayer(num: 80))
//            detailCellView.delegate = self
//            detailCellView.dataSource = self
        return detailCellView
    }()
    
    // 灰色背景
    private lazy var grayView : UIView = {
        
        let grayV = UIView.init(frame: self.view.bounds)
        grayV.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.1)
        grayV.isHidden = true
        let tapp = UITapGestureRecognizer.init(target: self, action: #selector(grayClick))
        grayV.addGestureRecognizer(tapp)
        
        return grayV
    }()
    
    // 退出编辑
    @objc private func grayClick() {
        grayView.isHidden = true
        
        UIView.animate(withDuration: 0.2) {
            self.pickView.frame = CGRect(x: 0, y: kScreenH, width: kScreenW, height: self.pickHeight)
        }
    }
    
    // pick选择器初始化
    private lazy var pickView : MinePickViews = {
        
        let pick = MinePickViews.loadFromNib()
        pick.frame = CGRect(x: 0, y: kScreenH, width: kScreenW, height: pickHeight)
        pick.delegate = self
        
        return pick
    }()
    
    // 显示pickView
    private func creatPickView() {
        grayView.isHidden = false
        //如果在输入,取消输入(blur)
        detailCellView.addrDetailText.resignFirstResponder()
        
        UIView.animate(withDuration: 0.2) {
            self.pickView.frame = CGRect(x: 0, y: kScreenH-self.pickHeight, width: kScreenW, height: self.pickHeight)
        }
    }
}
//导航栏 自定义设置
extension ChangeAddressViewController{
    // 设置导航栏 返回按钮
    private func setNavBarStyle(){
        
        // 隐藏导航栏下面的黑线
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.view.backgroundColor = UIColor.white
        // 隐藏系统返回按钮
        self.navigationController?.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        // 自定义返回按钮样式
        let leftBtn:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "iconjiantou")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(actionBack))
        self.navigationItem.leftBarButtonItem = leftBtn
        
        //创建nav 右侧按钮
        self.navigationItem.rightBarButtonItem = createRightBtn(isEnabled: self.isBtnEnabled)
    }
    
    //返回按钮事件
    @objc func actionBack(){
        self.navigationController?.popViewController(animated: true);
    }
    
    //创建nav 右侧按钮
    func createRightBtn(isEnabled: Bool) -> UIBarButtonItem {
        print("创建nav 右侧按钮")
        let btnCustom:UIButton = UIButton.init(frame: CGRect(x: 40, y: 0, width: customLayer(num: 60), height: customLayer(num: 24)))
        btnCustom.setTitle("保存", for: .normal)
        if isEnabled {
            btnCustom.setTitleColor(RGBColor(r: 255, g: 255, b: 255), for: .normal)
            btnCustom.backgroundColor = RGBColor(r: 245, g: 92, b: 82)
        }else{
            btnCustom.setTitleColor(RGBColor(r: 102, g: 102, b: 102), for: .normal)
            btnCustom.backgroundColor = RGBColor(r: 221, g: 221, b: 221)
        }
        
        btnCustom.titleLabel?.font = customFont(font: 13)
        btnCustom.layer.cornerRadius = customLayer(num: 12)
        btnCustom.layer.masksToBounds = true
        btnCustom.addTarget(self, action: #selector(save), for: .touchUpInside)
        btnCustom.isUserInteractionEnabled = isEnabled
        let rightBtn:UIBarButtonItem = UIBarButtonItem(customView: btnCustom)

        return rightBtn
    }
    
    //保存事件
    @objc func save(){
        showCustomAlertView1(title: "是否确认保存？") { (value) in
            self.isBtnEnabled = false
            //移除添加好友按钮
           
            print("模拟保存成功")
            self.isBtnEnabled = false
            self.navigationItem.rightBarButtonItem = self.createRightBtn(isEnabled: self.isBtnEnabled)
        }
    }
}

//table高度
extension ChangeAddressViewController :UITableViewDelegate,UITableViewDataSource{
    //显示的宽高
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return customLayer(num: 14)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 3{
            return customLayer(num: 80)
        }
        return customLayer(num: 56)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}
//table数量 及 cell内容
extension ChangeAddressViewController{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // cell
        var cell = tableView.dequeueReusableCell(withIdentifier: "seller")
        
        if cell == nil
        {
            cell = UITableViewCell.init(style: .value1, reuseIdentifier: "seller")
        }
        
        //设置cell内容
        cell?.textLabel!.text = (arrList[indexPath.row] as! String)
        cell?.textLabel?.font = customFont(font: 14)
        cell?.textLabel?.textColor = RGBColor(r: 51, g: 51, b: 51)
        
        cell?.detailTextLabel!.text = (detailArray[indexPath.row] as! String)
        cell?.detailTextLabel!.font = customFont(font: 14)
        cell?.detailTextLabel!.textColor = RGBColor(r: 51, g: 51, b: 51)
        if indexPath.row == 3 {
//            let textFile = UITextView(frame: CGRect(x: kScreenW/2, y: 0, width: kScreenW/2-20, height: customLayer(num: 80)))
//            textFile.backgroundColor = UIColor.red
//            cell?.contentView.addSubview(textFile)
            
            cell?.contentView.addSubview(detailCellView)
        }
        
        // 更改cell默认的border
        cell?.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        return cell!
    }
    
    //点击事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //点击后显示灰色背景 - 这样写只会闪一下
        tableView.deselectRow(at: indexPath, animated: true)
        //改变省份
        if indexPath.row == 1{
            creatPickView()
            self.pickView.refreshData(type: 1)
        }
        //改变市区县
        if indexPath.row == 2{
            creatPickView()
            self.pickView.refreshData(type: 3)
        }
        //改变详细地址
        if indexPath.row == 3{
            
        }
    }
}
extension ChangeAddressViewController:MinePickDelegate{
    func minePickChange(value: String, index: NSInteger, address: String) {
        print("picker delegate")
        grayClick()
    }
}
