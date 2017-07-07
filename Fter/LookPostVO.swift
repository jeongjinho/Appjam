//
//  LookPostVO.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 7. 5..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
public class OnePostVO:Mappable{
    
    var results: OnePost?
    var message : String?
    
    public required init?(map: Map) {
        
        
    }
    
    public  func mapping(map: Map) {
        
        results <- map["result"]
        
        message <- map["message"]
    }
    
}

public class OnePost:Mappable {
    
    var replies: [OneReply]?
    var postInfo: OnePostInfo?
    
    public required init?(map: Map) {
        
    }
    
    public  func mapping(map: Map) {
        
        replies <- map["commentinfo"]
        
        postInfo <- map["postinpo"]
        
        
    }
    
    
}








public class OnePostInfo:Mappable{
    
    
    var replyNumber: Int?
    var likeNumber: Int?
    var postText: String?
    var writtenDate: String?
    var writerName: String?
    var writerLevel: Int?
    var postTitle: String?
    var writerImage: String?
    var uploadedImage: [String?]?
    var id:Int?
    
    var likeCheck: Int?
    var markcheck: Int?
    var writerState: String?
    var postPart: String?
    var userPart:String?
    var category: Int?
    public required init?(map: Map) {
        
    }
    
    public  func mapping(map: Map) {
        userPart <- map["userpart"]
        id <- map["id"]
        replyNumber <- map["commentcount"]
        likeNumber <- map["likecount"]
        likeCheck <- map["likecheck"]
        markcheck <- map["markcheck"]
        postText <- map["contents"]
        writtenDate <- map["written_time"]
        writerName <- map["nickname"]
        writerLevel <- map["level"]
        postTitle <- map["title"]
        writerImage <- map["profile"]
        uploadedImage <- map["image"]
        writerState <- map["statemessage"]
        postPart <- map["postpart"]
        category <- map["category"]
    }
    
}







//class Images: Mappable {
//
//     var image: String?
//
//    required init?(map: Map) {}
//
//     func mapping(map: Map) {
//
//        image <- map["image"]
//
//    }
//}



//  광고하나













