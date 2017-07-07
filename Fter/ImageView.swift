//
//  ImageView.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 7. 7..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import Foundation
import UIKit


class CircleImageView: UIImageView{


    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
       
        
    }
    override func awakeFromNib() {
        
        
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.size.width/2
    }


}





