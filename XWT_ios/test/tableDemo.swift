//
//  tableVCDemo.swift
//  todayNews
//
//  Created by xushiqi on 2020/3/7.
//  Copyright © 2020 xushiqi. All rights reserved.
//

import UIKit
import SwiftyJSON

class tableVCDemo: FathViewController {
    //模拟数据
    var arrList = JSON()
    //可变高度数组 - 存放table每个cell的高度
    var heightArray = NSMutableArray()
    //cell中label的宽度
    let maxLabelW = kScreenW - 2*customLayer(num: 20 + 16)
    var attrString:[NSAttributedString.Key : Any]?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = bgGray
        self.navigationItem.title = "系统消息"
        
        self.view.addSubview(tableV)       // 添加表格
//        culculateTest()
        
        createDatas()
    }
    
    private func createDatas(){
        arrList = [
            [["header":"https://profile.csdnimg.cn/F/3/9/3_wxs0124",
            "content":"为解决好中国鞋行业近年来严峻的出口形势问题，探 索全球化竞争的信心，新联鞋供应链解决好中国鞋行业近年来严峻的出口形势问题，探 索全球化竞争的信心，新联 鞋供应链","time":"今天 14:40"]]
        ]
        
        attrString = getAttributes(lineHeight: customLayer(num: 8), font:customFont(font: 13))
        //配置置高度信息
        for (curInt, _) in self.arrList.enumerated(){
            let rect = culculateRect(titleText: self.arrList[curInt]["content"].stringValue, maxWidth: maxLabelW, attributes: attrString!)
//            self.labelHeightArray.add(rect.size.height)
//            //文字过长(需要展开显示),显示2行的高度,同时保留展开的高度
//            if rect.size.height > labelHWhen2Row {
//                self.heightArray.add(otherHeight + labelHWhen2Row )
//                self.heightArrayCache.add(otherHeight + rect.size.height )
//            //否则不需要展开显示,显示label的原始高度,同时减去btn的高度(此时btn隐藏)
//            }else{
//                self.heightArray.add(otherHeight + rect.size.height - btnBlockH )
//                self.heightArrayCache.add(otherHeight + rect.size.height - btnBlockH )
//            }

        }
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
        let table = UITableView.init(frame: CGRect(x: 0, y: kNavigationBarH, width: kScreenW, height: kScreenH - kNavigationBarH), style: .grouped)
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
        table.register(UINib.init(nibName: "MsgTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "cellOne")
        
        return table
    }()

}
//table高度
extension tableVCDemo:UITableViewDelegate,UITableViewDataSource{
    //显示的宽高
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
//        return customLayer(num: 50)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let foot_view = UIView()
        let foot_label = UILabel(frame: CGRect(x: 20, y: 0, width: kScreenW-40, height: 20))
        foot_label.text = "All Right's Reserved By Toutiao.com"
        foot_label.font = customFont(font: 14)
        foot_label.textColor = RGBColor(r: 153, g: 153, b: 153)
        foot_label.textAlignment = .center
        foot_view.addSubview(foot_label)
        return nil
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return nil
    }
}

//table数量 及 cell内容
extension tableVCDemo{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        // cell - 默认
//        var cell = tableView.dequeueReusableCell(withIdentifier: "seller")
//
//        if cell == nil
//        {
//            cell = UITableViewCell.init(style: .value1, reuseIdentifier: "seller")
//        }
        
        // cell
        var cell:MsgTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellOne") as! MsgTableViewCell
        // cell 复用
        if cell.isEqual(nil)
        {
            cell = MsgTableViewCell.init(style: .default, reuseIdentifier: "cellOne")
        }
//        cell.msgTitle.text = "666"
//        cell?.textLabel?.text = arrList[indexPath.row]["text"].stringValue
//        cell?.textLabel?.font = customFont(font: 16)
//        cell?.textLabel?.textColor = RGBColor(r: 34, g: 34, b: 34)
//        cell?.detailTextLabel!.text = (detailArray[indexPath.row] as! String)
        
        //设置cell内容
        let cellValue = arrList[indexPath.section]
//        cell.setCellData(data: cellValue)
        
        //最大label宽度
//        cell.contentText.preferredMaxLayoutWidth = maxLabelW
        
        // 取消table的border
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: kScreenW)
        return cell
    }
    
    //点击事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //点击后显示灰色背景 - 这样写只会闪一下
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
