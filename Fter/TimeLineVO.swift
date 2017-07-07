//
//  TimeLineVO.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 6. 26..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import Foundation
import ObjectMapper




//public class TimeLine:NSObject {
//    
//    var replies: [Reply]?
//    var replyNumber: Int?
//    var likeNumber: Int?
//    var postText: String?
//    var writtenDate: String?
//    var writerName: String?
//    var writerLevel: Int?
//    var postTitle: String?
//    var writerImage: String?
//    var uploadedImage: [UploadedImage]?
//    init(sreplies:[Reply]?,sreplyNumber:Int,slikeNumber:Int,spostText:String,swrittenDate:String,swriterName:String,swriterLevel:Int,spostTitle:String,swriterImage:String,suploadedImage:[UploadedImage]?) {
//        
//        replies = sreplies
//        replyNumber = sreplyNumber
//        likeNumber = slikeNumber
//        postText  = spostText
//        writtenDate = swrittenDate
//        writerName = swriterName
//        writerLevel = swriterLevel
//        postTitle = spostTitle
//        writerImage = swriterImage
//        uploadedImage = suploadedImage
//    }
//    
//}

public class TimeLineVO:Mappable{

    var results: [TimeLine]?
    var message : String?
    
    public required init?(map: Map) {
        
        
    }

    public  func mapping(map: Map) {
        
        results <- map["result"]
        
        message <- map["message"]
    }
    
}

public class TimeLine:Mappable {
    
    var replies: [Reply]?
    var postInfo:PostInfo?
    
    public required init?(map: Map) {
        
    }
    
    public  func mapping(map: Map) {
        
        replies <- map["commentinfo"]
        
        postInfo <- map["postinfo"]
        
        
    }
    
    
}
public class PostInfo:Mappable{


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
    var part:String?
    var likeCheck: Int?
    var markcheck: Int?
    var writerState: String?
    public required init?(map: Map) {
        
    }
    
    public  func mapping(map: Map) {
        part <- map["part"]
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
    }
    
}















