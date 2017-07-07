//
//  CustomSegment.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 6. 25..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import UIKit

class DefaultSegment: UIView {
    
       override func draw(_ rect: CGRect) {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width:0, height: 2.0)
        self.layer.shadowRadius = 1
        self.layer.shadowOpacity = 0.3
        self.layer.masksToBounds = false
        
        let bottomBorderRect = CGRect(x: 0, y: frame.height, width: frame.width, height:2)
        let bottomBorderView = UIView(frame: bottomBorderRect)
        bottomBorderView.backgroundColor = UIColor.white
        addSubview(bottomBorderView)
    }
    
   
}


extension UIButton {
    
    func underLineView(isSelect:Bool) {
        
        let layer = CALayer()
        layer.frame = CGRect(x: 0.0, y: self.frame.size.height, width: self.frame.size.width, height: 4.0)
        
        if isSelect == true {
            layer.backgroundColor = AppColors.PupleColor.cgColor
            self.setTitleColor(AppColors.PupleColor, for: .normal)
        } else {
        
        layer.backgroundColor = UIColor.white.cgColor
            self.setTitleColor(AppColors.GrayColor, for: .normal)
        }
        
        
        self.layer.addSublayer(layer)
    }
    
    func removeBoarder() {
        guard let sublayer =  self.layer.sublayers?.last else { return  }
        
        sublayer.removeFromSuperlayer()
        
    }
    
    
    
}
