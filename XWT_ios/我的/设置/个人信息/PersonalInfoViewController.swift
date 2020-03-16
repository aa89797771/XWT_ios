//
//  PersonalInfoViewController.swift
//  todayNews
//
//  Created by xushiqi on 2020/3/5.
//  Copyright © 2020 xushiqi. All rights reserved.
//

import UIKit
import SwiftyJSON

class PersonalInfoViewController: FathViewController {
    // 头像
    var headImg:UIImageView?
    
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
        self.view.addSubview(headTabView)   // 头部视图
        self.view.addSubview(tableV)

        createDatas()
    }
    private func createDatas(){
        arrList = [
            ["头像","昵称","公司","地址"]
        ]
        detailArray = [
            ["https://profile.csdnimg.cn/F/3/9/3_wxs0124","无敌火箭队少女","温州迪盛鞋业有限公司","温州市 瓯海区 蛟凤北路5号温州市 瓯海区 蛟凤北路5号"]
        ]
    }
    
    // tableHeadView
    private lazy var headTabView : HeadMineView = {
        
        let head_v = HeadMineView.loadFromNib()
        head_v.frame = CGRect(x: 0, y: kNavigationBarH, width: kScreenW, height: headHeight)
//        head_v.delegate = self
        
        return head_v
    }()

    // table初始化
    private lazy var tableV : UITableView = {
        
        let table = UITableView.init(frame: CGRect(x: 0, y: kNavigationBarH , width: kScreenW, height: kScreenH - kNavigationBarH), style: .grouped)
        table.delegate = self
        table.dataSource = self
        table.contentInset = UIEdgeInsets(top: headHeight - 20 , left: 0, bottom: 20, right: 0)

        table.backgroundColor = UIColor.clear
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


extension PersonalInfoViewController : UITableViewDelegate,UITableViewDataSource{
    // 行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    // 分区头高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
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
        return (arrList[section] as! NSArray).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // cell
        var cell = tableView.dequeueReusableCell(withIdentifier: "seller")
        
        if cell == nil
        {
            cell = UITableViewCell.init(style: .value1, reuseIdentifier: "seller")
        }

        // 取消最后一行cell分割线
        cell!.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: kScreenW)
        
        //cell设置圆角
        for (curInt,_) in self.arrList.enumerated(){
            if indexPath.section == curInt {
                if indexPath.row == 0{
                    let myLayer = CAShapeLayer()
                    let path = UIBezierPath.init(roundedRect: CGRect(x: 0, y: 0, width: kScreenW, height: cellHeight), byRoundingCorners: UIRectCorner.init(arrayLiteral: .topLeft,.topRight), cornerRadii: CGSize(width: 20, height: 20))
                    myLayer.path = path.cgPath
                    cell!.layer.mask = myLayer
                }else if indexPath.row == (self.arrList[indexPath.section] as! NSArray).count - 1{
                    let myLayer = CAShapeLayer()
                    let path = UIBezierPath.init(roundedRect: CGRect(x: 0, y: 0, width: kScreenW, height: cellHeight), byRoundingCorners: UIRectCorner.init(arrayLiteral: .bottomLeft, .bottomRight), cornerRadii: CGSize(width: 20, height: 20))
                    myLayer.path = path.cgPath
                    cell!.layer.mask = myLayer
                    
                }
            }
        }
        
        // cell 属性（颜色、字体、大小）
        cell?.textLabel?.text = (arrList[indexPath.section] as! NSArray)[indexPath.row] as? String
        cell?.textLabel?.font = customFont(font: 16)
        cell?.textLabel?.textColor = RGBColor(r: 34, g: 34, b: 34)
        
        if indexPath.row == 0 {
            headImg = UIImageView.init(frame: CGRect(x: kScreenW - 76, y: 11, width: 38, height: 38))
            headImg?.layer.cornerRadius = 19
            headImg?.layer.masksToBounds = true
            let imgUrl = (detailArray[indexPath.section] as! NSArray)[0] as! String
            headImg?.kf.setImage(with: URL(string: imgUrl))
            headImg?.backgroundColor = UIColor.red
            cell?.contentView.addSubview(headImg!)
        }else{
            cell?.detailTextLabel?.text = ((detailArray[indexPath.section] as! NSArray)[indexPath.row] as! String)
            cell?.detailTextLabel?.font = customFont(font: 14)
            cell?.detailTextLabel?.textColor = RGBColor(r: 102, g: 102, b: 102)
        }
        
        // 箭头类型cell
        cell?.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        return cell!
    }
    
    // 点击cell时处理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //更换头像
        if indexPath.section == 0 && indexPath.row == 0 {
            showHeadImgSelect()
        }
        //更改昵称
        else if indexPath.section == 0 && indexPath.row == 1{
            toChangeTextPage(value: 1)
        }
        //更改公司名
        else if indexPath.section == 0 && indexPath.row == 2{
            toChangeTextPage(value: 2)
        }
        //跳转到更改地址
        else if indexPath.section == 0 && indexPath.row == 3{ self.navigationController?.pushViewController(ChangeAddressViewController(), animated: true)
        }
    }
    
    // 滑动时方法头部保持白色背景
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let point = scrollView.contentOffset

        var rect = headTabView.frame
        let pointY = point.y - 20
        if pointY < -headHeight
        {
            let y = abs(pointY)

            rect.size.height = y

            headTabView.frame = rect
        }
    }
}

