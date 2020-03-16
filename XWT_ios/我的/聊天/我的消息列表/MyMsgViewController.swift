//
//  MyMsgViewController.swift
//  todayNews
//
//  Created by xushiqi on 2020/3/10.
//  Copyright © 2020 xushiqi. All rights reserved.
//

import UIKit
import SwiftyJSON

class MyMsgViewController: FathViewController {
    //模拟数据
    var testArray = JSON()
    //顶部搜索栏高度
    let searchBarH:CGFloat = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "我的消息"

        self.view.addSubview(searchBar)
        self.view.addSubview(tableV)       // 添加表格
        
        createData()
    }
    
    func createData(){
        testArray = [
            ["name":"赵无极","url":"https://profile.csdnimg.cn/F/3/9/3_wxs0124","count":"1",
             "isRead": true,
             "content":"为解决好中国鞋行业近年来严峻的出口形势问题，探 索全球化竞争的信心，新联鞋供应链股份有限公司与 鞋都房地产开发有限公司共同打造","time":"今天 14:40"],
           ["name":"赵无极2","url":"https://profile.csdnimg.cn/F/3/9/3_wxs0124","count":"31",
            "isRead": false,
            "content":"为解决好中打造","time":"今天 14:40"],
           
           ["name":"赵无极3","url":"https://profile.csdnimg.cn/F/3/9/3_wxs0124",
           "content":"为解决好中国鞋行业近年来严峻的出口形势问题，探 索全球化竞争的信心，新联鞋供应链股造","time":"今天 14:40"],
        ]
    }
    
    //顶部搜索栏
    private lazy var searchBar:MyMsgSearchView = {
        let searchBar = MyMsgSearchView.loadFromNib()
        searchBar.frame = CGRect(x: 0, y: kNavigationBarH, width: kScreenW, height: searchBarH)
//        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var tableV:UITableView = {
        let table = UITableView.init(frame: CGRect(x: 0, y: kNavigationBarH + searchBarH, width: kScreenW, height: kScreenH - kNavigationBarH - searchBarH), style: .grouped)
        table.delegate = self
        table.dataSource = self
        //有多少内容就创建多少cell
        table.tableFooterView = UIView.init()
        // 取消table的border
        table.separatorStyle = .none
        // 注册cell
        table.register(UINib.init(nibName: "MyMsgTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "cellOne")
        
        return table
    }()
    
    //手指触控事件
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //input退出编辑状态
        self.view.endEditing(true)
    }
}
//table高度
extension MyMsgViewController{
    //显示的宽高
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return customLayer(num: 5)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return customLayer(num: 56)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView.init()
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}

//table数量 及 cell内容
extension MyMsgViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // cell
        var cell:MyMsgTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellOne") as! MyMsgTableViewCell
        // cell 复用
        if cell.isEqual(nil)
        {
            cell = MyMsgTableViewCell.init(style: .default, reuseIdentifier: "cellOne")
        }
        
        //设置cell内容
        let cellValue = testArray[indexPath.row]
        cell.setCellData(data: cellValue)
        
        return cell
    }
    
    //点击事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //点击后显示灰色背景 - 这样写只会闪一下
        tableView.deselectRow(at: indexPath, animated: true)
        
        let msgDetailVC = MsgDialogDetailViewController()
        self.navigationController?.pushViewController(msgDetailVC, animated: true)
    }
}
