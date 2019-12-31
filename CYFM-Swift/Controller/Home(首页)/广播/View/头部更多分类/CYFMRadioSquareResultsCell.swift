//
//  CYFMRadioSquareResultsCell.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/12/31.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

protocol CYFMRadioSquareResultsCellDelegate: NSObjectProtocol {
    func radioSquareResultsCellItemClick(url: String, title: String)
}

class CYFMRadioSquareResultsCell: UICollectionViewCell {

    weak var delegate: CYFMRadioSquareResultsCellDelegate?
    
    private var radioSquareResults: [CYFMRadioSquareResultsModel]?

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: CYFMScreenWidth/5, height: self.frame.size.height)
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.backgroundColor = .white
        collectionV.register(CYFMRadioSquareCell.self, forCellWithReuseIdentifier: "CYFMRadioSquareCell")
        return collectionV
    }()
    
    var radioSquareResultsModel: [CYFMRadioSquareResultsModel]? {
        didSet {
            guard let model = radioSquareResultsModel else {
                return
            }
            self.radioSquareResults = model
            self.collectionView.reloadData()
        }
    }
    
}

extension CYFMRadioSquareResultsCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.radioSquareResults?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CYFMRadioSquareCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CYFMRadioSquareCell", for: indexPath) as! CYFMRadioSquareCell
        cell.radioSquareModel = self.radioSquareResults?[indexPath.row]
        cell.backgroundColor = .white
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = self.radioSquareResults?[indexPath.row]
        let title = model?.title
        let url = getUrlAPI(url: model?.uri ?? "")
        delegate?.radioSquareResultsCellItemClick(url: url, title: title ?? "")
    }
    
    
    func getUrlAPI(url:String) -> String {
        // 判断是否有参数
        if !url.contains("?") {
            return ""
        }
        var params = [String: Any]()
        // 截取参数
        let split = url.split(separator: "?")
        let string = split[1]
        // 判断参数是单个参数还是多个参数
        if string.contains("&") {
            // 多个参数，分割参数
            let urlComponents = string.split(separator: "&")
            // 遍历参数
            for keyValuePair in urlComponents {
                // 生成Key/Value
                let pairComponents = keyValuePair.split(separator: "=")
                let key:String = String(pairComponents[0])
                let value:String = String(pairComponents[1])
                
                params[key] = value
            }
        } else {
            // 单个参数
            let pairComponents = string.split(separator: "=")
            // 判断是否有值
            if pairComponents.count == 1 {
                return "nil"
            }
            
            let key:String = String(pairComponents[0])
            let value:String = String(pairComponents[1])
            params[key] = value as AnyObject
        }
        guard let api = params["api"] else{return ""}
        return api as! String
    }
    
}
