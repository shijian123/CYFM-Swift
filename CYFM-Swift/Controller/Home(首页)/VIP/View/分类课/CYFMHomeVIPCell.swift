//
//  CYFMHomeVIPCell.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/12/20.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

class CYFMHomeVIPCell: UITableViewCell {

    private lazy var picView: UIImageView = {
        let imgV = UIImageView()
        imgV.image = UIImage(named: "pic1.jpeg")
        return imgV
    }()
    
    private lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.text = "明朝那些事儿"
        lab.font = UIFont.systemFont(ofSize: 17)
        return lab
    }()
    
    private lazy var subLab: UILabel = {
        let lab = UILabel()
        lab.text = "刷卡机打发地方"
        lab.textColor = .gray
        lab.font = .systemFont(ofSize: 15)
        return lab
    }()
    
    private lazy var numLab: UILabel = {
        let lab = UILabel()
        lab.text = "> 2.5亿 1284集"
        lab.textColor = .gray
        lab.font = .systemFont(ofSize: 14)
        return lab
    }()
    
    private lazy var tracksLab: UILabel = {
        let lab = UILabel()
        lab.textColor = .gray
        lab.font = .systemFont(ofSize: 14)
        return lab
    }()
    
    private lazy var numImgV: UIImageView = {
        let imgV = UIImageView()
        imgV.image = UIImage(named: "playcount.png")
        return imgV
    }()
    
    private lazy var tracksImgV: UIImageView = {
        let imgV = UIImageView()
        imgV.image = UIImage(named: "track.png")
        return imgV
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(){
        addSubview(self.picView)
        self.picView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(80)
        }
        
        addSubview(self.titleLab)
        self.titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(self.picView.snp.right).offset(10)
            make.right.equalToSuperview()
            make.height.equalTo(20)
        }
        
        addSubview(self.subLab)
        self.subLab.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(self.titleLab)
            make.top.equalTo(self.titleLab.snp.bottom).offset(10)
        }
        
        addSubview(self.numImgV)
        self.numImgV.snp.makeConstraints { (make) in
            make.left.equalTo(self.subLab)
            make.bottom.equalToSuperview().offset(-25)
            make.width.height.equalTo(17)
        }
        
        addSubview(self.numLab)
        self.numLab.snp.makeConstraints { (make) in
            make.left.equalTo(self.numImgV.snp.right).offset(5)
            make.bottom.equalTo(60)
        }
        
        addSubview(self.tracksLab)
        self.tracksLab.snp.makeConstraints { (make) in
            make.left.equalTo(self.tracksImgV.snp.right).offset(5)
            make.bottom.equalTo(self.tracksImgV)
            make.width.equalTo(80)
        }
    }
    
    var categoryContentsModel: CYFMCategoryContents? {
        didSet {
            guard let model = categoryContentsModel else {
                return
            }
            self.picView.kf.setImage(with: URL(string: model.coverLarge!))
            self.titleLab.text = model.title
            self.subLab.text = model.intro
            self.tracksLab.text = "\(model.tracks)集"
            
            var tagString: String?
            if model.playsCounts > 100000000 {
                tagString = String(format: "%.1f亿", Double(model.playsCounts) / 100000000)
            }else if model.playsCounts > 10000 {
                tagString = String(format: "%.1f万", Double(model.playsCounts) / 10000)
            }else {
                tagString = "\(model.playsCounts)"
            }
            self.numLab.text = tagString
        }
    }
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
