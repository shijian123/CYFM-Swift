//
//  CYFMHomeLiveHeaderView.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/12/20.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

protocol CYFMHomeLiveHeaderViewDelegate: NSObjectProtocol {
    func homeLiveHeaderViewCategoryBtnClick(button: UIButton)
}

class CYFMHomeLiveHeaderView: UICollectionReusableView {
    weak var delegate : CYFMHomeLiveHeaderViewDelegate?
    private var btnArr:[UIButton] = []
    private var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = CYFMButtonColor
        return view
    }()

    private var moreBtn: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitle("更多 ⟩", for: .normal)
        btn.setTitleColor(UIColor.gray, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 15)
        btn.addTarget(self, action: #selector(moreBtnClick), for: .touchUpInside)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    func setupLayout() {
        let num = ["热门","情感","有声","新秀","二次元"]
        let margin: CGFloat = 50.0
        for index in 0..<num.count {
            let btn = UIButton(type: .custom)
            btn.frame = CGRect(x: margin*CGFloat(index), y: 2.5, width: margin, height: 25)
            btn.setTitle(num[index], for: .normal)
            btn.titleLabel?.font = .systemFont(ofSize: 15)
            btn.tag = 1000 + index
            if btn.tag == 1000 {
                btn.setTitleColor(CYFMButtonColor, for: .normal)
                self.lineView.frame = CGRect(x: margin*CGFloat(btn.tag-1000)+12.5, y: 30, width: margin/2.0, height: 2)
            }else {
                btn.setTitleColor(UIColor.lightGray, for: .normal)
            }
            self.btnArr.append(btn)
            btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
            addSubview(btn)
        }
        
        addSubview(self.lineView)
        addSubview(self.moreBtn)
        self.moreBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5)
            make.height.equalTo(25)
            make.width.equalTo(50)
            make.top.equalTo(2.5)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func moreBtnClick() {
        CYFMHelperTool.showNoFunctionWarning()
    }
    
    @objc func btnClick(sender: UIButton) {
        let margin: CGFloat = 50.0
        self.lineView.frame = CGRect(x: margin*CGFloat(sender.tag-1000)+12.5, y: 30, width: margin/2.0, height: 2)
        for btn in self.btnArr {
            if btn.tag == sender.tag {
                btn.setTitleColor(CYFMButtonColor, for: .normal)
            }else {
                btn.setTitleColor(.lightGray, for: .normal)
            }
        }
        delegate?.homeLiveHeaderViewCategoryBtnClick(button: sender)
    }
    
}