//头像事件
extension PersonalInfoViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    //点击头像,显示选择按钮列表
    func showHeadImgSelect(){
        let actionList = ["拍照","从相册选择"]
        
        // 底部弹框
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        for alertString in actionList {
            let alertAct = UIAlertAction(title: alertString, style: .default) { (alert) in
                self.imgPhotoFrom(value: alertString)
            }
            alertController.addAction(alertAct)
        }
        let cancelAct = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(cancelAct)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // 选择头像 - 1.拍照 2.从相册选择
    private func imgPhotoFrom(value:String) {
        
        if value == "拍照"
        {
            print("拍照")
        }
        else
        {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            picker.sourceType = .photoLibrary
            
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    // 选择完图片调用这里
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // 拿到选择的图片
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        headImg?.image = image
        picker.dismiss(animated: true, completion: nil)
        
        let imageArr = NSMutableArray()
        imageArr.add(image)
        
        // 弱引用，防止循环引用
        weak var weakSelf = self
        
        print("选择好图片,准备进行接口传值")
        // 上传选中的图片获取路径
        HttpDatas.shareInstance.uploadDatas(.post, URLString: updataImgUrl, paramaters: imageArr as! [UIImage]) { (response) in
            print("后台传值成功")
            let jsonData = JSON(response)
            
            //print("jsonData = \(jsonData)")
            
            // 成功则恶调用修改接口
            if jsonData["code"].stringValue == "200"
            {
                weakSelf?.modiftDatas(value: jsonData["data"].stringValue, typeRow: "1")
            }
            
        }
        
    }
    
    // 取消选择图片
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("取消选择图片")
        self.dismiss(animated: true, completion: nil)
    }
    
    // 修改接口
    private func modiftDatas(value : String, typeRow : String) {
        
        let token = UserDefaults.standard.object(forKey: "token") as? String
        
        var dicList = [String : Any]()
        
        // typeRow == 1、头像 2、昵称 3、个人介绍 4、性别 5、生日 6、地区
        if typeRow == "1"
        {
            dicList = ["token":token ?? "",
                       "headImg":value
            ]
        }
        if typeRow == "2"
        {
            dicList = ["token":token ?? "",
                       "name":value
            ]
        }
        if typeRow == "3"
        {
            dicList = ["token":token ?? "",
                       "introduce":value
            ]
        }
        if typeRow == "4"
        {
            dicList = ["token":token ?? "",
                       "gender":value
            ]
        }
        if typeRow == "5"
        {
            dicList = ["token":token ?? "",
                       "birthday":value
            ]
        }
        if typeRow == "6"
        {
            dicList = ["token":token ?? "",
                       "area":value
            ]
        }
        
        
        // 修改接口
        HttpDatas.shareInstance.requestUserDatas(.post, URLString: todatAddres+"/user/news/mineModify", paramaters: dicList) { (response) in
            
            let jsonData = JSON(response)
            
            // 提示是否成功成功
            if jsonData["code"].stringValue == "100"
            {
                print("修改成功")
            }
            else
            {
                print("修改失败")
            }
            
        }
    }
}
//更改text事件 - 1.昵称 - 2.公司名
extension PersonalInfoViewController {
    private func toChangeTextPage(value: Int){
        let pageVC = ChangeTextViewController()
        if value == 1{
            pageVC.type = 1
        }else if value == 2 {
            pageVC.type = 2
        }
        self.navigationController?.pushViewController(pageVC, animated: true)
    }
}
