//
//  File.swift
//  ButtonStyle
//
//  Created by 진호놀이터 on 2017. 6. 22..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import Foundation
import UIKit


class CircleButton: UIButton{

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.cornerRadius = self.frame.size.height/2
        self.layer.masksToBounds = true
    }

}


protocol BackViewProtocol {
    var backgroundColor: UIColor {get}
    var backgroundImage: UIImage {get}
}

extension BackViewProtocol{

    var backgroundColor: UIColor {
    
        return UIColor.white
    }
    var backgroundImage: UIImage {
    
    
        return UIImage.init()
    }

}

protocol BorderProtocol{
    
    var borderColor: CGColor {get}
    var borderWidth: Float {get}
    var borderRadius: Float {get}
}

extension BorderProtocol{
    
    var borderColor: UIColor {
    
        return UIColor.black
        
    }
    var  borderWidth: Float{
    
        return 0
    }
    
    var borderRadius: Float{
    
        return 0
    }
    
}

protocol TextProtocol {
    
    var fontStyle: UIFont {get}
    var fontColor: UIColor {get}
    var text     : String {get}
}


extension TextProtocol{

    var fontStyle: UIFont{
    
        return UIFont(name: "AppleSDGothicNeo-Regular", size: 13)!
    }
    
    var fontColor: UIColor {
    
    return UIColor.black
    }
    
    var text: String{
        return ""
    }
}

enum ButtonStyle {
    case  defaultStyle
    case  fillStyle
    case  borderStyle
}

class ButtonViewModel:BorderProtocol,TextProtocol,BackViewProtocol{
    
     //var fontStyle: UIFont
    var fontColor: UIColor
    var text: String
    var borderWidth: Float
    var borderRadius: Float
    var borderColor: CGColor
    var backgroundColor: UIColor
    
    init(fontColor:UIColor, text:String, borderColor: UIColor,borderWidth:Float, borderRadius:Float,backgroundColor: UIColor) {
        
       
        self.fontColor = fontColor
        self.text = text
        self.borderColor = borderColor.cgColor
        self.borderWidth = borderWidth
        self.borderRadius = borderRadius
        self.backgroundColor = backgroundColor
        
    }
    
   
    
   
    
}

extension UIButton {

    func DefaultButton(style:ButtonStyle, buttonVM:ButtonViewModel){
        
        
        
        self.layer.borderWidth = CGFloat(buttonVM.borderWidth)
        self.layer.borderColor = buttonVM.borderColor
        self.layer.cornerRadius = CGFloat(buttonVM.borderRadius)
         self.titleLabel?.font = buttonVM.fontStyle
          self.titleLabel?.text = buttonVM.text
        let uicolor = UIColor.init(cgColor:buttonVM.borderColor)

        switch style {
        case .borderStyle:
                       self.setTitleColor(uicolor, for: .normal)
            break
            
        case .fillStyle:
                self.backgroundColor = uicolor
                self.setTitleColor(buttonVM.backgroundColor, for: .normal)
            
        default:
             //self.titleLabel?.textColor = buttonVM.fontColor
           //  self.backgroundColor = buttonVM.backgroundColor
             
            break
        }
      
       
    }
    

}


