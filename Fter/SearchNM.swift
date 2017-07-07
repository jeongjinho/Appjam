//
//  SearchNM.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 7. 7..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper



class SearchNetworking:NSObject{


    
    let searchURL = "http://52.78.166.21:3000/main/find"
    
    var view : NetworkingCallBack
    
    init(_ view:NetworkingCallBack){
        self.view = view
    }
}


class SearchNM:SearchNetworking{


    
    func searchKeyword(part:String,content:String){
        
        
        let url = searchURL
        
         let engPart = ChangePart().getEngPart(part: part)
        let body : [String:Any] = [
            
            "part": engPart,
            "search_content": content
           
          
            
            
        ]
        
       
        
        Alamofire.request(url, method: .post, parameters: body, encoding:JSONEncoding.default, headers:nil).responseObject { (response : DataResponse<SearchsVO>) in
            
            switch response.result{
                
            case .success:
                
                guard let results = response.result.value else{
                    return
                }
                
                print(results)
                //  print(results)
                self.view.networkResult(resultData: results.result, code: "1-1")
                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }
            
        }
    }









}
