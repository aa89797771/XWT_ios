//
//  SelectLanguageViewController.swift
//  todayNews
//
//  Created by xushiqi on 2020/3/5.
//  Copyright © 2020 xushiqi. All rights reserved.
//

import UIKit
import SwiftyJSON

class SelectLanguageViewController: FathViewController {
    //左侧文字数组 mainTxtArr
    var arrList = JSON()
    //当前选中项index
    var selectedId = 1
    var selectedLanguage = "简体中文"
    //cell高度 - 设置圆角有用到
    let cellHeight:CGFloat = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "选择语言"
        
        self.view.addSubview(tableV)
        createDatas()
    }

    private func createDatas(){
        arrList = [
            ["text": "简体中文", "id": 1],
            ["text": "繁体中文", "id": 2],
            ["text": "西班牙语", "id": 3],
            ["text": "韩语", "id": 4],
            ["text": "意大利语", "id": 5],
            ["text": "俄罗斯语", "id": 6],
            ["text": "德语", "id": 7],
            ["text": "非洲语", "id": 8]
        ]
    }
    
    // table初始化
    private lazy var tableV : UITableView = {
        
        let table = UITableView.init(frame: CGRect(x: 0, y: kNavigationBarH, width: kScreenW, height: kScreenH - kNavigationBarH), style: .grouped)
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = bgGray
        
        // 去掉头部空白
        if #available(iOS 11.0, *) {
            table.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        return table
    }()
}

extension SelectLanguageViewController : UITableViewDelegate,UITableViewDataSource{
    // 行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    // 分区头高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 71
    }
    // 分区尾高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    // 分区头视图
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let head_view = UIView()
        let label = UILabel.init(frame: CGRect(x: 21, y: 35, width: kScreenW - 42, height: 14))
        label.text = "当前选择语言：\(selectedLanguage)"
        label.textColor = RGBColor(r: 51, g: 51, b: 51)
        label.font = customFont(font: 13)
        head_view.addSubview(label)
        
        return head_view
    }
    // 分区尾视图
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
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
        
        // cell 属性（颜色、字体、大小）
        cell?.textLabel?.text = arrList[indexPath.row]["text"].stringValue
        cell?.textLabel?.font = customFont(font: 16)
        cell?.textLabel?.textColor = RGBColor(r: 34, g: 34, b: 34)
        cell?.accessoryType = UITableViewCell.AccessoryType.none
        
        
        // 选中项 箭头类型cell
        if arrList[indexPath.row]["id"].int == selectedId
        {
            cell?.textLabel?.textColor = RGBColor(r: 230, g: 100, b: 95)
            cell?.accessoryType = UITableViewCell.AccessoryType.checkmark
            cell?.tintColor = RGBColor(r: 230, g: 100, b: 95)
        }
        
        return cell!
    }
    
    // 点击cell时处理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        selectedId = arrList[indexPath.row]["id"].int!
        selectedLanguage = arrList[indexPath.row]["text"].stringValue
        tableView.reloadData()
    }
    
}
