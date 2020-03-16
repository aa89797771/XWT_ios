//
//  UI_Extension.swift
//  todayNews
//
//  Created by xushiqi on 2020/3/3.
//  Copyright © 2020 xushiqi. All rights reserved.
//

import UIKit

protocol RegisterCellFromNib {}

extension RegisterCellFromNib {
    
    static var identifier: String { return "\(self)" }
    
    static var nib: UINib? { return UINib(nibName: "\(self)", bundle: nil) }
}
extension UITableView {
    /// 注册 cell 的方法
    func ym_registerCell<T: UITableViewCell>(cell: T.Type) where T: RegisterCellFromNib {
        if let nib = T.nib { register(nib, forCellReuseIdentifier: T.identifier) }
        else { register(cell, forCellReuseIdentifier: T.identifier) }
    }
    
    /// 从缓存池池出队已经存在的 cell
    func ym_dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T where T: RegisterCellFromNib {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }
}
