//
//  PhotoColectionDelegate.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 7. 1..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import Foundation
import UIKit
import Photos
import PhotosUI
class PHCollectionDelegate:NSObject{

    var vc: MultiPHSelection
    var allPhotos: PHFetchResult<PHAsset>!
     let imageManager = PHCachingImageManager()
    var selectData: [PhotoInfo]
    init(vc:MultiPHSelection,selectData:[PhotoInfo],allPhotos:PHFetchResult<PHAsset>) {
        self.vc = vc
        self.selectData = selectData
        self.allPhotos = allPhotos
      //  self.selectData = selectData
    }
}


//extension PHCollectionDelegate: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    
    
       
    
   
    
    
    
//
