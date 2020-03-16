//
//  SystomMsgViewController3.swift
//  todayNews
//  MsgTableViewCell SystomMsgTableViewCell
//  Created by xushiqi on 2020/3/7.
//  Copyright © 2020 xushiqi. All rights reserved.
//

import UIKit
import SwiftyJSON
import SnapKit

class SystomMsgViewController3: FathViewController {
    var labelHWhen2Row:CGFloat = customLayer(num: 40)
    //模拟数据
    var testArray = JSON()
    //label的Attributes数据
    let attrString = getAttributes(lineHeight: customLayer(num: 8), font:customFont(font: 13))
    
//    let labelHWhen2Row:CGFloat = customLayer(num: 40)
    //可变高度数组 - 存放table每个cell的高度
    var heightArray = NSMutableArray()
    //可变高度数组 - 存放table每个cell的高度 - 缓存
    var heightArrayCache = NSMutableArray()
    //可变高度数组 - cell中label的高度
    var labelHeightArray = NSMutableArray()
    let labelW = kScreenW - 2*customLayer(num: 20 + 16)
    //除了label之外的元素的大概高度
    let otherHeight:CGFloat = customLayer(num: 70)
    //按钮所占区域的大概高度
    let btnBlockH:CGFloat = customLayer(num: 20)

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = bgGray
        self.navigationItem.title = "系统消息"
        
        self.view.addSubview(tableV)       // 添加表格
        createData()
    }
    
    func createData(){
        //模拟2行时label的高度
        self.labelHWhen2Row = culculateRect(titleText: "为解决好中国鞋行业近年来严峻的出口形势问题，探 信心，新联鞋供应链股份有限公司", maxWidth: labelW, attributes: attrString).size.height
        
        testArray = [
            ["title":"火爆采购单品",
             "content":"为解决好中国鞋行业近年来严峻的出口形势问题，探 索全球化竞争的信心，新联鞋供应链解决好中国鞋行业近年来严峻的出口形势问题，探 索全球化竞争的信心，新联 鞋供应链","time":"今天 14:40"],
            ["title":"鞋产业服务移动端 领10万红包","content":"为解决好中国鞋行业近年来严峻的出口形势问题，探信心，新联鞋供应链股份有限公司与鞋都房地产......新联鞋供应","time":"星期三 09:23"],
            ["title":"鞋产业服务移动端 领10万红包","content":"为解决好中国鞋","time":"星期三 09:23"]
        ]
        
        //配置置高度信息
        for (curInt, _) in self.testArray.enumerated(){
            let rect = culculateRect(titleText: self.testArray[curInt]["content"].stringValue, maxWidth: labelW, attributes: attrString)
            self.labelHeightArray.add(rect.size.height)
            //文字过长(需要展开显示),显示2行的高度,同时保留展开的高度
            if rect.size.height > labelHWhen2Row {
                self.heightArray.add(otherHeight + labelHWhen2Row )
                self.heightArrayCache.add(otherHeight + rect.size.height )
            //否则不需要展开显示,显示label的原始高度,同时减去btn的高度(此时btn隐藏)
            }else{
                self.heightArray.add(otherHeight + rect.size.height - btnBlockH )
                self.heightArrayCache.add(otherHeight + rect.size.height - btnBlockH )
            }
            
        }
    }
    
    private lazy var tableV:UITableView = {
        let table = UITableView.init(frame: CGRect(x: customLayer(num: 20), y: kNavigationBarH, width: kScreenW - 2*customLayer(num: 20), height: kScreenH - kNavigationBarH), style: .grouped)
//        table.rowHeight = UITableView.automaticDimension;
//        table.estimatedRowHeight = customLayer(num: 120);
        
        table.delegate = self
        table.dataSource = self
        //有多少内容就创建多少cell
        table.tableFooterView = UIView.init()
        // 取消table的border
        table.separatorStyle = .none
        // 注册cell
        table.register(UINib.init(nibName: "MsgTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "cellOne")
        
        return table
    }()

}
//table高度
extension SystomMsgViewController3{
    //显示的宽高
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return customLayer(num: 30)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.heightArray[indexPath.section] as! CGFloat
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let foot_view = UIView()
        let foot_label = UILabel(frame: CGRect(x: 0, y: customLayer(num: 10), width: kScreenW-customLayer(num: 20)*2, height: customLayer(num: 20)))
        foot_label.text = "12:20"
        foot_label.font = customFont(font: 14)
        foot_label.textColor = RGBColor(r: 153, g: 153, b: 153)
        foot_label.textAlignment = .center
        foot_view.addSubview(foot_label)
        return foot_view
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}

//table数量 及 cell内容
extension SystomMsgViewController3:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return testArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // cell
        var cell:MsgTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellOne") as! MsgTableViewCell
        // cell 复用
        if cell.isEqual(nil)
        {
            cell = MsgTableViewCell.init(style: .default, reuseIdentifier: "cellOne")
        }
        //取消cell选中样式
//        cell.selectionStyle = .none
        cell.delegate = self
        
        //设置圆角
        cell.layer.cornerRadius = 6
        cell.layer.masksToBounds = true
        
        //设置标题
        cell.msgTitle.text = testArray[indexPath.section]["title"].stringValue
        
        //设置内容
        let msgContent = testArray[indexPath.section]["content"].stringValue
        //label需要设置行高,所以用下面的写法
        cell.msgContent.attributedText =
        NSMutableAttributedString(string: msgContent,
        attributes: attrString)
        
        //cell.msgContent.preferredMaxLayoutWidth = labelW
        
        //文字少,不需要全文显示按钮
        if (ceil(self.labelHeightArray[indexPath.section] as! CGFloat)) <= (ceil(self.labelHWhen2Row)) {
            cell.seeAllBtn.isHidden = true
        }else{
            cell.seeAllBtn.isHidden = false
        }
        
        //点击按钮时需要传出来的值
        let isOpen = testArray[indexPath.section]["isOpen"].boolValue
        cell.isOpen = isOpen
        cell.indexPathRow = indexPath.section
        
        //关闭、展开时的样式
//        if !isOpen {
//            cell.msgContent.numberOfLines = 2
//            cell.seeAllBtn.setTitle("全文", for: .normal)
//        }else{
//            cell.msgContent.numberOfLines = 0
//            cell.seeAllBtn.setTitle("收起", for: .normal)
//        }
        
        return cell
    }
    
    
    //点击事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //点击后显示灰色背景 - 这样写只会闪一下
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
}


//cell代理
extension SystomMsgViewController3:MsgCellDelegate{
    //点击全文展开、关闭事件
    func seeAllToggle(isOpen:Bool, indexPathRow:Int) {
        testArray[indexPathRow]["isOpen"] = JSON(isOpen)
        
        let cacheH = self.heightArrayCache[indexPathRow]
        //cell展示的高度
        let showH = isOpen ? cacheH : (labelHWhen2Row + otherHeight)
        
        print("回调出来的值:\(isOpen) - \(indexPathRow) - \(showH)")
        print("回调出来的值2:\(self.heightArray) - \(self.heightArrayCache)")
        self.heightArray.replaceObject(at: indexPathRow, with: showH)
//        self.tableV.reloadData()
        
        // 只刷新当前cell
        let inde = NSIndexPath.init(row: 0, section: indexPathRow)
        self.tableV.reloadRows(at: [inde as IndexPath], with: .fade)
    }
}
