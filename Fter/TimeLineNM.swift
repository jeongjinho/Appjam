//
//  TimeLineNM.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 7. 3..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import Foundation
import  Alamofire
import AlamofireObjectMapper
import SwiftyJSON


class TimeLineNetworking: NSObject{
    
    let recentURL = "http://52.78.166.21:3000/main"
    let postURL =   "http://52.78.166.21:3000/post"
    var view : NetworkingCallBack
    
    init(_ view:NetworkingCallBack){
        self.view = view
    }
}

class MainTimeLineNetwork:TimeLineNetworking{


    func getTimeLineForRecently(userid:String,part:String,rule:String){
        
         print(part)
         let englishpart = ChangePart().getEngPart(part: part)
    
        let url =  "\(recentURL)/\(rule)/\(userid)/\(englishpart)"
        print(url)
        
        let urls = URL(string: url.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)!)!
      
        
               Alamofire.request(urls, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject{
            
            (response : DataResponse<TimeLineVO>) in
            
            switch response.result{
                
            case .success:
                
                guard let boardList = response.result.value else{
                    return
                }
                
                if let results = boardList.results {
                //    print(boardList.results.c)
                    
                    self.view.networkResult(resultData: results, code: "1-1")
                }
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }
            
        }
        
   }//getBoardList
    
    
    func checkLikeButton(nickName: String,postID:Int){
        print("아이디값" + nickName)
        let url : String = "\(recentURL)/postlike/\(nickName)/\(postID)"
       
        let urls = URL(string: url.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)!)!
        Alamofire.request(urls, method: .get, parameters:nil, encoding:JSONEncoding.default, headers:nil).responseObject { (response : DataResponse<CheckVO>) in
            
            switch response.result{
                
            case .success:
                
                guard let likeInfo = response.result.value else{
                    return
                }
                
                print(likeInfo)
                
                self.view.networkResult(resultData: likeInfo, code: "1-3")
                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }
            
            
        }
    }

    
    
    
    func checkFavoriteButton(nickName: String,postID:Int){
        print("아이디값" + nickName)
        let url : String = "\(recentURL)/bookmark/\(nickName)/\(postID)"
        
          let urls = URL(string: url.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)!)!
        
        Alamofire.request(urls, method: .get, parameters:nil, encoding:JSONEncoding.default, headers:nil).responseObject { (response : DataResponse<CheckVO>) in
            
            switch response.result{
                
            case .success:
                
                guard let favoriteInfo = response.result.value else{
                    return
                }
                
              
                
                self.view.networkResult(resultData: favoriteInfo, code: "1-4")
                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }
            
            
        }
    }
    
    
    
    func deleteCheckPost(nickName:String,postID:Int){
        
        
        let url = "\(postURL)/deletecheck"
        
        
        let body : [String:Any] = [
            
            
            "user_nick": nickName,
            "post_id": postID,
        
            
            
        ]
        
        Alamofire.request(url, method: .post, parameters: body, encoding:JSONEncoding.default, headers:nil).responseObject { (response : DataResponse<CheckVO>) in
            
            switch response.result{
                
            case .success:
                
                guard let resultData = response.result.value else{
                    return
                }
                
                print(resultData)
                //  print(results)
                self.view.networkResult(resultData: resultData, code: "1-5")
                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }
            
        }
    }
    
    func deletePost(nickName:String,postID:Int){
        
        
        let url = "\(postURL)/delete"
        
        
        let body : [String:Any] = [
            
            
            "user_nick": nickName,
            "post_id": postID,
            
            
            
            ]
        
        Alamofire.request(url, method: .post, parameters: body, encoding:JSONEncoding.default, headers:nil).responseObject { (response : DataResponse<CheckVO>) in
            
            switch response.result{
                
            case .success:
                
                guard let resultData = response.result.value else{
                    return
                }
                
                print(resultData)
                //  print(results)
                self.view.networkResult(resultData: resultData, code: "1-6")
                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }
            
        }
    }


}


