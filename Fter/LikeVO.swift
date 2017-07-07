//
//  LikeVO.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 7. 7..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import Foundation
import ObjectMapper

class CheckVO: Mappable{

    var result : [like]?
    var message: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        result <- map["result"]
        message <- map["message"]
    }


}

class like: Mappable{
    
    
    var likeCount: Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        likeCount <- map["likecount"]
        
}

    class FavoritesVO: Mappable{
        
   
        var message: String?
        
        required init?(map: Map) {
            
        }
        
        func mapping(map: Map) {
            
        message <- map["message"]
        }
        
        
    }
    
    
    
}


