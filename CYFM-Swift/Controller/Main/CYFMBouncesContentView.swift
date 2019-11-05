//
//  CYFMBouncesContentView.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/15.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

class CYFMBouncesContentView: CYFMBasicContentView {
    public var duration = 0.3
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func selectAnimation(animated: Bool, completion: (() -> ())?) {
        self.bounceAnimation()
        completion?()
    }
    
    override func reselectAnimation(animated: Bool, completion: (() -> ())?) {
        self.bounceAnimation()
        completion?()
    }
    
    func bounceAnimation() {
        let scaleAnim = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnim.values = [1.0, 1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
        scaleAnim.duration = duration * 2
        scaleAnim.calculationMode = CAAnimationCalculationMode.cubic
        imageView.layer.add(scaleAnim, forKey: nil)
    }
    
}
