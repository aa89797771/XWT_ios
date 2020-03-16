
//
//  ViewController.swift
//  A-ZSort
//
//  Created by 朴子hp on 2018/9/1.
//  Copyright © 2018年 朴子hp. All rights reserved.
//

import UIKit
import SwiftyJSON

//let kScreenW  = UIScreen.main.bounds.width
//let kScreenH  = UIScreen.main.bounds.height

class TestVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    //设计稿中的headerHeight
    let headerHeight = customLayer(num: 34)
    //第一个和最后一个cell的padding值
    let firstCellPaddingHeight = customLayer(num: 11)
    //cell的背景色
    let cellBg = UIColor.white
    
    
    var testArray = JSON()
    // 排序后分组数据
    private var objectsArray : [[SortObjectModel]]?
    // 头部标题keys
    private var keysArray:[String]?
    
    var tabView : UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    //MARK: 建立主要视图
    func setUpTabView() -> Void {
        tabView = UITableView.init(frame: CGRect.init(x: 0, y: kNavigationBarH, width: kScreenW, height: kScreenH - kNavigationBarH), style: .grouped)
        tabView?.tableFooterView = UIView.init()
        tabView?.tableHeaderView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        tabView?.separatorStyle = .none
        tabView?.dataSource = self
        tabView?.delegate = self
        tabView?.backgroundColor = RGBColor(r: 245, g: 244, b: 247)
        // 注册cell
        tabView?.register(UINib.init(nibName: "TestTableViewCell1", bundle: Bundle.main), forCellReuseIdentifier: "cellOne")
        self.view.addSubview(tabView!)
        
        //测试数据
//        let testArray = ["赵无极","钱","孙","李","里","周","吴","郑","王","秦","亲","还","好","赵","钱","孙","李","里","周","吴","郑","王","秦","亲","还","好","赵","钱","孙","李","里","周","吴","郑","王","秦","亲","还","好"]
        testArray = [["name":"赵无极","url":"https://profile.csdnimg.cn/F/3/9/3_wxs0124"],
                         ["name":"赵无极2","url":"https://profile.csdnimg.cn/F/3/9/3_wxs0124"],["name":"赵无极3","url":"https://profile.csdnimg.cn/F/3/9/3_wxs0124"],
        ["name":"xu","url":"https://profile.csdnimg.cn/F/3/9/3_wxs0124"],
        ["name":"徐2","url":"https://profile.csdnimg.cn/F/3/9/3_wxs0124"],["name":"许","url":"https://profile.csdnimg.cn/F/3/9/3_wxs0124"]]
        
        //基于 UILocalizedIndexedCollation 调用其方法
        UILocalizedIndexedCollation.getCurrentKeysAndObjectsData(needSortArray: testArray ) { (dataArray,titleArray) in
            self.objectsArray = dataArray
            self.keysArray    = titleArray
            self.tabView?.reloadData()
        }
    }
    
    //MARK: tabView数据源及代理相关
    func numberOfSections(in tableView: UITableView) -> Int {
        return keysArray!.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectsArray![section].count
    }
    //MARK: 这是Setion标题 以及右侧索引数组设置
    //    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        return keysArray?[section]
    //    }
        
    //MARK: 设置表头的高度。如果使用自定义表头，该方法必须要实现，否则自定义表头无法执行，也不会报错
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //原先geader高度为34,但是第一个cell和最后一个cell高度高一点,不好设置
        //现在那块的高度写在header里进行挖坑
        //第一个header显示下面的白条(34 + 11)
        //之后的header显示上面及下面的白条(34 + 11*2)
        if section == 0{
            return headerHeight + firstCellPaddingHeight
        }
        
        return headerHeight + firstCellPaddingHeight * 2
    }
    // 分区头视图
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        //原先geader高度为34,但是第一个cell和最后一个cell高度高一点,不好设置
        //现在那块的高度写在header里进行挖坑
        //第一个header显示下面的白条(34 + 11)
        //之后的header显示上面及下面的白条(34 + 11*2)
        //白条用的背景view
        let head_view_bg = UIView()
        head_view_bg.backgroundColor = cellBg
        
        //正常设计稿的样式
        let head_view = UIView()
        head_view.backgroundColor = RGBColor(r: 245, g: 244, b: 247)
        head_view.frame = CGRect(x: 0, y: 0, width: kScreenW, height: headerHeight)
        //之后的header需要显示上面的一白条,所以位置需要往下一点点
        if section != 0 {
            head_view.frame = CGRect(x: 0, y: firstCellPaddingHeight, width: kScreenW, height: headerHeight)
        }
        let label = UILabel.init(frame: CGRect(x: 20, y: customLayer(num: 15), width: kScreenW - 40, height: 10))
        label.text = keysArray?[section]
        label.textColor = RGBColor(r: 153, g: 153, b: 153)
        label.font = customFont(font: 12)
        head_view_bg.addSubview(head_view)
        head_view.addSubview(label)
        
        return head_view_bg
    }
    // 分区尾高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == keysArray!.count - 1 {
            return firstCellPaddingHeight
        }
        return 0
    }
    // 分区尾视图
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        //正常设计稿的样式
        let head_view = UIView()
        head_view.backgroundColor = cellBg
        head_view.frame = CGRect(x: 0, y: 0, width: kScreenW, height: firstCellPaddingHeight)
        return head_view
    }
    
    //右侧索引
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        tableView.sectionIndexColor = RGBColor(r: 102, g: 102, b: 102)
        return keysArray
    }
    
    // 行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return customLayer(num: 48)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 置顶cell
        var cell:TestTableViewCell1 = tableView.dequeueReusableCell(withIdentifier: "cellOne") as! TestTableViewCell1
        // cell 复用
        if cell.isEqual(nil)
        {
            cell = TestTableViewCell1.init(style: .default, reuseIdentifier: "cellOne")
        }
        // 取消cell分割线
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: kScreenW)
        cell.backgroundColor = cellBg
        cell.cellData(value: objectsArray![indexPath.section][indexPath.row ])
        
        return cell
    }

    // 点击cell时处理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}
