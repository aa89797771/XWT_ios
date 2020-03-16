//
//  PersonalInfoViewController222.swift
//  todayNews
//
//  Created by xushiqi on 2020/3/5.
//  Copyright © 2020 xushiqi. All rights reserved.
//

import UIKit

class PersonalInfoViewController222: UIViewController {
    //左侧文字数组 mainTxtArr
    var arrList = NSArray()
    //存放右侧文字的数组 detailTxtArray
    var detailArray = NSMutableArray()
    // 头部视图高度
    let headHeight:CGFloat = 150
    //cell高度 - 设置圆角有用到
    let cellHeight:CGFloat = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "个人信息"
        
        self.view.addSubview(tableV)
        
        tableV.addSubview(headTabView)   // 头部视图

        createDatas()
    }
    
    private func createDatas(){
        arrList = [
            ["邮箱","手机号码","修改密码","语言"]
        ]
        detailArray = [
            ["1203609994@qq.com","18757097990","","简体中文"]
        ]
    }
    
    // tableHeadView
    private lazy var headTabView : HeadMineView = {
        
        let head_v = HeadMineView.loadFromNib()
        head_v.frame = CGRect(x: 0, y: -headHeight + 20, width: kScreenW, height: headHeight)
//        head_v.wrapView.backgroundColor = UIColor.blue
        head_v.wrapView.tag = 101
//        head_v.delegate = self
        
        return head_v
    }()
    
    // table初始化
    private lazy var tableV : UITableView = {
        
        let table = UITableView.init(frame: CGRect(x: 0, y: kNavigationBarH, width: kScreenW, height: kScreenH - kNavigationBarH), style: .grouped)
        table.delegate = self
        table.dataSource = self
        table.contentInset = UIEdgeInsets(top: headHeight - 20, left: 0, bottom: 0, right: 0)
        table.backgroundColor = RGBColor(r: 245, g: 245, b: 245)
        table.backgroundColor = UIColor.gray
        
        // 取消table的border
        table.separatorStyle = .none

        
        // 去掉头部空白
        if #available(iOS 11.0, *) {
            table.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        return table
    }()
}

extension PersonalInfoViewController222 : UITableViewDelegate,UITableViewDataSource{
    // 行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    // 分区头高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0.01 : 5
    }
    // 分区尾高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    // 分区头视图
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    // 分区尾视图
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // cell
        var cell = tableView.dequeueReusableCell(withIdentifier: "seller")
        
        if cell == nil
        {
            cell = UITableViewCell.init(style: .value1, reuseIdentifier: "seller")
        }
        
        //cell设置圆角
        for (curInt,_) in self.arrList.enumerated(){
            if indexPath.section == curInt {
                if indexPath.row == 0{
                    let myLayer = CAShapeLayer()
                    let path = UIBezierPath.init(roundedRect: CGRect(x: 0, y: 0, width: kScreenW, height: cellHeight), byRoundingCorners: UIRectCorner.init(arrayLiteral: .topLeft,.topRight), cornerRadii: CGSize(width: 10, height: 10))
                    myLayer.path = path.cgPath
                    cell!.layer.mask = myLayer
                }else if indexPath.row == (self.arrList[indexPath.section] as! NSArray).count - 1{
                    let myLayer = CAShapeLayer()
                    let path = UIBezierPath.init(roundedRect: CGRect(x: 0, y: 0, width: kScreenW, height: cellHeight), byRoundingCorners: UIRectCorner.init(arrayLiteral: .bottomLeft, .bottomRight), cornerRadii: CGSize(width: 10, height: 10))
                    myLayer.path = path.cgPath
                    cell!.layer.mask = myLayer
                }
            }
        }
        
        // cell 属性（颜色、字体、大小）
        cell?.textLabel?.text = (arrList[indexPath.section] as! NSArray)[indexPath.row] as? String
        cell?.textLabel?.font = customFont(font: 16)
        cell?.textLabel?.textColor = RGBColor(r: 34, g: 34, b: 34)
        
        // 箭头类型cell
        if indexPath.section == 0
        {
            cell?.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        }
        
        return cell!
    }
    
    // 点击cell时处理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // 滑动时方法头部保持白色背景
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let point = scrollView.contentOffset
        
        var rect = headTabView.viewWithTag(101)?.frame
        print(point.y)
        if point.y < -headHeight
        {
            let y = abs(point.y)
            
            rect?.size.height = y
            rect?.origin.y = headHeight - y
            
            headTabView.viewWithTag(101)?.frame = rect!
        }
    }
}
