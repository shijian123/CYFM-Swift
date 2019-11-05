//
//  CYFMRecommendHeaderView.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/17.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

// - typealias 闭包名称 = (参数名称: 参数类型) -> 返回值类型
typealias CYFMHeaderMoreBtnClickBlock = (_ sender: UIButton) ->Void
//typealias CYFMHeaderMoreBtnClickBlock = () ->Void

class CYFMRecommendHeaderView: UICollectionReusableView {
 
    var headerMoreBtnClickBlock: CYFMHeaderMoreBtnClickBlock?
    
    private var titleLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 20)
        return lab
    }()
    
    private var subLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 15)
        lab.textColor = .lightGray
        lab.textAlignment = .right
        return lab
    }()
    
    private var moreBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("更多 >", for: .normal)
        btn.setTitleColor(.gray, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.addTarget(self, action: #selector(moreButtonClickMethod(sender:)), for: .touchUpInside)
        return btn
    }()
    
    @objc func moreButtonClickMethod(sender: UIButton) {
        guard let headerMoreBtnClick = headerMoreBtnClickBlock else {
            return
        }
        headerMoreBtnClick(sender)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpLayout() {
        addSubview(self.titleLab)
        self.titleLab.snp.makeConstraints { (make) in
            make.left.top.equalTo(15)
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
        
        addSubview(self.subLab)
        self.subLab.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLab.snp.right)
            make.height.top.equalTo(self.titleLab)
            make.right.equalToSuperview().offset(-100)
        }
        
        addSubview(self.moreBtn)
        self.moreBtn.snp.makeConstraints { (make) in
            make.right.equalTo(15)
            make.top.equalTo(15)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
    }
    
    var homeRecommendListModel: CYFMRecommendModel? {
        didSet {
            guard let model = homeRecommendListModel else { return }
            if model.title != nil {
                self.titleLab.text = model.title
            }else {
                self.titleLab.text = "猜你喜欢"
            }
        }
    }
    
}
