//
//  CYFMClassifySubModuleType19Cell.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/31.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

class CYFMClassifySubModuleType19Cell: UICollectionViewCell {
    private var classifyModuleType19List: [CYFMClassifyModuleType19List]?
    
    private var linView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1)
        return view
    }()
    
    private lazy var moreBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("查看全部 >", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.textAlignment = .center
        return btn
    }()
    
    private lazy var myTableView: UITableView = {
        let tableV = UITableView()
        tableV.delegate = self
        tableV.dataSource = self
        tableV.register(UITableViewCell.self, forCellReuseIdentifier: "CELLID")
        tableV.separatorStyle = .none
        tableV.rowHeight = 30
        return tableV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        backgroundColor = .white
        addSubview(self.myTableView)
        self.myTableView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(150)
        }
        
        addSubview(self.linView)
        self.linView.snp.makeConstraints { (make) in
            make.left.width.right.equalToSuperview()
            make.height.equalTo(0.5)
            make.bottom.equalToSuperview().offset(-40)
        }
        
        addSubview(self.moreBtn)
        self.moreBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.linView.snp.bottom).offset(5)
            make.width.equalTo(150)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
    }
    
    var classifyVerticalModel: CYFMClassifyVerticalModel? {
        didSet {
            guard let model = classifyVerticalModel else {
                return
            }
            
            self.classifyModuleType19List = model.list
            self.myTableView.reloadData()
        }
    }
    
}


extension CYFMClassifySubModuleType19Cell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELLID", for: indexPath)
        cell.imageView?.image = UIImage(named: "play")
        cell.textLabel?.text = self.classifyModuleType19List?[indexPath.row].title
        return cell
    }
    
    
}
