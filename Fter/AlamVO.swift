//
//  AlamVO.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 7. 7..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import Foundation
import ObjectMapper


class AlamVO:Mappable{


    var result:[AlamInfo]?
    var message:String?
    var count: Int?
    
    required init?(map: Map) {}

     func mapping(map: Map) {
        
        result <- map["result"]
        message <- map["message"]
        count <- map["count"]
    }

}




class AlamInfo:Mappable{


    var id: Int?
    var readinfo:Int?
    var writtentime: String?
    var postid:Int?
    var title: String?
    
    
    required init?(map: Map) {
        
        
        
        
        
    }
    
    
     func mapping(map: Map) {
        
        id <- map["id"]
        readinfo <- map["readinfo"]
        writtentime <- map["writtentime"]
        postid <- map["postid"]
        title <- map["title"]
    }

}
