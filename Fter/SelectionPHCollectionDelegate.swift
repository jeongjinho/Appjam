//
//  SelectionPHCollectionDelegate.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 7. 2..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import Foundation
import UIKit

class SelectionPHCollectionDelegate: NSObject{


    var vc:PostingVC
    var selectData: [PhotoInfo]
    init(vc: PostingVC,selectPhoto:[PhotoInfo]) {
        self.vc = vc
        self.selectData = selectPhoto
    }

}


//extension SelectionPHCollectionDelegate: UICollectionViewDelegate,UICollectionViewDataSource{
//
//    
//    
//    
//
//
//
//}
