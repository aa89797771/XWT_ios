//
//  ViewController.swift
//  todayNews
//
//  Created by xushiqi on 2020/1/7.
//  Copyright © 2020 xushiqi. All rights reserved.
//

import UIKit

class ViewController: CustomAlertViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(111233344)
        
        self.view.addSubview(testLabel)
        self.view.addSubview(showLoginBtn)
        self.view.addSubview(showSetsBtn)
        self.view.addSubview(showAlertBtn)
        self.view.addSubview(showPromptBtn)
        self.view.addSubview(toPersonalPageBtn)
        self.view.addSubview(toSystomMsgBtn)
        self.view.addSubview(toContactPageBtn)
        self.view.addSubview(toDialogPageBtn)
        self.view.addSubview(toTestPageBtn)
        createHiddenNavTabBar(self, isShow: false)
        
        self.view.addSubview(grayView)
        grayView.isUserInteractionEnabled = false
//        culculateTest()
    }
    private lazy var grayView:UIView = {
        let grayView = UIView.init(frame: self.view.frame)
                grayView.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0)
        //        grayView
                let tapp = UITapGestureRecognizer.init(target: self, action: #selector(grayClick))
                grayView.addGestureRecognizer(tapp)
        return grayView
    }()

    @objc func grayClick(){
        print("grayClick")
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
    
    //model层
//    private lazy var grayView:UIView = {
//        let gray = UIView(frame: self.view.bounds)
//        gray.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.5)
//        gray.alpha = 0
//
//        return gray
//    }()
    
    //label test
     private lazy var testLabel:UILabel = {
        let showLogBtn = UILabel.init(frame: CGRect(x: 100, y: 10, width: 175, height: 100))
        showLogBtn.numberOfLines = 2
//        showLogBtn.snp_makeConstraints{ (make) in
//            make.height.equalTo(50)
//        }
        showLogBtn.text = "去设置 testasdf asd sdf 去设置 testasdf asd sdf 去设置 testasdf asd sdf 去设置 testasdf asd sdf 去设置 testasdf asd sdf "
        showLogBtn.backgroundColor = UIColor.red
        return showLogBtn
    }()
    
    private lazy var showLoginBtn:UIButton = {
        let showLogBtn:UIButton = UIButton.init(frame: CGRect(x: 10, y: 200, width: 175, height: 40))
        showLogBtn.setTitle("显示登录弹窗", for: .normal)
        showLogBtn.backgroundColor = UIColor.red
        showLogBtn.addTarget(self, action: #selector(showLogin(btn:)), for: .touchUpInside)
        
        
        let myLayer = CAShapeLayer()
        var path = UIBezierPath.init(roundedRect: showLogBtn.bounds, byRoundingCorners: [.topLeft,.topRight,.bottomLeft], cornerRadii: CGSize(width: 10, height: 10))
        myLayer.path = path.cgPath
        showLogBtn.layer.mask = myLayer
        
        
        
//        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        
//        shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 100, 100) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(6, 6)].CGPath;
//
//        btn.layer.mask = shapeLayer;
        
        
        return showLogBtn
    }()
    
    //显示登录窗口
    @objc private func showLogin(btn:UIButton){
        let LoginVC = LoginViewController()
        self.navigationController?.pushViewController(LoginVC, animated: true)
    }
    
    //去设置页面
    private lazy var showSetsBtn:UIButton = {
       let showLogBtn:UIButton = UIButton.init(frame: CGRect(x: 10, y: 300, width: 175, height: 40))
       showLogBtn.setTitle("去设置", for: .normal)
       showLogBtn.backgroundColor = UIColor.red
       showLogBtn.addTarget(self, action: #selector(showSets(btn:)), for: .touchUpInside)
       return showLogBtn
   }()
   
   //去设置页面
   @objc private func showSets(btn:UIButton){
       let LoginVC = SetsViewController()
       self.navigationController?.pushViewController(LoginVC, animated: true)
   }
    
    //显示alert弹窗
    private lazy var showAlertBtn:UIButton = {
        let showLogBtn:UIButton = UIButton.init(frame: CGRect(x: 10, y: 400, width: 175, height: 40))
        showLogBtn.setTitle("显示alert弹窗", for: .normal)
        showLogBtn.backgroundColor = UIColor.red
        showLogBtn.addTarget(self, action: #selector(showAlert(btn:)), for: .touchUpInside)
        return showLogBtn
    }()
    
    @objc private func showAlert(btn:UIButton){
        showCustomAlertView1(title:"确认要清除缓存吗 - home？") { (str) in
            print("这里是回调函数")
        }
    }
    
    //显示alert弹窗
    private lazy var showPromptBtn:UIButton = {
        let showLogBtn:UIButton = UIButton.init(frame: CGRect(x: 10, y: 500, width: 175, height: 40))
        showLogBtn.setTitle("显示alert弹窗", for: .normal)
        showLogBtn.backgroundColor = UIColor.red
        showLogBtn.addTarget(self, action: #selector(showPrompt(btn:)), for: .touchUpInside)
        return showLogBtn
    }()
    
    @objc private func showPrompt(btn:UIButton){
        showCustomPromptBox1(title: "修改邮箱前需要验证您的密码") { (str) in
            print("弹窗2的回调函数")
            print(str)
        }
    }
    
    //去个人信息页
    private lazy var toPersonalPageBtn:UIButton = {
        let showLogBtn:UIButton = UIButton.init(frame: CGRect(x: 10, y: 600, width: 175, height: 40))
        showLogBtn.setTitle("去个人信息页", for: .normal)
        showLogBtn.backgroundColor = UIColor.red
        showLogBtn.addTarget(self, action: #selector(toPersonalPage(btn:)), for: .touchUpInside)
        return showLogBtn
    }()
    
    @objc private func toPersonalPage(btn:UIButton){
        let LoginVC = PersonalInfoViewController()
        self.navigationController?.pushViewController(LoginVC, animated: true)
    }
    
    //去test页
    private lazy var toSystomMsgBtn:UIButton = {
        let showLogBtn:UIButton = UIButton.init(frame: CGRect(x: 10, y: 700, width: 175, height: 40))
        showLogBtn.setTitle("去系统消息页", for: .normal)
        showLogBtn.backgroundColor = UIColor.red
        showLogBtn.addTarget(self, action: #selector(toSystomMsgPage(btn:)), for: .touchUpInside)
        return showLogBtn
    }()

    @objc private func toSystomMsgPage(btn:UIButton){
        let LoginVC = SystomMsgViewController3()
        self.navigationController?.pushViewController(LoginVC, animated: true)
    }
    
    //去test页
    private lazy var toContactPageBtn:UIButton = {
        let showLogBtn:UIButton = UIButton.init(frame: CGRect(x: 10, y: 800, width: 175, height: 40))
        showLogBtn.setTitle("去联系人列表页", for: .normal)
        showLogBtn.backgroundColor = UIColor.red
        showLogBtn.addTarget(self, action: #selector(toContactPage(btn:)), for: .touchUpInside)
        return showLogBtn
    }()

    @objc private func toContactPage(btn:UIButton){
        let LoginVC = ContactListViewController()
        self.navigationController?.pushViewController(LoginVC, animated: true)
    }
    //去聊天页
    private lazy var toDialogPageBtn:UIButton = {
        let showLogBtn:UIButton = UIButton.init(frame: CGRect(x: 200, y: 200, width: 175, height: 40))
        showLogBtn.setTitle("去聊天页", for: .normal)
        showLogBtn.backgroundColor = UIColor.red
        showLogBtn.addTarget(self, action: #selector(toDialogPage(btn:)), for: .touchUpInside)
        return showLogBtn
    }()

    @objc private func toDialogPage(btn:UIButton){
//        let LoginVC = MyMsgViewController()
        let LoginVC = MyMsgViewController()
        self.navigationController?.pushViewController(LoginVC, animated: true)
    }
    
    //去test页
    private lazy var toTestPageBtn:UIButton = {
        let showLogBtn:UIButton = UIButton.init(frame: CGRect(x: 200, y: 800, width: 175, height: 40))
        showLogBtn.setTitle("去test页", for: .normal)
        showLogBtn.backgroundColor = UIColor.red
        showLogBtn.addTarget(self, action: #selector(toTestPage(btn:)), for: .touchUpInside)
        return showLogBtn
    }()

    @objc private func toTestPage(btn:UIButton){
//        let LoginVC = MyMsgViewController()
        let ChangePsdVC = ChangeTextViewController()
        self.navigationController?.pushViewController(ChangePsdVC, animated: true)
    }
}
