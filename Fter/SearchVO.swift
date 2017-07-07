//
//  SearchVO.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 7. 7..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import Foundation
import ObjectMapper





class SearchsVO: Mappable{
    
    var result: [SearchVO]?
    var message: String?
   
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        result <- map["result"]
        message <- map["message"]
        
    }
}



class SearchVO: Mappable{

    var usernick: String?
    var title: String?
    var id: Int?
    
    required init?(map: Map) {}
    
     func mapping(map: Map) {
        
       usernick <- map["user_nick"]
         title <- map["title"]
        id <- map["id"]
    }
}
