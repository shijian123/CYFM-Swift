//
//  CYReplicatorLayer.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/15.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

class CYReplicatorLayer: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createLayer(){
        let layer = CALayer.init()
        layer.frame = self.bounds
        layer.backgroundColor = UIColor.white.cgColor
        layer.anchorPoint = CGPoint.init(x: 0.5, y: 0.5)
        layer.add(self.scaleYAnimation(), forKey: "scaleAnimation")
        
        let replicatorLayer = CAReplicatorLayer.init()
        replicatorLayer.frame = self.bounds
        
        //设置复制层里面包含子层的个数
        replicatorLayer.instanceCount = 4
        
        //设置子层相对于前一个层的偏移量
        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(5, 0, 0)
        
        //设置子层相对于前一个层的延迟时间
        replicatorLayer.instanceDelay = 0.2
        
        //设置层的颜色，(前提是要设置层的背景颜色，如果没有设置背景颜色，默认是透明的，再设置这个属性不会有效果。
        replicatorLayer.instanceColor = CYFMButtonColor.cgColor
        
        //需要把子层加入到复制层中，复制层按照前面设置的参数自动复制
        replicatorLayer.addSublayer(layer)
        
        //将复制层加入view的层里面进行显示
        self.layer.addSublayer(replicatorLayer)
    }
}

extension CYReplicatorLayer {
    fileprivate func scaleYAnimation() -> CABasicAnimation{
        let anim = CABasicAnimation.init(keyPath: "transform.scale.y")
        anim.toValue = 0.1
        anim.duration = 0.4
        anim.autoreverses = true
        anim.repeatCount = MAXFLOAT
        anim.isRemovedOnCompletion = false
        return anim
    }
}
