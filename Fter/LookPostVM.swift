//
//  LookPostVM.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 7. 5..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper



class LookPostNetworking: NSObject{
    
    let recentURL = "http://52.78.166.21:3000/post/read"
    
    var view : NetworkingCallBack
    
    init(_ view:NetworkingCallBack){
        self.view = view
    }
}

class LookPostNetwork:LookPostNetworking{
    
    
    func getLookPost(userid:String,postID:Int){
       print(postID)
        
            print(userid)
        
        let body : [String:Any] = [
            
            
            "user_nick": userid,
            "post_id": postID
            
            
            ]
        
        Alamofire.request(recentURL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: nil).responseObject{
            
            (response : DataResponse<OnePostVO>) in
            
            switch response.result{
                
            case .success:
                
                guard let boardList = response.result.value else{
                    return
                }
                
                if let results = boardList.results {
                       print(boardList.results?.replies)
                    
                    self.view.networkResult(resultData: results, code: "1-1")
                }
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }
            
        }
        
    }
    
    
}
func getTimeLine(){
    
    
}

