//
//  AdevertisingDelegate.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 6. 27..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import Foundation
import UIKit

class AdvertisingDelegate: NSObject {
    
    var vc : MainTimeLineVC
    var data = [AdverTising?]()
    var currentPage: Int?
    init(sc :MainTimeLineVC,data:[AdverTising]) {
        self.vc = sc
       self.data = data
    }
}

extension AdvertisingDelegate:UICollectionViewDataSource{

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(self.data.count)
        return self.data.count
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     //    let itemToShow = self.data[indexPath.row % self.data.count]
         let adCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdverTisingCell", for: indexPath) as! AdverTisingCell
       
    
        guard let data = self.data[indexPath.row] else { return adCell }
        
            adCell.configureAd(data)
        
        
        return adCell
    }
    
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let numberOfCells = self.data.count
//        let page = Int(scrollView.contentOffset.x) / Int(scrollView.frame.size.width)
//        
//        print("page:" + "\(page)")
//        
//        if (page == self.data.count - 1){
//            
//            scrollView.contentOffset = CGPoint(x:0.0, y: 0.0)
//            self.vc.adPagingControl.currentPage = page
//        }
//        self.vc.adPagingControl.currentPage = page
//    }
 
    
        
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }

}
