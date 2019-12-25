//
//  CYFMHomeVipHeaderView.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/12/20.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

class CYFMHomeVipHeaderView: UITableViewHeaderFooterView {

    private var titleLab: UILabel = {
        let lab = UILabel()
        lab.text = "最热有声读物"
        lab.font = .systemFont(ofSize: 20)
        return lab
    }()
    
    private var moreBtn: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitle("更多 ⟩", for: .normal)
        btn.setTitleColor(UIColor.gray, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 15)
        return btn
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        tintColor = .red
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        addSubview(self.titleLab)
        self.titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(10)
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
        
        addSubview(self.moreBtn)
        self.moreBtn.snp.makeConstraints { (make) in
            make.right.equalTo(15)
            make.top.equalTo(10)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
    }
    
    var titleStr: String? {
        didSet {
            guard let str = titleStr else {
                return
            }
            self.titleLab.text = str
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
