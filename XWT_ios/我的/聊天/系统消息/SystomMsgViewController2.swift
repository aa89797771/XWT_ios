//
//  SystomMsgViewController2.swift
//  todayNews
//  SystomMsgTableViewCell SystomSystomMsgTableViewCell
//  Created by xushiqi on 2020/3/7.
//  Copyright © 2020 xushiqi. All rights reserved.
//

import UIKit
import SwiftyJSON
import SnapKit

class SystomMsgViewController2: FathViewController {
    //模拟数据
    var testArray = JSON()
    //可变高度数组 - 存放table每个cell的高度
//    var heightArray = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = bgGray
        self.navigationItem.title = "系统消息"
        
        self.view.addSubview(tableV)       // 添加表格
//        culculateTest()
        createData()
    }
    
    func createData(){
        testArray = [
            ["title":"赵无极1","content":"contentrioting","time":"12:20"],["title":"赵无极2","content":"为解决好中国鞋行业近年来严峻的出口形势问题，探 索全球化竞争的信心，新联鞋供应链股份有限公司与 鞋都房地产开发有限公司共同打造","time":"12:20"]
        ]
        
        //配置置高度信息
//        for (curInt, array) in self.testArray.enumerated(){
//
//            self.heightArray.add(1)
//        }
    }
    
    func culculateRect(){
            //外面view的最大宽度
            let maxW = kScreenW *  3/4
            //外面view 与 内部label的垂直内边距padding
            let paddingV:CGFloat = 10
            //外面view 与 内部label的水平内边距padding
            let paddingH:CGFloat = 10
            //实际展示的label宽度
            var showW:CGFloat = 0
            //实际展示的label高度
            var showH:CGFloat = 0
            //内部label的行高(上下padding此时都为0)
            let lineH:CGFloat = 10
            //自定义字体大小
            let fontCustom = customFont(font: 24)
            
            let title = "测试 测试 测试 测试 测试 测试测试 测试 测试 测试 测试 测试测试 测试 测试 测试 测试 测试测试 测试 测试 测试测试 测试 测试 测试 测试 测试测试 测试 测试 测试 测试 测试"
            
            //通过富文本来设置行间距
            let paraph = NSMutableParagraphStyle()
            //设置行间距
            paraph.lineSpacing = lineH
            let attributes = [NSAttributedString.Key.font: fontCustom, NSAttributedString.Key.paragraphStyle: paraph]
            
            
            // 当前文字宽高 NSStringDrawingOptions.init(arrayLiteral: [.usesFontLeading,.usesLineFragmentOrigin])
            let rect = title.boundingRect(with: CGSize(width: maxW, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: attributes, context: .none)
            
            print("计算出来的:\(rect)")
            showH = rect.size.height
            //文字超出 换行
            if maxW < rect.size.width{
    //            h = Calculate.textHeight(text: title, fontSize: fontSize, width: maxW)
                showW = maxW
            }else{
                showW = rect.size.width
            }
            
            let showLogBtn:UILabel = UILabel.init(frame: CGRect(x: paddingV, y: paddingH, width: showW - paddingV*2, height: showH))
            
            showLogBtn.text = title
            showLogBtn.font = fontCustom
            showLogBtn.numberOfLines = 0
            showLogBtn.attributedText = NSAttributedString(string: title, attributes: attributes)
            showLogBtn.backgroundColor = UIColor.red
            
            let viewWrap:UIView = UILabel.init(frame: CGRect(x: (kScreenW - showW) / 2, y: 250, width: showW, height: showH + paddingH*2))
            viewWrap.backgroundColor = UIColor.blue
            viewWrap.addSubview(showLogBtn)
            self.view.addSubview(viewWrap)
        }

    func culculateTest(){
            //外面view的最大宽度
            let maxW = kScreenW *  3/4
            //外面view 与 内部label的垂直内边距padding
            let paddingV:CGFloat = 10
            //外面view 与 内部label的水平内边距padding
            let paddingH:CGFloat = 10
            //实际展示的label宽度
            var showW:CGFloat = 0
            //实际展示的label高度
            var showH:CGFloat = 0
            //内部label的行高(上下padding此时都为0)
            let lineH:CGFloat = 10
            //自定义字体大小
            let fontCustom = customFont(font: 24)
            
            let title = "测试 测试 测试 测试 测试 测试测试 测试 测试 测试 测试 测试测试 测试 测试 测试 测试 测试测试 测试 测试 测试测试 测试 测试 测试 测试 测试测试 测试 测试 测试 测试 测试"
            
            //通过富文本来设置行间距
            let paraph = NSMutableParagraphStyle()
            //设置行间距
            paraph.lineSpacing = lineH
            let attributes = [NSAttributedString.Key.font: fontCustom, NSAttributedString.Key.paragraphStyle: paraph]
            
            
            // 当前文字宽高 NSStringDrawingOptions.init(arrayLiteral: [.usesFontLeading,.usesLineFragmentOrigin])
            let rect = title.boundingRect(with: CGSize(width: maxW, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: attributes, context: .none)
            
            print("计算出来的:\(rect)")
            showH = rect.size.height
            //文字超出 换行
            if maxW < rect.size.width{
    //            h = Calculate.textHeight(text: title, fontSize: fontSize, width: maxW)
                showW = maxW
            }else{
                showW = rect.size.width
            }
            
            let showLogBtn:UILabel = UILabel.init(frame: CGRect(x: paddingV, y: paddingH, width: showW - paddingV*2, height: showH))
            
            showLogBtn.text = title
            showLogBtn.font = fontCustom
            showLogBtn.numberOfLines = 0
            showLogBtn.attributedText = NSAttributedString(string: title, attributes: attributes)
            showLogBtn.backgroundColor = UIColor.red
            
            let viewWrap:UIView = UILabel.init(frame: CGRect(x: (kScreenW - showW) / 2, y: 250, width: showW, height: showH + paddingH*2))
            viewWrap.backgroundColor = UIColor.blue
            viewWrap.addSubview(showLogBtn)
            self.view.addSubview(viewWrap)
        }
    
    private lazy var tableV:UITableView = {
        let table = UITableView.init(frame: CGRect(x: customLayer(num: 20), y: kNavigationBarH, width: kScreenW - 2*customLayer(num: 20), height: kScreenH - kNavigationBarH), style: .grouped)
        table.rowHeight = UITableView.automaticDimension;
        table.estimatedRowHeight = 220;
        
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
extension SystomMsgViewController2{
    //显示的宽高
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return customLayer(num: 30)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return customLayer(num: 100)
        return UITableView.automaticDimension
//        return (self.heightArray[indexPath.section] as! CGFloat)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
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
//
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return nil
    }
}

//table数量 及 cell内容
extension SystomMsgViewController2:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // cell
        var cell:SystomMsgTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellOne") as! SystomMsgTableViewCell
        // cell 复用
        if cell.isEqual(nil)
        {
            cell = SystomMsgTableViewCell.init(style: .default, reuseIdentifier: "cellOne")
        }
        //取消第一行cellg分割线
//        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: kScreenW)
//        //cell设置圆角
//        let myLayer = CAShapeLayer()
//        let path = UIBezierPath.init(roundedRect: CGRect(x: 0, y: 0, width: kScreenW-customLayer(num: 20)*2, height: customLayer(num: 100)), byRoundingCorners: UIRectCorner.init(arrayLiteral: .topLeft,.topRight,.bottomLeft,.bottomRight), cornerRadii: CGSize(width: 10, height: 20))
//        myLayer.path = path.cgPath
//        cell.layer.mask = myLayer
        
        cell.msgTitle.text = "666"
        cell.msgContent.numberOfLines = 0
//        cell.msgContent.text =  testArray[indexPath.section]["content"].stringValue
        
        cell.msgContent.attributedText = getAttributedString(title: testArray[indexPath.section]["content"].stringValue, lineHeight: customLayer(num: 8))
//            testArray[indexPath.row]["title"].stringValue
       
//        "为解决好中国鞋行业近年来严峻的出口形势问题，探 索全球化竞争的信心，新联鞋供应链股份有限公司与 鞋都房地产开发有限公司共同打造"
        
        cell.msgContent?.preferredMaxLayoutWidth = tableView.bounds.size.width
        return cell
    }
    
    //设置label文本的行高
    func getAttributedString(title: String, lineHeight: CGFloat) -> NSAttributedString {
        //通过富文本来设置行间距
        let paraph = NSMutableParagraphStyle()
        //设置行间距
        paraph.lineSpacing = lineHeight
        let titleAttributes = [NSAttributedString.Key.paragraphStyle: paraph]
        
        //拼接并获取最终文本
        let titleString = NSMutableAttributedString(string: title,
            attributes: titleAttributes)
        return titleString
    }
    
    //点击事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //点击后显示灰色背景 - 这样写只会闪一下
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
}
