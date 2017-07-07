//
//  AlamNM.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 7. 7..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
class AlamNetworking: NSObject{
    
    let alamURL = "http://52.78.166.21:3000/alarm"
    
    var view : NetworkingCallBack
    
    init(_ view:NetworkingCallBack){
        self.view = view
    }
}


class AlamNM:AlamNetworking{




    func getAlamInfo(nickName: String){
        print("아이디값" + nickName)
        let url : String = "\(alamURL)/\(nickName)"
        
        
        let urls = URL(string: url.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)!)!
        
        Alamofire.request(urls, method: .get, parameters:nil, encoding:JSONEncoding.default, headers:nil).responseObject { (response : DataResponse<AlamVO>) in
            
            switch response.result{
                
            case .success:
                
                guard let alamInfo = response.result.value else{
                    return
                }
                
                print(alamInfo)
                
                self.view.networkResult(resultData: alamInfo.result, code: "1-1")
                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }
            
            
        }
    }
    



}






