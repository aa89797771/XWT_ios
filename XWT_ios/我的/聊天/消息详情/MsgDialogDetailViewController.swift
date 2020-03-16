//
//  MsgDialogDetailViewController.swift
//  todayNews
//
//  Created by xushiqi on 2020/3/10.
//  Copyright © 2020 xushiqi. All rights reserved.
//

import UIKit
import SwiftyJSON

class MsgDialogDetailViewController: CustomAlertViewController {
    //是否是好友(不是的话右上角有添加好友按钮)
    var isFriend = false
    //键盘没有弹出时的 inputBar高度(粪叉时会多出34)
    let inputBarWhenBottomH = kTabBarH
    let inputBarWhenShowH:CGFloat = 49
    //模拟数据
    var arrList = JSON()
    //可变高度数组 - 存放table每个cell的高度
    var heightArray = NSMutableArray()
    //是否显示时间的数组
    var isShowTimeArray = NSMutableArray()
    //超过多久时间间隔才显示聊天框顶部的时间
    let timeSpaceShowTime = 100
    //是否显示提示信息的数组(成功添加好友)
    var isShowTipsArray = NSMutableArray()
    //最大label宽度
    let maxLabelW = kScreenW - customLayer(num: 120)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "消息详情"
        
        self.view.backgroundColor = UIColor.blue
        
        self.view.addSubview(tableV)            // 添加表格
        self.view.addSubview(dialogInputBar)    // 添加输入框栏
        
        //导航栏 自定义设置
        setNavBarStyle()
        
        createDatas()
        conputedDatas()
    
        //触发滚动至底事件
        self.tableV.reloadData()
        self.scrollToBottom(animated: false)
        
        // 监听键盘弹出高度
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        // 监听键盘收回
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    // 键盘弹出
    @objc private func keyBoardWillShow(notification:NSNotification)
    {
        let keyboardInfo = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey]
        let boardH = (keyboardInfo as AnyObject).cgRectValue.size.height
        
        let heightBoard = kScreenH - boardH - inputBarWhenShowH
        
