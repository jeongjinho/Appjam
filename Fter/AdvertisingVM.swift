//
//  AdvertisingVM.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 6. 27..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import UIKit


class AdverTising: NSObject{
    
    var adPhotoName:String?
    var adTitle: String?
    init(title:String,photos:String) {
        adPhotoName = photos
        adTitle = title
        
    }
}
    
  
struct AdImageViewModel:ImageForCellProtocol {
        
        var image: String
        //var radious: CGFloat
        
        init?(indata:AdverTising) {
            
            guard let imageString =  indata.adPhotoName else { return nil }
            //킹피숴 대체해야함
            print(imageString)
            self.image = imageString
        
            
        }
}
//////



class UploadedImage: NSObject {
    
    var uploaded: String?
    
    init(imageName: String) {
        self.uploaded = imageName
    }
}
struct UploadImageViewModel:ImageForCellProtocol {
    
    var image: String
    //var radious: CGFloat
    
    init?(indata:String) {
        
              //킹피숴 대체해야함
        print(indata)
        self.image = indata
        
        
    }
}
////////
class PhotoAlbumImage: NSObject {
    
    var albumPhoto: UIImage?
    
    init(image: UIImage) {
        self.albumPhoto = image
    }
}


struct PhotoAlbumImageViewModel:PhotoForCellProtocol {
    
    var image: UIImage
    //var radious: CGFloat
    
    init?(indata:PhotoAlbumImage) {
        
        guard let image =  indata.albumPhoto else { return nil }
        //킹피숴 대체해야함
        
        self.image = image
        
        
    }
}

/////


struct AdTitleViewModel:TextForCellProtocol {
    var title: String
    var textFontStyle: UIFont
    var textColor: UIColor
    init?(indata:AdverTising) {
        
        guard let titleString =  indata.adTitle else { return nil }
        self.title = "\(titleString)"
        self.textFontStyle = UIFont(name:"HelveticaNeue-Bold", size: 18.0)!
        self.textColor = .white
    }
}
