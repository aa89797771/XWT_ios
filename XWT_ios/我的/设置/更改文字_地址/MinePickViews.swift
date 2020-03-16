//
//  MinePickViews.swift
//  todayNews
//
//  Created by xushiqi on 2020/3/13.
//  Copyright © 2020 xushiqi. All rights reserved.
//

import UIKit
// 代理传值
protocol MinePickDelegate : NSObjectProtocol {
    // 确定 取消
    func minePickChange(value:String, index:NSInteger, address: String)
}
class MinePickViews: UIView {
    //显示的pick类型 1.省份 3.市区县
    var type = 1
//    var  jsonArr = NSArray()
//    var comArr = NSArray()
//    var first = "", twoText = ""
    
    var jsonArr = ["浙江省","江苏省","福建省","安徽省","江西省","湖北省","山东省"]
    var city = ["温州","台州","丽水","衢州","杭州"]
    var district = ["永嘉","瓯海","鹿城","洞头"]
    var street = ["梧田","叫峰北路","南塘","双鱼","工业区"]
    
    // 代理属性
    weak var delegate : MinePickDelegate?
    @IBAction func cancel(_ sender: Any) {
        delegate?.minePickChange(value: "", index: 1, address: "")
    }
    
    @IBAction func confirm(_ sender: Any) {
        delegate?.minePickChange(value: "", index: 1, address: "")
    }
    @IBOutlet weak var pickAddress: UIPickerView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createData()
        self.pickAddress.delegate = self
    }
    func refreshData(type: Int){
        self.type = type
        pickAddress.reloadAllComponents()
    }
}
extension MinePickViews{
    class func loadFromNib()->MinePickViews{
        return Bundle.main.loadNibNamed("MinePickViews", owner: nil, options: nil)?[0] as! MinePickViews
    }
}

extension MinePickViews
{
    private func createData() {
        print("create pick Data")
        
        // 获取所有内容
//        jsonArr = ["浙江省","江苏省","福建省","安徽省","江西省","湖北省","山东省"]
//        comArr = (jsonArr[0] as! NSDictionary)["c"] as! NSArray
        
        // 默认地址
//        first = jsonArr[0] as! String
//        twoText = (comArr[0] as! NSDictionary)["t"] as! String
        
        // 属性pick
        pickAddress.reloadAllComponents()
    }
}

extension MinePickViews : UIPickerViewDelegate,UIPickerViewDataSource
{
    // 多少列
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if type == 1 {
            return 1
            
        }else if type == 3 {
            return 3
        }
        
        return 0
    }
    
    // 每列个数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if type == 1 {
            return jsonArr.count
            
        }else if type == 3 {
            if component == 0
            {
                return city.count
            }
            else if component == 1
            {
                return district.count
            }
            else if component == 2
            {
                return street.count
            }
        }
        
        return 0
    }
    
    // 每列内容
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if type == 1 {
            return jsonArr[row] as? String
            
        }else if type == 3 {
            if component == 0
            {
                return city[row] as? String
            }
            else if component == 1
            {
                return district[row] as? String
            }
            else if component == 2
            {
                return street[row] as? String
            }
        }
        
        return ""
    }
    
    // 点击每个内容时
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
//        if component == 0
//        {
//            // 点击第一个component获取第二个component的内容数组
//            comArr = (jsonArr[row] as! NSDictionary)["c"] as! NSArray
//
//            // 只点击城市默认地址
//            first = (jsonArr[row] as! NSDictionary)["t"] as! String
//
//            pickAddress.selectRow(0, inComponent: 1, animated: true)
//
//            twoText = (comArr[0] as! NSDictionary)["t"] as! String
//        }
//        else
//        {
//            // 只点击城市对应的区默认地址
//            let curInd = pickerView.selectedRow(inComponent: 0)
//
//            first = (jsonArr[curInd] as! NSDictionary)["t"] as! String
//
//            twoText = (comArr[row] as! NSDictionary)["t"] as! String
//        }
//
//        pickAddress.reloadComponent(1)
        
    }
    
}
