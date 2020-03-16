//
//  HttpDatas.swift
//  news2
//
//  Created by xushiqi on 2020/1/8.
//  Copyright © 2020 xushiqi. All rights reserved.
//

import UIKit

import Alamofire    //网络请求

//设置网络请求单例 - 只初始化一次
private let httpShareInstance = HttpDatas()

//数据请求方法
enum MethodType{
    case get
    case post
}

class HttpDatas: NSObject {
    //单例
    class var shareInstance:HttpDatas{
        return httpShareInstance
    }
}

//网络请求
//用block接受返回值(finishCallBack)
//block是封装了函数调用以及函数调用环境的OC对象
//就是带有自动变量（就是局部变量）值的匿名函数
//闭包只有在函数中做参数时才会区分逃逸闭包和非逃逸闭包
//非逃逸闭包在函数中调用闭包,然后退出函数
//逃逸闭包在退出函数后调用闭包

//alt + 田 + / 注释
extension HttpDatas{
    /// <#Description#>
    /// - Parameter type: <#type description#>
    /// - Parameter URLString: <#URLString description#>
    /// - Parameter parameters: <#parameters description#>
    /// - Parameter finishCallBack: 请求成功后通过这个block把数据回调
    func requestDatas(_ type: MethodType, URLString:String, parameters:[String:Any]?, finishCallBack: @escaping(_ response:Any) -> ()){
        
        //获取请求类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        //发送网络请求
        //转为json格式
        Alamofire.request(URLString, method: method, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON {
            (responseJson) in
                
            //判断是否请求成功
            guard responseJson.result.isSuccess else{
                print(responseJson.result.error!)
                return
            }
            
            //获取结果
            guard responseJson.result.value != nil else{
                return
            }
            
            //成功则把请求的数据回调过去
            if let value = responseJson.result.value {
                finishCallBack(value)
            }
        }
        
    }
    
    
    // 数据请求方法
    enum MothodType {
        case get
        case post
    }
    /// 参数加在header请求头中
    ///
    /// - Parameters:
    ///   - type: 数据请求方式 get/post
    ///   - URLString: 请求数据的路径
    ///   - paramaters: 请求数据需要的参数
    ///   - finishCallBack: 请求成功后通过这个block吧数据回调
    func requestUserDatas(_ type : MothodType, URLString : String, paramaters : [String : Any]?, finishCallBack : @escaping (_ response : Any) -> ()) {
        
        // 获取请求类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        let token = paramaters?["token"] as? String
        
        // 参数拼接到请求头中
        let headers = ["token":token]
        
        // 发送网络请求
        Alamofire.request(URLString, method: method, parameters: paramaters, encoding: URLEncoding.default, headers: headers as? HTTPHeaders).responseJSON { (responseJson) in
            
            // 判断是否请求成功
            guard responseJson.result.value != nil else {
                print(responseJson.result.error!)
                return
            }
            
            // 获取结果
            guard responseJson.result.isSuccess else {
                return
            }
            
            // 成功就把请求的数据回调过去
            if let value = responseJson.result.value {
                finishCallBack(value)
            }
        }
    }
    
    /// 上传图片获取图片路径
    ///
    /// - Parameters:
    ///   - type: 上传方式  get/post
    ///   - URLString: 服务器路径
    ///   - paramaters: 存放要上传的图片数组
    ///   - finishCallBack: 上传成功把返回的图片路径通过block传回去
    func uploadDatas(_ type : MothodType, URLString : String, paramaters : [UIImage], finishCallBack : @escaping (_ response : Any) -> ()) {
        
        // 获取请求类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        // 文件类型
        let headers = ["content-type":"multipart/form-data"]
        // 上传
        upload(multipartFormData: { (multipartFormData) in
            
            // 多张时遍历全部上传
            for index in 0..<paramaters.count
            {
                let imageData = paramaters[index].jpegData(compressionQuality: 0.3)
                multipartFormData.append(imageData!, withName: "file", fileName: "fileName_\(index)", mimeType: "image/jpeg")
            }
            
        }, usingThreshold: (10*1024), to: URLString, method: method, headers: headers) { (encodingResult) in
            
            // 获取上传结果
            switch encodingResult {
                
            // 上传成功拿到数据回调
            case .success(let request, _, _):
                request.responseJSON(completionHandler: { (respons) in

                    // 成功就把请求的数据回调过去
                    if let value = respons.result.value {
                        finishCallBack(value)
                    }

                })
            // 失败查看原因
            case .failure(let error):
                print("error = \(error)")
                
            // 这里意思是永不执行，一般不会执行这里
            @unknown default:
                print("未知")
            }

        }
        
    }
}
