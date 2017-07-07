//
//  AdvertisingDelegate.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 6. 28..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import Foundation
import UIKit
extension AdvertisingDelegate: UICollectionViewDelegate{



    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let cardVC = self.vc.storyboard?.instantiateViewController(withIdentifier:"CardVC") as! CardVC
        
        self.vc.navigationController?.pushViewController(cardVC, animated:true)
    }

    
}
