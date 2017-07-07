//
//  CellViewModel.swift
//  ExpandBleTableView
//
//  Created by 진호놀이터 on 2017. 6. 8..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import Foundation
import UIKit


protocol ButtonForCellProtocol {
    
    
    var selectImage: String {get}
    var nonSelectImage: String {get}
    
}

protocol TextForCellProtocol {
    
    
    var title: String {get}
    var textColor: UIColor {get}
    var textFontStyle: UIFont {get}
    
}
extension TextForCellProtocol{
    var title: String {
    
        return ""
    }
    var textFontStyle: UIFont {
    
    
        return UIFont(name:"HelveticaNeue-Regular", size: 12.0)!
    
    }
    
    
    var textColor : UIColor {
    
        return UIColor(colorLiteralRed:0, green:0, blue:0, alpha: 1)
    }
}


struct  SubLabelViewModel:TextForCellProtocol {
    var title: String
    var textColor: UIColor {
    
        return .black
    }
//    init?(SubDatas inData:DepartMent) {
//        guard let titleString =  inData.departMentName else { return nil }
//        print("\(titleString)")
//        self.title = titleString
//        
//        }
//    
//    
    }

protocol PhotoForCellProtocol {
    
    var image: UIImage {get}
    var alpha: Float {get}
    var radious: CGFloat {get}
    var contentMode: UIViewContentMode {get}
}

extension PhotoForCellProtocol{
    
    var alpha :Float{
        
        return 1
    }
    var image: UIImage{
        
        return  UIImage()
    }
    
    var radious: CGFloat{
        
        
        return 0
    }
    
    var contentMode: UIViewContentMode{
        
        return .scaleAspectFill
    }
}



protocol ImageForCellProtocol {
    
    var image: String {get}
    var alpha: Float {get}
    var radious: CGFloat {get}
    var contentMode: UIViewContentMode {get}
}

extension ImageForCellProtocol{

    var alpha :Float{
    
        return 1
    }
    var image: String{
        
        return  "DefaultProfile"
    }
    
    var radious: CGFloat{
    
    
    return 0
    }
    
    var contentMode: UIViewContentMode{
    
     return .scaleAspectFill
    }
}

struct ImageViewModel:ImageForCellProtocol {
    var image: UIImage

    
//    init?(datas inData: SchoolData) {
//        
//        guard let schoolImageString = inData.schoolImageName else { return nil }
//        self.image = UIImage(named:schoolImageString)!
//    }
}
