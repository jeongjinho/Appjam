
//
//  PHSelectionVO.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 7. 2..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import Foundation
import UIKit


struct PhotoInfo {
    
    var row: Int?
    var image: UIImage?
    init(row:Int, image:UIImage) {
        
        self.row = row
        self.image = image
    }
    
    
}


struct PhotoData {
    var infos:[PhotoInfo]?
    
    init() {
        
    }
    
    
}
