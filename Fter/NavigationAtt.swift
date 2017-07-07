//
//  NavigationAtt.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 6. 25..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import UIKit

extension UINavigationBar {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
        
               // Drawing code
    func shadowNabiBar() {
    
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false

        
        let bottomBorderRect = CGRect(x: 0, y: frame.height, width: frame.width, height:2)
        let bottomBorderView = UIView(frame: bottomBorderRect)
        bottomBorderView.backgroundColor = UIColor.white
        addSubview(bottomBorderView)
        
        
    }
    func pureNabiBar() {
        
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        self.barTintColor = UIColor.white
        
        let bottomBorderRect = CGRect(x: 0, y: frame.height, width: frame.width, height:2)
        let bottomBorderView = UIView(frame: bottomBorderRect)
        bottomBorderView.backgroundColor = UIColor.white
      //  addSubview(bottomBorderView)
        
        
    }
    
    
    func setBottomBorderColor(color: UIColor, height: CGFloat) {
        
    }
   
}
