//
//  CYFMHomeLiveController.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/16.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

let CYFMHomeLiveSectionGrid     = 0   // 分类section
let CYFMHomeLiveSectionBanner   = 1   // 滚动图片section
let CYFMHomeLiveSectionRank     = 2   // 排行榜section
let CYFMHomeLiveSectionLive     = 3   // 直播section

class CYFMHomeLiveController: CYBaseController {

    private let CYFMHomeLiveHeaderViewID = "CYFMHomeLiveHeaderView"
    private let CYFMHomeLiveGridCellID   = "CYFMHomeLiveGridCell"
    private let CYFMHomeLiveBannerCellID = "CYFMHomeLiveBannerCell"
    private let CYFMHomeLiveRankCellID   = "CYFMHomeLiveRankCell"
    private let CYFMRecommendLiveCellID  = "CYFMRecommendLiveCell"
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.showsVerticalScrollIndicator = false
        
        collectionV.register(CYFMHomeLiveHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CYFMHomeLiveHeaderViewID)
        
        collectionV.register(CYFMHomeLiveGridCell.self, forCellWithReuseIdentifier: CYFMHomeLiveGridCellID)
        collectionV.register(CYFMHomeLiveBannerCell.self, forCellWithReuseIdentifier: CYFMHomeLiveBannerCellID)
        collectionV.register(CYFMHomeLiveRankCell.self, forCellWithReuseIdentifier: CYFMHomeLiveRankCellID)
        collectionV.register(CYFMRecommendLiveCell.self, forCellWithReuseIdentifier: CYFMRecommendLiveCellID)
        collectionV.cyHead = CYRefreshHeader{[weak self] in self?.loadLiveData()}
        return collectionV
    }()
    
    private lazy var viewModel: CYFMHomeLiveViewModel = {
        return CYFMHomeLiveViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
        }
        
        self.collectionView.cyHead.beginRefreshing()
//        loadLiveData()
    }

    func loadLiveData(){
        viewModel.updataBlock = {[weak self] in
            self?.collectionView.cyHead.endRefreshing()
            self?.collectionView.reloadData()
        }
        viewModel.refreshDataSource()
    }
}

extension CYFMHomeLiveController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsIn(section: section)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return viewModel.insetForSectionAt(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumLineSpacingForSectionAt(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumInteritemSpacingForSectionAt(section: section)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.sizeForItemAt(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return viewModel.referenceSizeForHeaderInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case CYFMHomeLiveSectionGrid:
            let cell: CYFMHomeLiveGridCell = collectionView.dequeueReusableCell(withReuseIdentifier: CYFMHomeLiveGridCellID, for: indexPath) as! CYFMHomeLiveGridCell
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 5.0
            cell.delegate = self
            
            return cell
        case CYFMHomeLiveSectionBanner:
            let cell: CYFMHomeLiveBannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: CYFMHomeLiveBannerCellID, for: indexPath) as! CYFMHomeLiveBannerCell
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 5.0
            cell.bannerList = viewModel.homeLiveBanerList
            return cell
            
        case CYFMHomeLiveSectionRank:
            let cell: CYFMHomeLiveRankCell = collectionView.dequeueReusableCell(withReuseIdentifier: CYFMHomeLiveRankCellID, for: indexPath) as! CYFMHomeLiveRankCell
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 5.0
            cell.backgroundColor = .red
            cell.multidimensionalRankVos = viewModel.multidimensionalRankVos
            return cell
        default:
            let cell: CYFMRecommendLiveCell = collectionView.dequeueReusableCell(withReuseIdentifier: CYFMRecommendLiveCellID, for: indexPath) as! CYFMRecommendLiveCell
            cell.liveModel = viewModel.lives?[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView: CYFMHomeLiveHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CYFMHomeLiveHeaderViewID, for: indexPath) as! CYFMHomeLiveHeaderView
            headerView.delegate = self
            return headerView
        }else {
            return UICollectionReusableView()
        }
    }
}

// - 点击中间直播item上分类按钮 delegate
extension CYFMHomeLiveController: CYFMHomeLiveHeaderViewDelegate {
    func homeLiveHeaderViewCategoryBtnClick(button: UIButton) {
        viewModel.categoryType = button.tag - 988
        viewModel.updataBlock = {[weak self] in
            self?.collectionView.reloadData()
        }
        viewModel.refreshCategoryLiveData()
    }
}

// - 点击顶部分类按钮 delegate
extension CYFMHomeLiveController: CYFMHomeLiveGridCellDelegate {
    func homeLiveGridCellItemClick(channelId: Int, title: String) {
        let vc = CYFMLiveCategoryListController(channelId: channelId)
        vc.title = title
        navigationController?.pushViewController(vc, animated: true)
    }
}
