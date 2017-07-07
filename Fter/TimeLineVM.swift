//
//  TimeLineVM.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 6. 27..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher




struct TimeLineNameViewModel:TextForCellProtocol {
    
    var title: String
 //
    var textFontStyle: UIFont
    
    init?(indata:TimeLine) {
        
        guard let titleString =  indata.postInfo?.writerName else { return nil }
              self.title = titleString
        self.textFontStyle = UIFont(name:"HelveticaNeue-Bold", size: 13.0)!
    }
    
    init?(postData:OnePost) {
        
        guard let titleString =  postData.postInfo?.writerName else { return nil }
        self.title = titleString
        print(titleString)
        self.textFontStyle = UIFont(name:"HelveticaNeue-Bold", size: 13.0)!
    }
}

struct TimeLineLevelViewModel:TextForCellProtocol {
    
    var title: String
    
    
    init?(indata:TimeLine) {
        
        guard let titleString =  indata.postInfo?.writerLevel else { return nil }
        self.title =  "LV.\(titleString)"
        
    }
    
    init?(postData:OnePost) {
        
        guard let titleString =  postData.postInfo?.writerLevel else { return nil }
        self.title = "\(titleString)"
        
    }
}

struct TimeLineTimeViewModel:TextForCellProtocol {
    
    var title: String
     var textFontStyle: UIFont
    
    init?(indata:TimeLine) {
        
        guard let titleString =  indata.postInfo?.writtenDate else { return nil }
        print(titleString)
        self.title = titleString
         self.textFontStyle = UIFont(name:"HelveticaNeue-Medium", size: 10.0)!
    }
    
    init?(postData:OnePost) {
        
        guard let titleString =  postData.postInfo?.postText else { return nil }
        self.title = titleString
         self.textFontStyle = UIFont(name:"HelveticaNeue-Medium", size: 10.0)!
        
    }
}

struct TimeLinePostViewModel:TextForCellProtocol {
    
    var title: String
    
    
    init?(indata:TimeLine) {
        
        guard let titleString =  indata.postInfo?.postText else { return nil }
        self.title = titleString
        
    }
    init?(postData:OnePost) {
        
        guard let titleString =  postData.postInfo?.postText else { return nil }
        self.title = titleString
        
    }
}

struct TimeLineTitleViewModel:TextForCellProtocol {
    
    var title: String
     var textFontStyle: UIFont
    
    init?(indata:TimeLine) {
        
        guard let titleString =  indata.postInfo?.postTitle else { return nil }
        self.title = titleString
        self.textFontStyle = UIFont(name:"HelveticaNeue-Bold", size: 14.0)!
    }
    init?(postData:OnePost) {
        
        guard let titleString =  postData.postInfo?.postTitle else { return nil }
        self.title = titleString
        self.textFontStyle = UIFont(name:"HelveticaNeue-Bold", size: 14.0)!
    }
}

struct TimeLineLikeNumberViewModel:TextForCellProtocol {
    
    var title: String
    var textFontStyle: UIFont
    
    init?(indata:TimeLine) {
        
        guard let titleString =  indata.postInfo?.likeNumber else { return nil }
        self.title = "\(titleString)"
        self.textFontStyle = UIFont(name:"HelveticaNeue-Medium", size: 10.0)!
    }
    
    init?(postData:OnePost) {
        
        guard let titleString =  postData.postInfo?.replyNumber else { return nil }
        self.title = "\(titleString)"
        self.textFontStyle = UIFont(name:"HelveticaNeue-Medium", size: 10.0)!
    }
}

struct TimeLineReplyNumberViewModel:TextForCellProtocol {
    
    var title: String
    var textFontStyle: UIFont
    
    init?(indata:TimeLine) {
        
        guard let titleString =  indata.postInfo?.replyNumber else { return nil }
        self.title = "\(titleString)"
        self.textFontStyle = UIFont(name:"HelveticaNeue-Medium", size: 10.0)!
    }
    
    init?(postData:OnePost) {
        
        guard let titleString =  postData.postInfo?.replyNumber else { return nil }
        self.title = "\(titleString)"
        self.textFontStyle = UIFont(name:"HelveticaNeue-Medium", size: 10.0)!
    }
}


struct TimeLineWriterButtonViewModel:ImageForCellProtocol {
    
    var image: String
    var radious: CGFloat
    
    init?(indata:TimeLine,my:UIButton) {
        
        guard let imageString =  indata.postInfo?.writerImage else { return nil }
            //킹피숴 대체해야함
        
            
         self.image = imageString
         self.radious = my.frame.size.width/2
        print(self.radious)
        
    }
    
    init?(postData:OnePost,my:UIButton) {
        
        guard let imageString =  postData.postInfo?.writerImage else { return nil }
        //킹피숴 대체해야함
        
        self.image = imageString
        self.radious = my.frame.size.width/2
        print(self.radious)
        
    }
}
struct TimeLineLikeOrCotentsButtonViewModel:ImageForCellProtocol {
    
    var image: String
   
    
    init?(indata:TimeLine,my:UIButton) {
        
        guard let imageString =  indata.postInfo?.writerImage else { return nil }
        //킹피숴 대체해야함
        self.image = imageString
    }
        init?(postData:OnePost,my:UIButton) {
            
            guard let imageString =  postData.postInfo?.writerImage else { return nil }
            //킹피숴 대체해야함
            self.image = imageString
      
    }
    
}



