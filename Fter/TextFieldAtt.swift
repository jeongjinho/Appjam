//
//  TextFieldAtt.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 6. 25..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import UIKit

class UnderlineTextField: UITextField {


    override func draw(_ rect: CGRect) {
    
        let layer = CALayer()
        layer.frame = CGRect(x: 0.0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1.0)

       layer.backgroundColor = AppColors.GrayColor2.cgColor
        
        self.layer.addSublayer(layer)
    
    }
    

}


class CircleTextField:UITextField{

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.layer.cornerRadius = self.frame.size.height/2
        self.backgroundColor = AppColors.GrayColor
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1.0
    }

}







class DropBoxTextField:UITextField{

    
    override func draw(_ rect: CGRect) {
        super.drawText(in: rect)
        let leftView = UIView()
        leftView.frame = CGRect(x:0, y: 0, width:15, height: 40)
        self.leftViewMode = .always
        self.leftView = leftView
        //~~~~~~~~~~
        let rightImageView = UIImageView()
        rightImageView.image = UIImage(named: "down")
        
        let rightView = UIView()
        rightView.addSubview(rightImageView)
        
        rightView.frame = CGRect(x: self.frame.size.width-40, y: 0, width: 40, height: 40)
        rightImageView.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
        self.rightViewMode = .always
        self.rightView = rightView
        //~~~~~~~~~~~~~~~~~~~~~~~~~~~

        
    }
    

}

