//
//  ImageCollectionDataSource.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 6. 28..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import Foundation
import UIKit


class ImageCollectionDelegate: NSObject {
    var lookPost: LookPostVC?
    var vc : MainTimeLineVC?
    var lookVC : LookVC?
    var data: [String?] = []
    
    init(sc :MainTimeLineVC,data:[String]) {
        self.vc = sc
        self.data = data
    }
    init(lookPostVC :LookPostVC,data:[String]) {
        self.lookPost = lookPostVC
        self.data = data
    }
    
    init(lookVC :LookVC, data:[String]) {
        self.lookVC = lookVC
        self.data = data
    }

}

extension ImageCollectionDelegate: UICollectionViewDataSource{


    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let uploadedCell = collectionView.dequeueReusableCell(withReuseIdentifier:"AdverTisingCell", for: indexPath) as! AdverTisingCell
        guard let imageData = self.data[indexPath.row] else { return uploadedCell }
        
        uploadedCell.configureUploaded( imageData)
        
        
        
        return uploadedCell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let mainVC = CenterSideVC(nibName:"CenterSideVC", bundle:nil)
        mainVC.photos = self.data as! [String]
        mainVC.view.frame = UIScreen.main.bounds
        
        if self.vc != nil {
            self.vc?.addChildViewController(mainVC)
            self.vc?.view.addSubview(mainVC.view)
            mainVC.didMove(toParentViewController: self.vc)
            mainVC.getCenterSideCallback(callback:self.vc!)
            self.vc?.tabBarController?.tabBar.isHidden = true
        }else {
            self.lookVC?.addChildViewController(mainVC)
            self.lookVC?.view.addSubview(mainVC.view)
            mainVC.didMove(toParentViewController: self.lookVC)
            self.lookVC?.tabBarController?.tabBar.isHidden = true
            mainVC.getCenterSideCallback(callback:self.lookVC!)
        }

        
    }
}
    