        UIView.animate(withDuration: 0.35) {
            self.dialogInputBar.frame = CGRect(x: 0, y: heightBoard, width: kScreenW, height: self.inputBarWhenShowH)
            
            // 改变高度 - 但是收回时不是显示最底部(之前没有滚切时,第一次收回时会有一点点偏差)
            // 以后可以试试 根据offset前的位置与键盘高度的差值进行赋值
            self.tableV.frame = CGRect(x: 0, y: kNavigationBarH, width: kScreenW, height: heightBoard - kNavigationBarH)
            self.tableV.contentOffset.y = self.tableV.contentOffset.y + (boardH + self.inputBarWhenShowH - self.inputBarWhenBottomH)
            // self.scrollToBottom(animated: true)
        }
    }
    // 键盘收回
    @objc private func keyBoardWillHide(notification:NSNotification)
    {
        let keyboardInfo = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey]
        let boardH = (keyboardInfo as AnyObject).cgRectValue.size.height
        let heightBoard = kScreenH - boardH - inputBarWhenShowH
        
        UIView.animate(withDuration: 0.35) {
            // 返回input框初始化时的位置
            self.dialogInputBar.frame = CGRect(x: 0, y: kScreenH - self.inputBarWhenBottomH, width: kScreenW, height: self.inputBarWhenBottomH)
            // 返回tableV 在输入框前的位置
            self.tableV.frame = CGRect(x: 0, y: kNavigationBarH, width: kScreenW, height: kScreenH - kNavigationBarH - self.inputBarWhenBottomH)
//            self.tableV.contentOffset.y = self.tableV.contentOffset.y - (boardH + self.inputBarWhenShowH - self.inputBarWhenBottomH)
            
            // 计算table高度用 - 细节已失败
            let tableH = kScreenH - kNavigationBarH - self.inputBarWhenBottomH
            let tableHSmall = heightBoard - kNavigationBarH
            let tableContentH = self.tableV.contentSize.height
            let tableOffsetY = self.tableV.contentOffset.y
            let boardDiffH = boardH + self.inputBarWhenShowH - self.inputBarWhenBottomH
            let tableBottomUnseeH = tableContentH - tableOffsetY - tableH + boardDiffH
            //print("计算table高度:\(boardDiffH) - \(tableBottomUnseeH)")
            //高度变化时的计算太麻烦了 - 应该需要键盘未收回前的offset高度之类的!fck
            if(tableHSmall <= tableBottomUnseeH ){
                self.tableV.contentOffset.y = self.tableV.contentOffset.y - boardDiffH
            }else{
                //self.tableV.contentOffset.y = self.tableV.contentOffset.y
            }
        }
    }
    
    private lazy var tableV:UITableView = {
        let table = UITableView.init(frame: CGRect(x: 0, y: kNavigationBarH, width: kScreenW, height: kScreenH - kNavigationBarH - inputBarWhenBottomH), style: .grouped)
        table.delegate = self
        table.dataSource = self
        // 取消table的border
        table.separatorStyle = .none
        //有多少内容就创建多少cell
        table.tableFooterView = UIView.init()
        //点击table时键盘回收
        table.keyboardDismissMode = .onDrag
        //自适应大小
        table.rowHeight = UITableView.automaticDimension;
        table.estimatedRowHeight = customLayer(num: 50);
        // 注册cell
        table.register(UINib.init(nibName: "MsgDialogDetailCellLeft", bundle: Bundle.main), forCellReuseIdentifier: "cellLeft")
        table.register(UINib.init(nibName: "MsgDialogDetailCellRight", bundle: Bundle.main), forCellReuseIdentifier: "cellRight")
        table.register(UINib.init(nibName: "MsgTipsTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "cellTips")
        
        return table
    }()
    
    private lazy var dialogInputBar:DialogInputBarView = {
        let dialogInputBar = DialogInputBarView.loadFromNib()
        dialogInputBar.frame = CGRect(x: 0, y: kScreenH - inputBarWhenBottomH, width: kScreenW, height: inputBarWhenBottomH)
        dialogInputBar.delegate = self
        return dialogInputBar
    }()
    
    
    
    private func createDatas(){
           arrList = [
              ["name":"赵无极","url":"https://profile.csdnimg.cn/F/3/9/3_wxs0124","count":"1",
               "p2s": true,
               "createTime": 123456,
              "isRead": true,
              "content":"为解决好中国鞋行业近年来严峻的出口形势问题，探 索全球化竞争的信心，新联鞋供应链股份有限公司与 鞋都房地产开发有限公司共同打造1","time":"今天 11:40"],
              ["name":"赵无极","url":"https://profile.csdnimg.cn/F/3/9/3_wxs0124","count":"1",
               "p2s": true,
               "createTime": 123456,
              "isRead": true,
              "content":"为解决好中国鞋行业近年来严峻的出口形势问题，探 索全球化竞争的信心，新联鞋供应链股份有限公司与 鞋都房地产开发有限公司共同打造1","time":"今天 11:40"],
              ["name":"赵无极","url":"https://profile.csdnimg.cn/F/3/9/3_wxs0124","count":"1",
               "p2s": true,
               "createTime": 123456,
              "isRead": true,
              "content":"为解决好中国鞋行业近年来严峻的出口形势问题，探 索全球化竞争的信心，新联鞋供应链股份有限公司与 鞋都房地产开发有限公司共同打造1","time":"今天 11:40"],
              ["name":"赵无极","url":"","count":"1",
                "p2s": false,
                "createTime": 123456,
               "isRead": true,
               "isTips":true,
               "tipsContent":"对方已经成为您的好友!",
               "content":"","time":"今天 11:40"],
              
               ["name":"赵无极","url":"https://profile.csdnimg.cn/F/3/9/3_wxs0124","count":"1",
               "isRead": false,
               "p2s": true,
               "createTime": 123660,
               "content":"为解决好中国同打造","time":"今天 12:40"],
               ["name":"赵无极","url":"https://profile.csdnimg.cn/F/3/9/3_wxs0124","count":"1",
               "isRead": true,
               "p2s": false,
               "createTime": 123800,
               "content":"为解决好中国鞋行业近年来严峻的出口形势问题，探 索全球化竞争的信心，新联鞋供应链股份有限公司与 鞋都房地产开发有限公司共同打造2","time":"今天 13:40"],
               ["name":"赵无极","url":"https://profile.csdnimg.cn/F/3/9/3_wxs0124","count":"1",
               "isRead": true,
               "p2s": false,
               "createTime": 123800,
               "content":"为解决好中国鞋行业近年来严峻的出口形势问题，探 索全球化竞争的信心，新联鞋供应链股份有限公司与 鞋都房地产开发有限公司共同打造2","time":"今天 13:40"],["name":"赵无极","url":"","count":"1",
                 "p2s": false,
                 "createTime": 123456,
                "isRead": true,
                "isTips":true,
                "tipsContent":"对方已经成为您的好友!",
                "content":"","time":"今天 11:40"],
               
                ["name":"赵无极","url":"https://profile.csdnimg.cn/F/3/9/3_wxs0124","count":"1",
                "isRead": false,
                "p2s": true,
                "createTime": 123660,
                "content":"为解决好中国同打造","time":"今天 12:40"],
                ["name":"赵无极","url":"https://profile.csdnimg.cn/F/3/9/3_wxs0124","count":"1",
                "isRead": true,
                "p2s": false,
                "createTime": 123800,
                "content":"为解决好中国鞋行业近年来严峻的出口形势问题，探 索全球化竞争的信心，新联鞋供应链股份有限公司与 鞋都房地产开发有限公司共同打造2","time":"今天 13:40"],
                ["name":"赵无极","url":"https://profile.csdnimg.cn/F/3/9/3_wxs0124","count":"1",
                "isRead": true,
                "p2s": false,
                "createTime": 123800,
                "content":"为解决好中国鞋行业近年来严峻的出口形势问题，探 索全球化竞争的信心，新联鞋供应链股份有限公司与 鞋都房地产开发有限公司共同打造2","time":"今天 13:40"],["name":"赵无极","url":"","count":"1",
                  "p2s": false,
                  "createTime": 123456,
                 "isRead": true,
                 "isTips":true,
                 "tipsContent":"对方已经成为您的好友!",
                 "content":"","time":"今天 11:40"],
                
                 ["name":"赵无极","url":"https://profile.csdnimg.cn/F/3/9/3_wxs0124","count":"1",
                 "isRead": false,
                 "p2s": true,
                 "createTime": 123660,
                 "content":"为解决好中国同打造","time":"今天 12:40"],
                 ["name":"赵无极","url":"https://profile.csdnimg.cn/F/3/9/3_wxs0124","count":"1",
                 "isRead": true,
                 "p2s": false,
                 "createTime": 123800,
                 "content":"为解决好中国鞋行业近年来严峻的出口形势问题，探 索全球化竞争的信心，新联鞋供应链股份有限公司与 鞋都房地产开发有限公司共同打造2","time":"今天 13:40"],
                 ["name":"赵无极","url":"https://profile.csdnimg.cn/F/3/9/3_wxs0124","count":"1",
                 "isRead": true,
                 "p2s": false,
                 "createTime": 123800,
                 "content":"为解决好中国鞋行业近年来严峻的出口形势问题，探 索全球化竞争的信心，新联鞋供应链股份有限公司与 鞋都房地产开发有限公司共同打造2","time":"今天 13:40"],
               ["name":"赵无极","url":"https://profile.csdnimg.cn/F/3/9/3_wxs0124","count":"1",
               "isRead": true,
               "p2s": false,
               "createTime": 123800,
               "content":"为解决好中国鞋行业近年来严峻的出口形势问题，探 索全球化竞争的信心，新联鞋供应链股份有限公司与 鞋都房地产开发有限公司共同打造2","time":"今天 13:40"],
               ["name":"赵无极","url":"https://profile.csdnimg.cn/F/3/9/3_wxs0124","count":"1",
               "isRead": true,
               "p2s": false,
               "createTime": 123612,
               "content":"为解决好中国同打造","time":"今天 14:40"],
           ]
       }
    
    //滚动至底部事件
    private func scrollToBottom (animated: Bool){
        self.tableV.scrollToRow(at: IndexPath(item: 0, section: self.arrList.count - 1), at: .bottom, animated: animated)
    }
    
    private func conputedDatas(){
        self.isShowTimeArray.removeAllObjects()
        self.isShowTipsArray.removeAllObjects()
        
        //配置是否显示时间的数组
        for (curInt,_) in self.arrList.enumerated(){
             //第一个聊天显示时间
             if curInt == 0{
                 self.isShowTimeArray.add(true)
             //一定时间间隔后 显示时间
             }else {
                 let previewCellCreateTime = arrList[curInt-1]["createTime"].intValue
                 let cellCreateTime = arrList[curInt]["createTime"].intValue
                 if previewCellCreateTime < cellCreateTime - timeSpaceShowTime {
                     self.isShowTimeArray.add(true)
                 }else{
                    self.isShowTimeArray.add(false)
                 }
             }
         
             //是否显示tips信息(成功添加好友信息)
             if arrList[curInt]["isTips"].boolValue {
                 self.isShowTipsArray.add(true)
             }else{
                 self.isShowTipsArray.add(false)
             }
         
        }
        
//        print("self.arrList:\(self.arrList)")
//        print("times:\(isShowTimeArray)")
    }
    
    // 移除通知
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

//导航栏 自定义设置
extension MsgDialogDetailViewController {
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
        
        //不是好友时右上角有添加好友按钮
        if !isFriend {
            //右侧 添加好友 按钮
            let btnCustom:UIButton = UIButton.init(frame: CGRect(x: 40, y: 0, width: 70, height: customLayer(num: 24)))
            btnCustom.setTitle("添加好友", for: .normal)
            btnCustom.setTitleColor(RGBColor(r: 245, g: 92, b: 82), for: .normal)
            btnCustom.titleLabel?.font = customFont(font: 13)
            btnCustom.layer.borderWidth = 1
            btnCustom.layer.borderColor = RGBColor(r: 245, g: 92, b: 82).cgColor
            btnCustom.layer.cornerRadius = customLayer(num: 12)
            btnCustom.layer.masksToBounds = true
            let rightBtn:UIBarButtonItem = UIBarButtonItem(customView: btnCustom)
            
            btnCustom.addTarget(self, action: #selector(addFriend), for: .touchUpInside)
            self.navigationItem.rightBarButtonItem = rightBtn
        }
    }
    
    //返回按钮事件
    @objc func actionBack(){
        self.navigationController?.popViewController(animated: true);
    }
    
    //添加好友事件
    @objc func addFriend(){
        showCustomAlertView1(title: "是否添加对方为好友？") { (value) in
            self.loadLocalData(value: "2", curIndex: 2)
            
            self.isFriend = true
            //移除添加好友按钮
            self.navigationItem.rightBarButtonItem = nil
        }
    }
    
    // 更新当前点击内容
    private func loadLocalData(value: String, curIndex: NSInteger) {
        let newObj:JSON = ["name":"赵无极","url":"https://profile.csdnimg.cn/F/3/9/3_wxs0124","count":"1",
        "isRead": true,
        "p2s": true,
        "isTips":true,
        "tipsContent":"对方已经成为您的好友!",
        "createTime": 144460,
        "content":"为解决好中国同打造","time":"今天 12:40"]
        
        //往里添加数据
        let middle_array = NSMutableArray()
        for (_,curString) in self.arrList
        {
            middle_array.add(curString)
        }
        middle_array.add(newObj)
        self.arrList = JSON(middle_array)
        
        //是否展示 显示提示信息的数组
        conputedDatas()
        tableV.reloadData()
        return
    }
}

//table高度
extension MsgDialogDetailViewController{
    //显示的宽高
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //判断是否显示时间
        if self.isShowTimeArray[section] as! Bool {
            return customLayer(num: 30)
        }
        
        //判断是否显示tips
        //此时本身没有head,且下一个对话框也没有head
        if self.isShowTipsArray[section] as! Bool {
            return 0
        }else if (section > 0 && self.isShowTipsArray[section-1] as! Bool){
            return 0
        }
        
        //2个对话框之间的间隔
        return customLayer(num: 12)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
//        return customLayer(num: 50)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        //p2s时需要显示已读、未读信息 - 在视觉上此处高度不需要设置太高(下面的head会有间隙,这边再设置太高的话不好看)
        if self.arrList[section]["p2s"].boolValue {
            return customLayer(num: 4)
        }
        
        //最后一个时为了不靠底边,设置一个padding值
        if(section == self.arrList.count - 1){
            return customLayer(num: 10)
        }
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let head_view = UIView()
        let cellValue = arrList[section]
        
        let head_label = UILabel(frame: CGRect(x: 20, y: customLayer(num: 10), width: kScreenW-40, height: customLayer(num: 20)))
        head_label.font = customFont(font: 10)
        head_label.textColor = RGBColor(r: 153, g: 153, b: 153)
        head_label.textAlignment = .center
        
        head_view.addSubview(head_label)
        
        //判断是否显示时间
        if self.isShowTimeArray[section] as! Bool {
            head_label.text = cellValue["time"].stringValue
        }
        
        return head_view
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let foot_view = UIView()
        let cellValue = self.arrList[section]
        
        let foot_label = UILabel(frame: CGRect(x: 68, y: 0, width: kScreenW-68*2, height: customLayer(num: 14)))
        foot_label.font = customFont(font: 10)
        foot_label.textAlignment = .right
        foot_view.addSubview(foot_label)
        
        //p2s时需要显示已读、未读信息
        if cellValue["p2s"].boolValue {
            if cellValue["isRead"].boolValue{
                foot_label.text = "已读"
                foot_label.textColor = RGBColor(r: 153, g: 153, b: 153)
            }else{
                foot_label.text = "未读"
                foot_label.textColor = RGBColor(r: 76, g: 150, b: 208)
            }
        }
        return foot_view
    }
}

//table数量 及 cell内容
extension MsgDialogDetailViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // cell1
        var cell:MsgDialogDetailCellLeft = tableView.dequeueReusableCell(withIdentifier: "cellLeft") as! MsgDialogDetailCellLeft
        // cell1 复用
        if cell.isEqual(nil)
        {
            cell = MsgDialogDetailCellLeft.init(style: .default, reuseIdentifier: "cellLeft")
        }
        
        // cell2
        var cell2:MsgDialogDetailCellRight = tableView.dequeueReusableCell(withIdentifier: "cellRight") as! MsgDialogDetailCellRight
        // cell2 复用
        if cell2.isEqual(nil)
        {
            cell2 = MsgDialogDetailCellRight.init(style: .default, reuseIdentifier: "cellRight")
        }
        
        // cell3
        var cell3:MsgTipsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellTips") as! MsgTipsTableViewCell
        // cell3 复用
        if cell3.isEqual(nil)
        {
            cell3 = MsgTipsTableViewCell.init(style: .default, reuseIdentifier: "cellTips")
        }
        
        //最大label宽度
        cell.contentText.preferredMaxLayoutWidth = maxLabelW
        cell2.contentText.preferredMaxLayoutWidth = maxLabelW
        
        //设置cell内容
        let cellValue = arrList[indexPath.section]
        cell.setCellData(data: cellValue)
        
        if cellValue["isTips"].boolValue{
            cell3.setCellData(data: cellValue)
            return cell3
        }else if cellValue["p2s"].boolValue {
            cell2.setCellData(data: cellValue)
            return cell2
        }else{
            cell2.setCellData(data: cellValue)
            return cell
        }
        
    }
    
    //点击事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //点击后显示灰色背景 - 这样写只会闪一下
        tableView.deselectRow(at: indexPath, animated: true)
        
//        print("点击事件 in tableView(Offset.y):\(self.tableV.contentOffset.y) - \(self.tableV.contentSize.height)")
        self.dialogInputBar.inputText.resignFirstResponder()
    }
    
}

extension MsgDialogDetailViewController:DiaLogInputBarDelegate{
    func send(type: Int, value: String) {
        print("外部接受input bar的发送事件:\(value)")
        
        tableV.reloadData()
        scrollToBottom(animated: true)
    }
    
    
}
