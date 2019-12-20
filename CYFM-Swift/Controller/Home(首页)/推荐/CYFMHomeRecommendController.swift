//
//  CYFMHomeRecommendController.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/16.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON
import SwiftMessages

class CYFMHomeRecommendController: CYBaseController {
    
    // 穿插的广告数据
    private var recommnedAdvertList: [CYFMRecommnedAdvertModel]?
    
    // 组件头、尾 注册
    private let CYFMRecommendHeaderViewID       = "CYFMRecommendHeaderView"
    private let CYFMRecommendFooterViewID       = "CYFMRecommendFooterView"
    
    // 注册不同的cell
    private let CYFMRecommendHeaderCellID       = "CYFMRecommendHeaderCell"
    // 猜你喜欢
    private let CYFMRecommendGuessLikeCellID    = "CYFMRecommendGuessLikeCell"
    // 热门有声书
    private let CYFMHotAudiobookCellID          = "CYFMHotAudiobookCell"
    // 广告
    private let CYFMAdvertCellID                = "CYFMAdvertCell"
    // 懒人电台
    private let CYFMOneKeyListenCellID          = "CYFMOneKeyListenCell"
    // 为你推荐
    private let CYFMRecommendForYouCellID       = "CYFMRecommendForYouCell"
    // 推荐直播
    private let CYFMHomeRecommendLiveCellID     = "CYFMHomeRecommendLiveCell"
    
    
    lazy var myCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .white
        
        // 注册头视图和尾视图
        collection.register(CYFMRecommendHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CYFMRecommendHeaderViewID)
        collection.register(CYFMRecommendFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CYFMRecommendFooterViewID)
        
        // 注册不同分区cell
        // 默认cell
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CELLID")
        collection.register(CYFMRecommendHeaderCell.self, forCellWithReuseIdentifier: CYFMRecommendHeaderCellID)
        // 猜你喜欢
        collection.register(CYFMRecommendGuessLikeCell.self, forCellWithReuseIdentifier: CYFMRecommendGuessLikeCellID)
        // 热门有声书
        collection.register(CYFMHotAudiobookCell.self, forCellWithReuseIdentifier: CYFMHotAudiobookCellID)
        // 广告
        collection.register(CYFMAdvertCell.self, forCellWithReuseIdentifier: CYFMAdvertCellID)
        // 懒人电台
        collection.register(CYFMOneKeyListenCell.self, forCellWithReuseIdentifier: CYFMOneKeyListenCellID)
        // 为你推荐
        collection.register(CYFMRecommendForYouCell.self, forCellWithReuseIdentifier: CYFMRecommendForYouCellID)
        // 推荐直播
        collection.register(CYFMHomeRecommendLiveCell.self, forCellWithReuseIdentifier: CYFMHomeRecommendLiveCellID)
        
        collection.cyHead = CYRefreshHeader{ [weak self] in self?.setupLoadData() }
        return collection
    }()
    
    lazy var viewModel: CYFMRecommendViewModel = {
       return CYFMRecommendViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(myCollectionView)
        myCollectionView.snp.makeConstraints { (make) in
            make.width.height.equalToSuperview()
            make.center.equalToSuperview()
        }
        myCollectionView.cyHead.beginRefreshing()
        setupLoadData()
        setupLoadRecommendADData()
    }
    
    func setupLoadData() {
        // unowned 无主引用,需要同时销毁的
        viewModel.updateDataBlock = { [unowned self] in
            self.myCollectionView.cyHead.endRefreshing()
            // 更新数据
            self.myCollectionView.reloadData()
        }
        viewModel.refreshDataSource()
    }
    
    func setupLoadRecommendADData() {
        
        CYFMRecommendProvider.request(.recommendAdList) { (result) in
            
            if case let .success(response) = result {
                let request = response.request
                print("网络请求：", request?.url as Any)
                
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let advertList = JSONDeserializer<CYFMRecommnedAdvertModel>.deserializeModelArrayFrom(json: json["data"].description) {// 从字符串转换为对象实例
                    self.recommnedAdvertList = advertList as? [CYFMRecommnedAdvertModel]
                    self.myCollectionView.reloadData()
                }
            }
        }
    }
}


