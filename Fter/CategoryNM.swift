//
//  CategoryNM.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 7. 4..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
class CategoryNM: NSObject{
    
    let recentURL = "http://52.78.166.21:3000/main"
    
    var view : NetworkingCallBack
    
    init(_ view:NetworkingCallBack){
        self.view = view
    }
}
class CategoryNetworking:CategoryNM{
    
    
    func getCategoryForRecently(userid:String,category:String,rule:String,tag:Int){
        let url =  "\(recentURL)/\(rule)/\(userid)/\(tag)"
        print(url)
        
        
        let encodingURL   = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        Alamofire.request(encodingURL!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject{
            
            (response : DataResponse<TimeLineVO>) in
            
            switch response.result{
                
            case .success:
                
                guard let boardList = response.result.value else{
                    return
                }
                
                if let results = boardList.results {
                    //    print(boardList.results.c)
                    
                    self.view.networkResult(resultData: results, code: "2-\(tag + 1)")
                }
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }
            
        }
        
    }//getBoardList
    
    
}
