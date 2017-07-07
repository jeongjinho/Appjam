//
//  LauchNetWork.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 6. 30..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper





class LoginResultModel:Mappable{
    
    var nickName: String?
    var part: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        nickName <- map["nickname"]
        part <- map["part"]
       
        
    }

}


class LoginModel:Mappable{

    var result: LoginResultModel?
    var message: String?

    required init?(map: Map) {
        
    }
    

    func mapping(map: Map) {
        
        result <- map["result"]
        message <- map["message"]
        
        
    }
}


class LoginNetworkModel : DefaultNM{

    func getUserLoginInfo(id: String){
        print("아이디값" + id)
        let URL : String = "\(baseURL)"

        let body : [String:String] = [
            
            
            "id": id,
           
            
        ]
        
        Alamofire.request(URL, method: .post, parameters: body, encoding:JSONEncoding.default, headers:nil).responseObject { (response : DataResponse<LoginModel>) in
            
            switch response.result{
                
            case .success:
                
                guard let boardList = response.result.value else{
                    return
                }
                
                        print(boardList.result?.part)
                  //  print(results)
                    self.view.networkResult(resultData: boardList, code: "1-1")
                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }

            
        }
    }

}
