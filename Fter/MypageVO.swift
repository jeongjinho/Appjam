//
//  MypageVO.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 7. 7..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import Foundation
import ObjectMapper


class MypageVO:Mappable{
    
    var result: MypageInfo?
    var message: String?
    
    required init?(map: Map) {
        
    }
    
    
    func mapping(map: Map) {
        result  <- map["result"]
        message <- map["message"]
        
    }
}

class MypageInfo:Mappable{
    
    var level: Int?
    var profile:String?
    var nickname: String?
    var statemessage: String?
    var part: String?

    
    required init?(map: Map) {
    }
    
    
     func mapping(map: Map) {
        
        level <- map["level"]
        profile <- map["profile"]
        nickname <- map["nickname"]
        statemessage <- map["statemessage"]
        part <- map["part"]
    }
}


/////////쓰여진


class MyContentVO:Mappable{
    
    var result: [MyContent]?
    var message: String?
    
    required init?(map: Map) {
        
    }
    
    
    func mapping(map: Map) {
        result  <- map["result"]
        message <- map["message"]
        
    }
}


class MyContent:Mappable{
    
    var id: Int?
    var written_time: String?
    var title: String?
    
    
    required init?(map: Map) {
    }
    
    
    func mapping(map: Map) {
        
        id <- map["level"]
        written_time <- map["written_time"]
        title <- map["title"]
    }
}




