//
//  PostingNetworkNM.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 7. 6..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import UIKit
import ObjectMapper
class PostingInfo:Mappable{
    
    var nickName: String?
    var part: String?
    var level: Int?
    var profile: String?

    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        nickName <- map["nickname"]
        part <- map["part"]
        level <- map["level"]
        profile <- map["profile"]
        
        
    }
    
}

class PostingInfoVO:Mappable{
    
    var result: [PostingInfo]?
    var message: String?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        result <- map["result"]
        message <- map["message"]
       
        
        
    }
    
}



class PostingNetworking: NSObject{
    let postingInfoURL = "http://52.78.166.21:3000/post/write"
   
    let postingURL = "http://52.78.166.21:3000/post/add"
    
    var view : NetworkingCallBack
    
    init(_ view:NetworkingCallBack){
        self.view = view
    }
}

class PostingNM:PostingNetworking{

    
    
    func postingMyCotents(categoty: String, part: String ,title: String, contents:String,usernick: String, images: [UIImage]) {
        var uploadImage:[Data] = [Data]()
        for image in images {
            
            let resizingImg = ImageResizing().resizeImage(image: image, targetSize: CGSize(width:200, height: 200))
            
            let imgData = UIImageJPEGRepresentation(resizingImg,1)
            uploadImage.append(imgData!)
        }
         var engPart = ChangePart().getEngPart(part: part)
         var engCategoty = ChangeCategory().getNumberCategory(category: categoty)
        
        var koreanCategory =  "\(engCategoty)"
        let category = koreanCategory.data(using: String.Encoding.utf8)
        let part = engPart.data(using: String.Encoding.utf8)
        let title = title.data(using: String.Encoding.utf8)
        let contents = contents.data(using: String.Encoding.utf8)
        let usernick = usernick.data(using: String.Encoding.utf8)
        
        Alamofire.upload(multipartFormData : { multipartFormData in
            
            //멀티파트를 이용해 데이터를 담습니다
            for data in uploadImage{
            multipartFormData.append(data, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
            
            }
            
            
            multipartFormData.append(category!, withName: "category")
            multipartFormData.append(contents!, withName: "contents")
            multipartFormData.append(part!, withName: "part")
            multipartFormData.append(title!, withName: "title")
               multipartFormData.append(usernick!, withName: "user_nick")
            
        },
                         
                         to: postingURL,
                         encodingCompletion: { encodingResult in
                            
                            switch encodingResult{
                            case .success(let upload, _, _):
                                upload.responseData { res in
                                    switch res.result {
                                    case .success:
                                        
                                        
                                        DispatchQueue.main.async(execute: {
                                            self.view.networkResult(resultData: "ok", code: "1-2")
                                        })
                                    case .failure(let err):
                                        print("upload Error : \(err)")
                                        DispatchQueue.main.async(execute: {
                                            self.view.networkFailed()
                                        })
                                    }
                                }
                            case .failure(let err):
                                print("network Error : \(err)")
                                self.view.networkFailed()
                            }//switch
        }
            
        )//Alamofire.uploa

        
    }
    
    
    func getUserPostingInfo(nickName: String){
        print("아이디값" + nickName)
        let url : String = "\(postingInfoURL)/\(nickName)"
        
        
        let urls = URL(string: url.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)!)!
        
        Alamofire.request(urls, method: .get, parameters:nil, encoding:JSONEncoding.default, headers:nil).responseObject { (response : DataResponse<PostingInfoVO>) in
            
            switch response.result{
                
            case .success:
                
                guard let profileInfo = response.result.value else{
                    return
                }
                
                print(profileInfo)
                
                self.view.networkResult(resultData: profileInfo.result, code: "1-1")
                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }
            
            
        }
    }

    
    
    
    
    
  

}
