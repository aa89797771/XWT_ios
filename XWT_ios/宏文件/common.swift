//
//  common.swift
//  News
//
//  Created by xushiqi on 2020/2/24.
//  Copyright © 2020 xushiqi. All rights reserved.
//

import UIKit

// 接口前缀地址
let todatAddres = "http://toutiao.apkbus.com/wp-json/custom/v1"
let updataImgUrl = "http://101.132.114.122:8099/upload"
//736/
// 5.5寸
//4.7
//屏幕宽高
let kScreenW = UIScreen.main.bounds.width
let kScreenH = UIScreen.main.bounds.height

//源窗口
let KeyWindow = UIApplication.shared.keyWindow

//是否是iphone
let kIsIphone = Bool(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone)

//判断是否是iphoneX
let kIsIphoneX = Bool(kScreenW>=375.0 && kScreenH>=812.0 && kIsIphone)

//导航条高度
let kNavigationBarH = CGFloat(kIsIphoneX ? 88 : 64)     //头部phoneX需要多24

//状态栏高度
let kStatusBarH = CGFloat(kIsIphoneX ? 44 : 20)

//tabbar高度
let kTabBarH = CGFloat(kIsIphoneX ? (49+34) : 49)       //底部phoneX需要多34

let bgGray = RGBColor(r: 245, g: 245, b: 245)

//自定义颜色
func RGBColor(r:CGFloat, g:CGFloat, b:CGFloat) -> UIColor{
    return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
}

//字号
func customFont(font:CGFloat) -> UIFont{
    //刘海屏
    guard kScreenH <= 736 else{
        return UIFont.systemFont(ofSize: font)
    }
    //5.5寸
    guard kScreenH == 736 else{
        return UIFont.systemFont(ofSize: font - 2)
    }
    //4.7寸
    guard kScreenH >= 736 else{
        return UIFont.systemFont(ofSize: font - 4)
    }
    return UIFont.systemFont(ofSize: font)
}


//圆角
func customLayer(num:CGFloat) -> CGFloat{
    //刘海屏
    guard kScreenH <= 736 else{
        return num * 1.3
    }
    //5.5寸
    guard kScreenH != 736 else{
        return num * 1.1
    }
    //4.7寸
    guard kScreenH >= 736 else{
        return num
    }
    return num * 1.2
}

//邮箱正则 [A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,4}
//用户姓名(20位的中文或英文) ^[a-zA-Z\u4E00-\u9FA5]{1,20}
func valudataEmail(email:String)->Bool{
    if email.count == 0{
        return false
    }
    let emailReg = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,4}"
    let emailText:NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailReg)
    return emailText.evaluate(with: email)
}

//渐变色
//参数为需要添加渐变色的btn,和对应的圆角大小
func gradientBtn(_ btn: UIButton,_ cornerRadius:CGFloat){
    // 按钮渐变色
    let gradient = CAGradientLayer()
    gradient.colors = [UIColor(red: 0.97, green: 0.33, blue: 0.37, alpha: 1).cgColor, UIColor(red: 0.95, green: 0.31, blue: 0.36, alpha: 1).cgColor, UIColor(red: 1, green: 0.66, blue: 0.11, alpha: 1).cgColor]
    gradient.locations = [0, 0.48, 1]
//        gradient.frame = loginBtn.bounds
    gradient.frame = CGRect(x: 0, y: 0, width: customLayer(num: btn.frame.size.width), height: customLayer(num: btn.frame.size.height))
    
    gradient.startPoint = CGPoint(x: 0, y: 0)
    gradient.endPoint = CGPoint(x: 1, y: 0)
    
    btn.layer.addSublayer(gradient)
    btn.layer.cornerRadius = cornerRadius
    btn.layer.masksToBounds = true
}

