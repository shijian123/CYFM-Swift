//
//  CYFMRadioHeaderView.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/12/31.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

class CYFMRadioHeaderView: UICollectionReusableView {
    // 标题
    private var titleLab: UILabel = {
        let lab = UILabel()
        lab.text = "最热有声读物"
        lab.font = UIFont.systemFont(ofSize: 20)
        return lab
    }()
    
    private var moreBtn: UIButton = {
        let btn = UIButton.init(type: UIButton.ButtonType.custom)
        btn.setTitle("更多 >", for: UIControl.State.normal)
        btn.setTitleColor(UIColor.gray, for: UIControl.State.normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpLayout(){
        addSubview(self.titleLab)
        self.titleLab.snp.makeConstraints { (make) in
            make.left.top.equalTo(15)
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
        
        addSubview(self.moreBtn)
        self.moreBtn.snp.makeConstraints { (make) in
            make.right.equalTo(15)
            make.top.equalTo(15)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
    }
    
    var titStr: String? {
        didSet{
            guard let string = titStr else {return}
            self.titleLab.text = string
        }
    }
    
}
