//
//  DefaultNavibar.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 6. 30..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import UIKit

class DefaultNavibar: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        
        
        let bottomBorderRect = CGRect(x: 0, y: frame.height, width: frame.width, height:2)
        let bottomBorderView = UIView(frame: bottomBorderRect)
        bottomBorderView.backgroundColor = UIColor.white

    }
    

}
