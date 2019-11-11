//
//  CYFMPlayCell.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/11/7.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit
import StreamingKit

class CYFMPlayCell: UICollectionViewCell {
    var playURL: String?
    var time: Timer?
    var displayLink: CADisplayLink?
    
    private var isFirstPlay: Bool = true
    private lazy var audioPlayer: STKAudioPlayer = {
        let audioPlayer = STKAudioPlayer()
        return audioPlayer
    }()
    
    private var titleLab: UILabel = {
        let lab = UILabel()
        lab.textAlignment = .center
        lab.numberOfLines = 0
        lab.font = UIFont.systemFont(ofSize: 20)
        return lab
    }()

    private var imgView: UIImageView = {
        let imgV = UIImageView()
        return imgV
    }()
    
    private lazy var barrageBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "NPProDMOff_24x24_"), for: .normal)
        return btn
    }()
    
    private lazy var machineBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "npXPlay_30x30_"), for: .normal)
        return btn
    }()
    
    private lazy var setBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "NPProSet_25x24_"), for: .normal)
        return btn
    }()
    
    private lazy var slider: UISlider = {
        let slider = UISlider()
        slider.setThumbImage(UIImage(named: "playProcessDot_n_7x16_"), for: .normal)
        // 大于滑块当前值滑块条的颜色
        slider.maximumTrackTintColor = .lightGray
        // 小于滑块当前值滑块条的颜色
        slider.minimumTrackTintColor = CYFMButtonColor
        slider.addTarget(self, action: #selector(CYFMPlayCell.change(slider:)), for: UIControl.Event.valueChanged)
        slider.addTarget(self, action: #selector(CYFMPlayCell.sliderDragUp(slider:)), for: UIControl.Event.touchUpInside)
        return slider
    }()
    
    private lazy var currentTime: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 15)
        lab.textColor = CYFMButtonColor
        return lab
    }()
    
    private lazy var totalTime: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 15)
        lab.textColor = CYFMButtonColor
        lab.textAlignment = .right
        return lab
    }()
    
    private lazy var playBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "toolbar_play_n_p_78x78_"), for: .normal)
        btn.addTarget(self, action: #selector(playMethod(sender:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var prevBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "toolbar_prev_n_p_24x24_"), for: .normal)
        btn.addTarget(self, action: #selector(prevMethod(sender:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var nextBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "toolbar_next_n_p_24x24_"), for: .normal)
        btn.addTarget(self, action: #selector(nextMethod(sender:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var msgBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "playpage_icon_list_24x24_"), for: .normal)
        return btn
    }()
    
    private lazy var timingBtn: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setImage(UIImage(named: "playpage_icon_timing_24x24_"), for: .normal)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        addSubview(self.titleLab)
        self.titleLab.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(60)
        }
        
        addSubview(self.imgView)
        self.imgView.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLab.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(60)
            make.right.equalToSuperview().offset(-60)
            make.height.equalTo(CYFMScreenWidth * 0.7 - 260)
        }
        
        addSubview(self.barrageBtn)
        self.barrageBtn.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(self.imgView.snp.bottom).offset(20)
            make.height.width.equalTo(30)
        }
        
        addSubview(self.setBtn)
        self.setBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.top.equalTo(self.imgView.snp.bottom).offset(20)
            make.height.width.equalTo(30)
        }
        
        addSubview(self.machineBtn)
        self.machineBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.setBtn.snp.left).offset(-20)
            make.top.equalTo(self.imgView.snp.bottom).offset(20)
            make.height.width.equalTo(30)
        }
        
        addSubview(self.slider)
        self.slider.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-90)
        }
        
        addSubview(self.currentTime)
        self.currentTime.text = "00:00"
        self.currentTime.snp.makeConstraints { (make) in
            make.left.equalTo(self.slider)
            make.top.equalTo(self.slider.snp.bottom).offset(5)
            make.width.equalTo(60)
            make.height.equalTo(20)
        }
        
        addSubview(self.totalTime)
        self.totalTime.text = "21:33"
        self.totalTime.snp.makeConstraints { (make) in
            make.right.equalTo(self.slider)
            make.top.equalTo(self.slider.snp.bottom).offset(5)
            make.width.equalTo(60)
            make.height.equalTo(20)
        }
        
        addSubview(self.playBtn)
        self.playBtn.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-20)
            make.height.width.equalTo(60)
            make.centerX.equalToSuperview()
        }
        
        addSubview(self.prevBtn)
        self.prevBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.playBtn.snp.left).offset(-30)
            make.height.width.equalTo(25)
            make.centerY.equalTo(self.playBtn)
        }
        
        addSubview(self.nextBtn)
        self.nextBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.playBtn.snp.right).offset(30)
            make.height.width.equalTo(25)
            make.centerY.equalTo(self.playBtn)
        }
        
        addSubview(self.msgBtn)
        self.msgBtn.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.bottom.equalToSuperview().offset(-20)
            make.height.width.equalTo(40)
        }
        
        addSubview(self.timingBtn)
        self.timingBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.bottom.equalToSuperview().offset(-20)
            make.height.width.equalTo(40)
        }
        
    }
    
    var playTrckInfo: CYFMPlayTrackInfo? {
        didSet{
            guard let model = playTrckInfo else { return }
            self.titleLab.text = model.title
            self.imgView.kf.setImage(with: URL(string: model.coverLarge!))
            self.totalTime.text = getMMSSFromSS(duration: model.duration)
            self.playURL = model.playUrl64
        }
    }
    
    @objc func playMethod(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.setImage(UIImage(named: "toolbar_pause_n_p_78x78_"), for: .normal)
            if isFirstPlay {
                self.audioPlayer.play(URL(string: self.playURL!)!)
                starTimer()
                isFirstPlay = false
            }else {
                starTimer()
                self.audioPlayer.resume()
            }
        }else {
            sender.setImage(UIImage(named: "toolbar_play_n_p_78x78_"), for: .normal)
            removeTimer()
            self.audioPlayer.pause()
        }
        
    }
    
    @objc func prevMethod(sender: UIButton) {
        
    }
    
    @objc func nextMethod(sender: UIButton) {
        
    }
    
    
    func getMMSSFromSS(duration: Int) ->(String) {
        var min = duration / 60
        let sec = duration % 60
        var hour: Int = 0
        
        if min >= 60 {
            hour = min / 60
            min = min % 60
            if hour > 0 {
                return String(format: "%02d:%02d:%02d", hour, min, sec)
            }
        }
        return String(format: "%02d:%02d", min, sec)
    }
    
    func starTimer() {
        displayLink = CADisplayLink(target: self, selector: #selector(updateCurrentLab))
        displayLink?.add(to: RunLoop.current, forMode: .common)
    }
    
    func removeTimer() {
        displayLink?.invalidate()
        displayLink = nil
    }
}

extension CYFMPlayCell {
    
    @objc func updateCurrentLab() {
        let currentTime: Int = Int(self.audioPlayer.progress)
        self.currentTime.text = getMMSSFromSS(duration: currentTime)
        let progress = Float(self.audioPlayer.progress / self.audioPlayer.duration)
        slider.value = progress
    }
    
    @objc func change(slider: UISlider) {
        print("slider.value = %d", slider.value)
        audioPlayer.seek(toTime: Double(slider.value * Float(self.audioPlayer.duration)))
    }
    
    @objc func sliderDragUp(slider: UISlider) {
        print("value:\(slider.value)")
    }
}
