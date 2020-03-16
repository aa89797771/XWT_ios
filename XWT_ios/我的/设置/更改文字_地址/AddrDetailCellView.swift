//
//  AddrDetailCellView.swift
//  todayNews
//
//  Created by xushiqi on 2020/3/13.
//  Copyright © 2020 xushiqi. All rights reserved.
//

import UIKit

class AddrDetailCellView: UIView {
    //左侧详细地址label说明
    @IBOutlet weak var labelLeft: UILabel!
    //地址详情label
    @IBOutlet weak var addrDetailLabel: UILabel!
    //地址详情输入框
    @IBOutlet weak var addrDetailText: UITextView!
    
    @IBAction func clickRegion(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.addrDetailText.alpha = 1
        }
        self.addrDetailText.becomeFirstResponder()
    }
    
    override func layoutSubviews() {
        addrDetailText.alpha = 0
        addrDetailText.delegate = self
    }
}
extension AddrDetailCellView{
    class func loadFromNib()->AddrDetailCellView{
        return Bundle.main.loadNibNamed("AddrDetailCellView", owner: nil, options: nil)?[0] as! AddrDetailCellView
    }
}
extension AddrDetailCellView:UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("focus")
        UIView.animate(withDuration: 0.3) {
            self.addrDetailText.alpha = 1
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("blur:\(textView.text)")
        self.addrDetailText.resignFirstResponder()
        
        
        let paraph = NSMutableParagraphStyle()
        paraph.alignment = .right
        //设置行间距
        paraph.lineSpacing = 6
        let attrString =  [NSAttributedString.Key.font: customFont(font: 13), NSAttributedString.Key.paragraphStyle: paraph] as [NSAttributedString.Key : Any]
        
//        addrDetailLabel.text = textView.text
        addrDetailLabel.attributedText = NSMutableAttributedString(string: textView.text!, attributes: attrString)
        
        UIView.animate(withDuration: 0.3) {
            self.addrDetailText.alpha = 0
        }
    }
}
