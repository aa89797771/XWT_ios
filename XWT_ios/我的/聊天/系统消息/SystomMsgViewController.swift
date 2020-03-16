//
//  SystomMsgViewController.swift
//  todayNews
//  SystomMsgTableViewCell SystomSystomMsgTableViewCell
//  Created by xushiqi on 2020/3/7.
//  Copyright © 2020 xushiqi. All rights reserved.
//

import UIKit
import SwiftyJSON
import SnapKit

class SystomMsgViewController: FathViewController {
    //模拟数据
    var testArray = JSON()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = bgGray
        self.navigationItem.title = "系统消息"
        
        self.view.addSubview(tableV)       // 添加表格
        createData()
    }
    
    func createData(){
        testArray = [
            ["title":"火爆采购单品",
             "content":"为解决好中国鞋行业近年来严峻的出口形势问题，探 索全球化竞争的信心，新联鞋供应链股份有限公司与 鞋都房地产开发有限公司共同打造","time":"今天 14:40"],
            ["title":"鞋产业服务移动端 领10万红包","content":"为解决好中国鞋行业近年来严峻的出口形势问题，探 信心，新联鞋供应链股份有限公司与鞋都房地产......","time":"星期三 09:23"],
            ["title":"鞋产业服务移动端 领10万红包","content":"为解决好中国鞋","time":"星期三 09:23"]
        ]
    }
    
    private lazy var tableV:UITableView = {
        let table = UITableView.init(frame: CGRect(x: customLayer(num: 20), y: kNavigationBarH, width: kScreenW - 2*customLayer(num: 20), height: kScreenH - kNavigationBarH), style: .grouped)
        table.rowHeight = UITableView.automaticDimension;
        table.estimatedRowHeight = customLayer(num: 120);
        
        table.delegate = self
        table.dataSource = self
        //有多少内容就创建多少cell
        table.tableFooterView = UIView.init()
        // 取消table的border
        table.separatorStyle = .none
        // 注册cell
        table.register(UINib.init(nibName: "SystomMsgTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "cellOne")
        
        return table
    }()

}
//table高度
extension SystomMsgViewController{
    //显示的宽高
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}

//table数量 及 cell内容
extension SystomMsgViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // cell
        var cell:SystomMsgTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellOne") as! SystomMsgTableViewCell
        // cell 复用
        if cell.isEqual(nil)
        {
            cell = SystomMsgTableViewCell.init(style: .default, reuseIdentifier: "cellOne")
        }
        
        cell.delegate = self
        
        cell.dialogBox.layer.cornerRadius = 10
        cell.dialogBox.layer.masksToBounds = true //设置圆角
        
        cell.msgTitle.text = testArray[indexPath.row]["title"].stringValue
        
        cell.msgContent.preferredMaxLayoutWidth = kScreenW - 2*customLayer(num: 20 + 20)
        
        let msgContent = testArray[indexPath.row]["content"].stringValue
        
        let attrString = getAttributes(lineHeight: customLayer(num: 8), font:customFont(font: 13))
        //label需要设置行高,所以用下面的写法
        cell.msgContent.attributedText =
        NSMutableAttributedString(string: msgContent,
        attributes: attrString)
        
        //计算文本大小
        let cellRect = culculateRect(titleText: msgContent,
                                     maxWidth: kScreenW - 2*customLayer(num: 20 + 16),
                                     attributes: attrString)
        print("cellRect is \(cellRect)")
        print("cellRect.size.height \(cellRect.size.height):\(2 * customLayer(num: 13))")
        //文字少,不需要全文显示按钮
//        if cellRect.size.height < 3 * customLayer(num: 13){
//            cell.seeAllBtn.isHidden = true
//        }else{
//            cell.seeAllBtn.isHidden = false
//        }
        let isOpen = testArray[indexPath.row]["isOpen"].boolValue
        
        print("传值进去前的isOpen:\(isOpen)")
//        print("传值进去前行高:\(customLayer(num: 8))")
//        print("传值进去前行高:\(customLayer(num: 13))")
        cell.isOpen = isOpen
        cell.indexPathRow = indexPath.row
        
        cell.selectionStyle = .none
        
        //改变cell内部的文字高度
        if !isOpen {
            cell.msgContent.numberOfLines = 2
//            cell.seeAllBtn.setTitle("全文", for: .normal)
        }else{
            cell.msgContent.numberOfLines = 0
//            cell.seeAllBtn.setTitle("收起", for: .normal)
        }
        
        
//        cell.msgContent?.preferredMaxLayoutWidth = tableView.bounds.size.width
        return cell
    }
    
    //设置label文本的行高
    func getAttributedString(title: String, attributes: [NSAttributedString.Key : Any]) -> NSAttributedString {
        //拼接并获取最终文本
        let titleString = NSMutableAttributedString(string: title,
            attributes: attributes)
        return titleString
    }
    
    
    //点击事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //点击后显示灰色背景 - 这样写只会闪一下
        tableView.deselectRow(at: indexPath, animated: true)
        self.testArray[indexPath.row]["isOpen"] = self.testArray[indexPath.row]["isOpen"].boolValue ? false : true
        
        // 只刷新当前cell
        let inde = NSIndexPath.init(row: 0, section: indexPath.row)
        self.tableV.reloadRows(at: [inde as IndexPath], with: .fade)
    }
    
    
}


//是否确认清楚缓存
extension SystomMsgViewController:SystomMsgCellDelegate{
    //取消事件
    func seeAllToggle(isOpen:Bool, indexPathRow:Int) {
        testArray[indexPathRow]["isOpen"] = JSON(isOpen)
        
        print("回调出来的值:\(isOpen) - \(indexPathRow)")
        
        self.tableV.reloadData()
    }
}
