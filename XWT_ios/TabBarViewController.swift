//
//  TabBarViewController.swift
//  News
//
//  Created by xushiqi on 2020/2/24.
//  Copyright © 2020 xushiqi. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    //默认显示首页
    var indexFlag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addControllers()
    }
    
    
    private func addControllers(){
        //选中文字颜色
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : RGBColor(r: 245, g: 90, b: 93)], for: .selected)
        
        addChildControllers(ViewController(), title: "首页", image: "首页2", selectImg: "首页1")
        addChildControllers(ViewController2(), title: "西瓜视频", image: "订货会2", selectImg: "订货会1")
        addChildControllers(ViewController3(), title: "小视频", image: "集市2", selectImg: "集市1")
        addChildControllers(ViewController4(), title: "我的", image: "我的2", selectImg: "我的1")
    }
    
    //私人方法 - 本类里面调用
    private func addChildControllers(_ childVC: UIViewController, title: String, image: String, selectImg: String){
        childVC.tabBarItem.title = title
        //传什么显示什么,不显示蓝色n背景
        childVC.tabBarItem.image = UIImage(named: image)?.withRenderingMode(.alwaysOriginal)
        childVC.tabBarItem.selectedImage = UIImage(named: selectImg)?.withRenderingMode(.alwaysOriginal)
        
        //头部导航
        let nav = UINavigationController()
        nav.addChild(childVC)
        
        addChild(nav)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    //点击items方法
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let index = tabBar.items?.firstIndex(of: item){
            if indexFlag != index{
                animationWithIndex(index: index)
            }
        }
    }
    //放大缩小动画
    private func animationWithIndex(index: Int){
        var arrViews = [UIView]()
        
        for tabbarButton in tabBar.subviews {
            //判断是否是tabbar的子类 - 获取tabbar上可点击的按钮
            if tabbarButton .isKind(of: NSClassFromString("UITabBarButton")!){
                arrViews.append(tabbarButton)
            }
        }
        
        //设置动画
        let pulse = CABasicAnimation(keyPath: "transform.scale")
        pulse.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        pulse.duration = 0.1
        pulse.repeatCount = 1
        //执行完复位
        pulse.autoreverses = true
        pulse.fromValue = 0.7
        pulse.toValue = 1.1
        
        //将动画添加至layer
        arrViews[index].layer.add(pulse, forKey: nil)
        
        indexFlag = index
    }

}
