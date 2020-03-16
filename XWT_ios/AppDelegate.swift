//
//  AppDelegate.swift
//  todayNews
//
//  Created by xushiqi on 2020/1/7.
//  Copyright © 2020 xushiqi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //        设置根视图
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = TabBarViewController()
        window?.makeKeyAndVisible() //设置至顶层
        return true
    }


}

