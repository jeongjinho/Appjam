//
//  CirCleTextView.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 6. 28..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import UIKit

class CirCleTextView: UITextView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
   
        // Drawing code
        
        
    override func draw(_ rect: CGRect) {
    super.draw(rect)
                
    self.layer.cornerRadius = self.frame.size.height/2
    self.layer.backgroundColor = AppColors.GrayColor2.cgColor
    self.layer.borderColor = UIColor.white.cgColor
    self.layer.borderWidth = 1.0
    }
            
      

  
    

}
