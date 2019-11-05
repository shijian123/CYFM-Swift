//
//  CYFMHomeClassifyHeaderView.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/28.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

class CYFMHomeClassifyHeaderView: UICollectionReusableView {
    lazy var view: UIView = {
        let view = UIView()
        view.backgroundColor = CYFMButtonColor
        return view
    }()
    
    lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = .gray
        return lab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpLayout() {
        backgroundColor = CYFMDownColor
        addSubview(self.view)
        self.view.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(6)
            make.bottom.equalTo(-6)
            make.width.equalTo(4)
        }
        
        addSubview(self.titleLab)
        self.titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.right).offset(10)
            make.right.equalTo(-10)
            make.top.bottom.equalToSuperview()
        }
    }
    
    var titleStr: String? {
        didSet {
            guard let str = titleStr else { return }
            self.titleLab.text = str
        }
    }
    
}
