//
//  HomeCell.swift
//  BaseSwift
//
//  Created by ghwang on 2018/9/28.
//  Copyright © 2018年 ghwang. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    var nameLab: UILabel?
    var containerView: UIView?
    var btn: UIButton?
    var callBack:((String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.backgroundColor = UIColor.colorWithHex(hexColor: 0xe8e8e8)
        containerView = UIView()
        containerView?.backgroundColor = UIColor.white
        addSubview(containerView!)
        containerView?.sd_layout()?.spaceToSuperView(UIEdgeInsets.init(top: 0, left: 0, bottom: 10, right: 0))
        
        nameLab = UILabel()
        nameLab?.textColor = UIColor.textTitleColor
        nameLab?.font = UIFont.commonFont
        containerView?.addSubview(nameLab!)
        _ = nameLab?
            .sd_layout()?
            .heightIs(20)?
            .leftSpaceToView(containerView,10)?
            .rightSpaceToView(containerView,10)?
            .centerYEqualToView(containerView!)
        
        btn = UIButton()
        btn?.addTarget(self, action:#selector(btnClick(_:)), for:.touchUpInside)
        btn?.setTitle("push", for: .normal)
        btn?.titleLabel?.font = UIFont.commonFont
        btn?.setTitleColor(UIColor.btnMainColor, for:.normal)
        containerView?.addSubview(btn!)
        
        _ = btn?.sd_layout()?
        .rightSpaceToView(containerView,10)?
        .heightIs(35)?
        .widthIs(65)?
        .centerYEqualToView(containerView)
    
    
        
    }

    
    func setModel(mod:UnitVo) -> Void {
        
        nameLab?.text = mod.name
    }
    
    @objc func btnClick(_ btn:UIButton){
        
        callBack!("from cell")
    }
}