//显示、隐藏navbar、tabbar
func createHiddenNavTabBar(_ that: UIViewController, isShow:Bool){
    if !isShow {
//        that.navigationController?.setNavigationBarHidden(true, animated: true)
        that.tabBarController?.tabBar.isHidden = true
    }else{
//        that.navigationController?.setNavigationBarHidden(false, animated: true)
        //出现时需要动画,不然很突兀
        UIView.animate(withDuration: 0.5, animations: {
        }) { (_) in
            that.tabBarController?.tabBar.isHidden = false
        }
    }
}

//文字抖动
func shake(label:UILabel){
    //左右抖动函数
    let douDong = CAKeyframeAnimation()
    douDong.keyPath = "transform.translation.x"
    let s = 10
    //抖动位置(左右)
    douDong.values = [-s,0,s,0,-s,0,s,0]
    //抖动时间
    douDong.duration = 0.1
    //抖动次数
    douDong.repeatCount = 2
    //移除
    douDong.isRemovedOnCompletion = true
    label.layer.add(douDong, forKey: "shake")
}


//计算文本大小
func getAttributes(lineHeight: CGFloat, font:UIFont) -> [NSAttributedString.Key : Any]{
    //通过富文本来设置行间距
    let paraph = NSMutableParagraphStyle()
    //设置行间距
    paraph.lineSpacing = lineHeight
    
    return [NSAttributedString.Key.font: font, NSAttributedString.Key.paragraphStyle: paraph] as [NSAttributedString.Key : Any]
}
//计算文本大小
func culculateRect(titleText: String, maxWidth: CGFloat, attributes: [NSAttributedString.Key : Any]) -> CGRect{
        //外面view的最大宽度
        let maxW = maxWidth  //kScreenW *  3/4
        //外面view 与 内部label的垂直内边距padding
        let paddingV:CGFloat = 10
        //外面view 与 内部label的水平内边距padding
        let paddingH:CGFloat = 10
        //实际展示的label宽度
        var showW:CGFloat = 0
        //实际展示的label高度
        var showH:CGFloat = 0
        //内部label的行高(上下padding此时都为0)
//        let lineH:CGFloat = lineHeight
        //自定义字体大小
//        let fontCustom = font //customFont(font: 24)
        
        var title = "测试 测试 测试 测试 测试 测试测试 测试 测试 测试 测试 测试测试 测试 测试 测试 测试 测试测试 测试 测试 测试测试 测试 测试 测试 测试 测试测试 测试 测试 测试 测试 测试"
        title = titleText
        
        //通过富文本来设置行间距
        let paraph = NSMutableParagraphStyle()
        //设置行间距
//        paraph.lineSpacing = lineH
//    let attributes = [NSAttributedString.Key.font: fontCustom, NSAttributedString.Key.paragraphStyle: paraph] as [NSAttributedString.Key : Any]
        
        // 当前文字宽高 NSStringDrawingOptions.init(arrayLiteral: [.usesFontLeading,.usesLineFragmentOrigin])
        let rect = title.boundingRect(with: CGSize(width: maxW, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: attributes, context: .none)
        
        print("计算出来的:\(rect)")
//        showH = rect.size.height
//        //文字超出 换行
//        if maxW < rect.size.width{
////            h = Calculate.textHeight(text: title, fontSize: fontSize, width: maxW)
//            showW = maxW
//        }else{
//            showW = rect.size.width
//        }
//
//        let showLogBtn:UILabel = UILabel.init(frame: CGRect(x: paddingV, y: paddingH, width: showW - paddingV*2, height: showH))
//
//        showLogBtn.text = title
//        showLogBtn.font = fontCustom
//        showLogBtn.numberOfLines = 0
//        showLogBtn.attributedText = NSAttributedString(string: title, attributes: attributes)
//        showLogBtn.backgroundColor = UIColor.red
//
//        let viewWrap:UIView = UILabel.init(frame: CGRect(x: (kScreenW - showW) / 2, y: 250, width: showW, height: showH + paddingH*2))
//        viewWrap.backgroundColor = UIColor.blue
//        viewWrap.addSubview(showLogBtn)
//        self.view.addSubview(viewWrap)
        return rect
    }
