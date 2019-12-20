//
//  CYFMPlayController.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/15.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

class CYFMPlayController: CYBaseController {

    private var albumId: Int = 0
    private var trackUid: Int = 0
    private var uid: Int = 0
    
    convenience init(albumId: Int = 0, trackUid: Int = 0, uid: Int = 0) {
        self.init()
        self.albumId = albumId
        self.trackUid = trackUid
        self.uid = uid
    }
    
    private let CYFMPlayHeaderViewID    = "CYFMPlayHeaderView"
    private let CYFMPlayFooterViewID    = "CYFMPlayFooterViewID"
    
    private let CYFMPlayCellID          = "CYFMPlayCell"
    private let CYFMPlayCommentCellID   = "CYFMPlayCommentCell"
    private let CYFMPlayAnchorCellID    = "CYFMPlayAnchorCell"
    private let CYFMPlayCircleCellID    = "LBFMPlayCircleCell"
    
    private lazy var myCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.backgroundColor = .white
        
        collectionV.register(CYFMPlayHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CYFMPlayHeaderViewID)
        collectionV.register(CYFMPlayFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CYFMPlayFooterViewID)
        
        collectionV.register(CYFMPlayCell.self, forCellWithReuseIdentifier: CYFMPlayCellID)
        collectionV.register(CYFMPlayCommentCell.self, forCellWithReuseIdentifier: CYFMPlayCommentCellID)
        collectionV.register(CYFMPlayAnchorCell.self, forCellWithReuseIdentifier: CYFMPlayAnchorCellID)
        collectionV.register(CYFMPlayCircleCell.self, forCellWithReuseIdentifier: CYFMPlayCircleCellID)
        
        return collectionV
    }()
    
    private lazy var viewModel: CYFMPlayViewModel = {
        return CYFMPlayViewModel(albumId: self.albumId, trackUid: self.trackUid, uid: self.uid)
    }()
    
    private lazy var leftBarBtn: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn.setImage(UIImage(named: "playpage_icon_down_black_30x30_"), for: .normal)
        btn.addTarget(self, action: #selector(leftBarBtnClickMethod), for: .touchUpInside)
        return btn
    }()
    
    private lazy var rightBarBtn1: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn.setImage(UIImage(named: "playpage_icon_more_black_30x30_"), for: .normal)
        btn.addTarget(self, action: #selector(rightBarBtnClick1Method), for: .touchUpInside)
        return btn
    }()
    
    private lazy var rightBarBtn2: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn.setImage(UIImage(named: "playpage_icon_share_black_30x30_"), for: .normal)
        btn.addTarget(self, action: #selector(rightBarBtnClick2Method), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBarTintColor = .white
        navBarBackgroundAlpha = 0
        view.addSubview(self.myCollectionView)
        self.myCollectionView.snp.makeConstraints { (make) in
            make.width.height.equalToSuperview()
            make.center.equalToSuperview()
        }
        
        loadData()
        
        let rightBarBtnItem1: UIBarButtonItem = UIBarButtonItem(customView: rightBarBtn1)
        let rightBarBtnItem2: UIBarButtonItem = UIBarButtonItem(customView: rightBarBtn2)
        navigationItem.rightBarButtonItems = [rightBarBtnItem1, rightBarBtnItem2]
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarBtn)
        
    }
    
    // 返回
    @objc func leftBarBtnClickMethod() {
        navigationController?.popViewController(animated: true)
    }
    
    // 更多
    @objc func rightBarBtnClick1Method() {
        
    }
    
    // 分享
    @objc func rightBarBtnClick2Method() {
        
    }
    
    func loadData() {
        viewModel.updataBlock = {[weak self] in
            self?.myCollectionView.reloadData()
        }
        viewModel.refreshDataSource()
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY > 0 {
            navBarBackgroundAlpha = 1
        }else {
            navBarBackgroundAlpha = 0
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CYFMPlayController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections(collectionView: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsIn(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return viewModel.insetForSectionAt(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumInteritemSpacingForSectionAt(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumLineSpacingForSectionAt(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.sizeForItemAt(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return viewModel.referenceSizeForHeaderInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return viewModel.referenceSizeForHeaderInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell: CYFMPlayCell = collectionView.dequeueReusableCell(withReuseIdentifier: CYFMPlayCellID, for: indexPath) as! CYFMPlayCell
            cell.playTrckInfo = viewModel.playTrackInfo
            return cell
        }else if indexPath.section == 1 {
            let cell: CYFMPlayAnchorCell = collectionView.dequeueReusableCell(withReuseIdentifier: CYFMPlayAnchorCellID, for: indexPath) as! CYFMPlayAnchorCell
            cell.userInfo = viewModel.userInfo
            return cell
        }else if indexPath.section == 2 {
            let cell: CYFMPlayCircleCell = collectionView.dequeueReusableCell(withReuseIdentifier: CYFMPlayCircleCellID, for: indexPath) as! CYFMPlayCircleCell
            cell.communityInfo = viewModel.communityInfo
            return cell
        }else {
            let cell: CYFMPlayCommentCell = collectionView.dequeueReusableCell(withReuseIdentifier: CYFMPlayCommentCellID, for: indexPath) as! CYFMPlayCommentCell
            cell.playCommentInfo = viewModel.playCommentInfo?[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView: CYFMPlayHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CYFMPlayHeaderViewID, for: indexPath) as! CYFMPlayHeaderView
            return headerView
        }else if kind == UICollectionView.elementKindSectionFooter {
            let footerView: CYFMPlayFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CYFMPlayFooterViewID, for: indexPath) as! CYFMPlayFooterView
            return footerView
        }
        return UICollectionReusableView()
    }
    
}