extension CYFMHomeRecommendController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections(collectionView: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsIn(section: section)
    }
    
    // 每个分组的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return viewModel.insetForSectionAt(section: section)
    }
    // 最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumLineSpacingForSectionAt(section: section)
    }
    // 最小item间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumInteritemSpacingForSectionAt(section: section)
    }
    // item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.sizeForItemAt(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return viewModel.referenceSizeForHeaderInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return viewModel.referenceSizeForFooterInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let moduleType = viewModel.homeRecommendList?[indexPath.section].moduleType
        
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView: CYFMRecommendHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CYFMRecommendHeaderViewID, for: indexPath) as! CYFMRecommendHeaderView
            headerView.homeRecommendListModel = viewModel.homeRecommendList?[indexPath.section]
            
            // 更多按钮点击跳转
            headerView.headerMoreBtnClickBlock = { [weak self](sender: UIButton) in
                
                if moduleType == "guessYouLike" {
                    let vc = CYFMHomeGuessYouLikeMoreController()
                    self?.navigationController?.pushViewController(vc, animated: true)
                }else if moduleType == "paidCategory" {
                    let vc = CYFMHomeVIPController(isRecommendPush: true)
                    vc.title = "精品"
                    self?.navigationController?.pushViewController(vc, animated: true)
                }else if moduleType == "live" {
                    let vc = CYFMHomeLiveController()
                    vc.title = "直播"
                    self?.navigationController?.pushViewController(vc, animated: true)
                }else {
                    guard let categoryId = self?.viewModel.homeRecommendList?[indexPath.section].target?.categoryId else { return }
                    
                    if categoryId != 0 {
//                        let vc = LBFMClassifySubMenuController(categoryId:categoryId,isVipPush:false)
//                        vc.title = self?.viewModel.homeRecommendList[indexPath.section].title
//                        self?.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
            
            return headerView
        }else if kind == UICollectionView.elementKindSectionFooter {
            let footerView: CYFMRecommendFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CYFMRecommendFooterViewID, for: indexPath) as! CYFMRecommendFooterView
            return footerView
        }
        
        return UICollectionReusableView()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let moduleType = viewModel.homeRecommendList?[indexPath.section].moduleType
        
        if moduleType == "focus" || moduleType == "square" || moduleType == "topBuzz" {
            let cell: CYFMRecommendHeaderCell = collectionView.dequeueReusableCell(withReuseIdentifier: CYFMRecommendHeaderCellID, for: indexPath) as! CYFMRecommendHeaderCell
            cell.focusModel = viewModel.focus
            cell.squareList = viewModel.squareList
            cell.topBuzzListData = viewModel.topBuzzList
            cell.delegate = self
            return cell
        }else if moduleType == "guessYouLike" || moduleType == "paidCategory" || moduleType == "categoriesForLong" || moduleType == "cityCategory" {
            // 横式排列布局cell
            let cell: CYFMRecommendGuessLikeCell = collectionView.dequeueReusableCell(withReuseIdentifier: CYFMRecommendGuessLikeCellID, for: indexPath) as! CYFMRecommendGuessLikeCell
            cell.delegate = self
            cell.recommendListData = viewModel.homeRecommendList?[indexPath.section].list
            return cell
        }else if moduleType == "categoriesForShort" || moduleType == "playlist" || moduleType == "categoriesForExplore" {
            // 竖式排列布局cell
            let cell: CYFMHotAudiobookCell = collectionView.dequeueReusableCell(withReuseIdentifier: CYFMHotAudiobookCellID, for: indexPath) as! CYFMHotAudiobookCell
            cell.recommendListData = viewModel.homeRecommendList?[indexPath.section].list
            return cell
        }else if moduleType == "ad" {
            let cell: CYFMAdvertCell = collectionView.dequeueReusableCell(withReuseIdentifier: CYFMAdvertCellID, for: indexPath) as! CYFMAdvertCell
            if indexPath.section == 7 {
                cell.adModel = self.recommnedAdvertList?[0]
            }else if indexPath.section == 13 {
                cell.adModel = self.recommnedAdvertList?[1]
            }
            return cell
        }else if moduleType == "oneKeyListen" {
            let cell: CYFMOneKeyListenCell = collectionView.dequeueReusableCell(withReuseIdentifier: CYFMOneKeyListenCellID, for: indexPath) as! CYFMOneKeyListenCell
            cell.oneKeyListenList = viewModel.oneKeyListenList
            return cell
        }else if moduleType == "live" {
            let cell: CYFMHomeRecommendLiveCell = collectionView.dequeueReusableCell(withReuseIdentifier: CYFMHomeRecommendLiveCellID, for: indexPath) as! CYFMHomeRecommendLiveCell
            cell.liveList = viewModel.liveList
            return cell
        }else {
            let cell: CYFMRecommendForYouCell = collectionView.dequeueReusableCell(withReuseIdentifier: CYFMRecommendForYouCellID, for: indexPath) as! CYFMRecommendForYouCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let moduleType = viewModel.homeRecommendList?[indexPath.section].moduleType
//        if moduleType == "focus" || moduleType == "square" || moduleType == "topBuzz" {
//
//        }
    }
    
}

//MARK: - 点击顶部分类按钮进入相对应界面
extension CYFMHomeRecommendController: CYFMRecommendHeaderCellDelegate {
    
    func recommendHeaderBannerClick(url: String) {
        print("点击的url："+url)
        
        let status = MessageView.viewFromNib(layout: .statusLine)
        status.backgroundColor = CYFMButtonColor
        status.bodyLabel?.textColor = .white
        status.configureContent(body: "暂无点击功能")
        var statusConfig = SwiftMessages.defaultConfig
        statusConfig.presentationContext = .window(windowLevel: .normal)
        statusConfig.preferredStatusBarStyle = .lightContent
        SwiftMessages.show(config: statusConfig, view: status)
        
    }
    
    func recommendHeaderBtnClick(categoryId: String, title: String, url: String) {
        print("九宫格点击的title："+title+"\nurl："+url)
    }
    
}

//MARK: - 点击猜你喜欢cell代理方法
extension CYFMHomeRecommendController: CYFMRecommendGuessLikeCellDelegate {
    func recommendGuessLikeCellItemClick(model: CYFMRecommendListModel) {
         print("点击猜你喜欢")
    }
}

//MARK: - 点击热门有声书等cell代理方法
extension CYFMHomeRecommendController: CYFMHotAudiobookCellDelegate {
    func hotAudiobookCellItemClick(model: CYFMRecommendListModel) {
        print("点击热门有声书")
    }
}

