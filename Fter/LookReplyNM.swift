//
//  LookReplyNM.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 7. 6..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class LookNetworking: NSObject{
    
    let sendReply = "http://52.78.166.21:3000/comment"
    
    var view : NetworkingCallBack
    
    init(_ view:NetworkingCallBack){
        self.view = view
    }
}
class ReplyWindowVO:Mappable{
    
    
    var message: String?
    
    required init?(map: Map) {
        
    }
    
    
    func mapping(map: Map) {
        
               message <- map["message"]
        
            }
}
class LookNetwork:LookNetworking{
    
    
    func addReply(nickName:String,postID:Int,useful:Int,content:String){
        

        let url = "\(sendReply)/add"
        
    
        let body : [String:Any] = [
            
            
            "user_nick": nickName,
             "post_id": postID,
             "useful": useful,
          
            "content":  content
            
            
            ]
        
        Alamofire.request(url, method: .post, parameters: body, encoding:JSONEncoding.default, headers:nil).responseObject { (response : DataResponse<ReplyWindowVO>) in
            
            switch response.result{
                
            case .success:
                
                guard let message = response.result.value else{
                    return
                }
                
                print(message)
                //  print(results)
                self.view.networkResult(resultData: message, code: "1-2")
                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }

        }
    }
    
    
    func recentlyAllReply(postID:Int){
  
        let url = "\(sendReply)/\(postID)"
                Alamofire.request(url, method: .get, parameters: nil, encoding:JSONEncoding.default, headers:nil).responseObject { (response : DataResponse<AllReplyVO>) in
            
            switch response.result{
                
            case .success:
                
                guard let replies = response.result.value else{
                    return
                }
                
                print(replies)
                 print(replies.result)
                self.view.networkResult(resultData:replies.result , code: "1-1")
                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }
            
        }
    }

    
    func usefulAllReply(postID:Int){
        
        
        let url = "\(sendReply)/useful/\(postID)"
        
        
        
        
        Alamofire.request(url, method: .get, parameters: nil, encoding:JSONEncoding.default, headers:nil).responseObject { (response : DataResponse<AllReplyVO>) in
            
            switch response.result{
                
            case .success:
                
                guard let replies = response.result.value else{
                    return
                }
                
                print(replies)
                print(replies.result)
                self.view.networkResult(resultData:replies.result , code: "1-1")
                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }
            
        }
    }

    
}
    
