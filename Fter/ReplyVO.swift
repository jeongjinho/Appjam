//
//  ReplyVO.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 6. 27..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import Foundation
import ObjectMapper

class Reply : Mappable{
    
    var replyerImage: String?
    var reply: String?
    var replyerName: String?
    var replyTime: String?
 var replyerStateMent: String?
 var replyerLevel: Int?
    required init?(map: Map) {}


    func mapping(map: Map) {
        
        replyerImage <- map["image"]
        reply <- map["content"]
        replyerName <- map["user_nick"]
        replyTime <- map["written_time"]
        replyerLevel <- map["level"]
        replyerStateMent <- map["statemessage"]

        
        
        
    }
    
}



class OneReply : Mappable{
    
    var replyerImage: String?
    var reply: String?
    var replyerName: String?
    var replyTime: String?
    var replyerStateMent: String?
    var replyerpart: String?
    var replyerLevel: Int?
    required init?(map: Map) {}
    
    
    func mapping(map: Map) {
        
        replyerImage <- map["image"]
        reply <- map["content"]
        replyerName <- map["user_nick"]
        replyTime <- map["written_time"]
        replyerLevel <- map["level"] 
        replyerStateMent <- map["statemessage"]
        replyerpart <- map["part"]
        
        
        
    }
    
}


class AllReply : Mappable{
    
    var replyerImage: String?
    var reply: String?
    var replyerName: String?
    var replyTime: String?
    var replyerStateMent: String?
    var replyerpart: String?
    var replyerLevel: Int?
    required init?(map: Map) {}
    
    
    func mapping(map: Map) {
        
        replyerImage <- map["image"]
        reply <- map["content"]
        replyerName <- map["user_nick"]
        replyTime <- map["written_time"]
        replyerLevel <- map["level"]
        replyerStateMent <- map["statemessage"]
//        replyerpart <- map["part"]
        
        
        
    }
    
}


class AllReplyVO : Mappable{
    
  
    var result: [AllReply]?
    var message: String?
    
    
    
    
    required init?(map: Map) {}
    
    
    func mapping(map: Map) {
        
        result <- map["result"]
        message <- map["message"]
//        reply <- map["content"]
//        replyerName <- map["user_nick"]
//        replyTime <- map["written_time"]
        //        replyerLevel <- map["level"]
        //        replyerStateMent <- map["statemessage"]
        //        replyerpart <- map["part"]
        
        
        
    }
    
}
//public class Reply: NSObject{
//    
//    var replyerImage: String?
//    var reply: String?
//    var replyerName: String?
//    var replyTime: String?
//       init(sreply:String,sreplyerName:String,sreplyTime:String,sreplyerImage:String){
//    
//        reply = sreply
//        replyerName = sreplyerName
//        replyTime = sreplyTime
//        replyerImage = sreplyerImage
//        
//    }
//
//}
