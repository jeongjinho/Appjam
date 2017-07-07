//
//  ReplyVM.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 6. 27..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import Foundation
import UIKit


struct ReplyerNameViewModel:TextForCellProtocol {
    
    var title: String
    var textFontStyle: UIFont
    
    init?(indata:Reply) {
        
        guard let titleString =  indata.replyerName else { return nil }
        self.title = titleString
        self.textFontStyle = UIFont(name:"HelveticaNeue-Bold", size: 12.0)!
    }
    
    init?(indata:OneReply) {
        
        guard let titleString =  indata.replyerName else { return nil }
        self.title = titleString
        self.textFontStyle = UIFont(name:"HelveticaNeue-Bold", size: 12.0)!
    }
    init?(indata:AllReply) {
        
        guard let titleString =  indata.replyerName else { return nil }
        self.title = titleString
        self.textFontStyle = UIFont(name:"HelveticaNeue-Bold", size: 12.0)!
    }

}

struct ReplyViewModel:TextForCellProtocol {
    
    var title: String
    
    
    init?(indata:Reply) {
        
        guard let titleString =  indata.reply else { return nil }
        self.title = titleString
        
    }
    init?(indata:OneReply) {
        
        guard let titleString =  indata.reply else { return nil }
        self.title = titleString
        
    }
    init?(indata:AllReply) {
        
        guard let titleString =  indata.reply else { return nil }
        self.title = titleString
        
    }
}

struct ReplyTimeViewModel:TextForCellProtocol {
    
    var title: String
    var textColor: UIColor
    
    init?(indata:Reply) {
        
        guard let titleString =  indata.replyTime else { return nil }
        self.title = titleString
        self.textColor = AppColors.GrayColor
    }
    init?(indata:OneReply) {
        
        guard let titleString =  indata.replyTime else { return nil }
        self.title = titleString
        self.textColor = AppColors.GrayColor
    }
    init?(indata:AllReply) {
        
        guard let titleString =  indata.replyTime else { return nil }
        self.title = titleString
        self.textColor = AppColors.GrayColor
    }
}

struct ReplyerButtonModel:ImageForCellProtocol {
    
    var image: String
    var radious: CGFloat
    
    init?(indata:Reply,my:UIButton) {
        
        guard let imageString =  indata.replyerImage else { return nil }
        //킹피숴 대체해야함
        print(imageString)
        self.image = imageString
        self.radious = my.frame.size.width/2
        print(self.radious)
    }
    init?(indata:OneReply,my:UIButton) {
        
        guard let imageString =  indata.replyerImage else { return nil }
        //킹피숴 대체해야함
        print(imageString)
        self.image = imageString
        self.radious = my.frame.size.width/2
        print(self.radious)
    }
    init?(indata:AllReply,my:UIButton) {
        
        guard let imageString =  indata.replyerImage else { return nil }
        //킹피숴 대체해야함
        print(imageString)
        self.image = imageString
        self.radious = my.frame.size.width/2
        print(self.radious)
    }

    
}



