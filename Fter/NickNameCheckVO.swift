//
//  NickNameCheckVO.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 6. 30..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import Foundation
import ObjectMapper


class CheckNicknameVO: Mappable{

    var message: String?

    required init?(map: Map) {
        
    }
    
     func mapping(map: Map) {
        message <- map["message"]
    }
}
