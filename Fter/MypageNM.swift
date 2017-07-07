//
//  MypageNM.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 7. 7..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class MyPageNetworking: NSObject{
    
    let mypageBaseURL = "http://52.78.166.21:3000/mypage"
    
    var view : NetworkingCallBack
    
    init(_ view:NetworkingCallBack){
        self.view = view
    }
}


class MypageNM: MyPageNetworking{

    func getMypageInfo(nickName:String){
        
        
        
        
        let url = "\(mypageBaseURL)/\(nickName)"
        
        let urls = URL(string: url.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)!)!
        
        
        
        Alamofire.request(urls, method: .get, parameters: nil, encoding:JSONEncoding.default, headers:nil).responseObject { (response : DataResponse<MypageVO>) in
            
            switch response.result{
                
            case .success:
                
                guard let mypageVO = response.result.value else{
                    return
                }
                
                print(mypageVO)
                print(mypageVO.result)
                self.view.networkResult(resultData:mypageVO.result , code: "1-1")
                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }
            
        }
    }


    
    func getMyWriteContent(nickName:String){
        
        let url = "\(mypageBaseURL)/write/\(nickName)"
        
        let urls = URL(string: url.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)!)!
        
        Alamofire.request(urls, method: .get, parameters: nil, encoding:JSONEncoding.default, headers:nil).responseObject { (response : DataResponse<MyContentVO>) in
            
            switch response.result{
                
            case .success:
                
                guard let mypageVO = response.result.value else{
                    return
                }
                
                print(mypageVO)
                print(mypageVO.result)
                self.view.networkResult(resultData:mypageVO.result , code: "1-2")
                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }
            
        }
    }


        

    func getMyfavoriteContent(nickName:String){
        
        let url = "\(mypageBaseURL)/like/\(nickName)"
        
         let urls = URL(string: url.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)!)!
        
        
        
        Alamofire.request(urls, method: .get, parameters: nil, encoding:JSONEncoding.default, headers:nil).responseObject { (response : DataResponse<MyContentVO>) in
            
            switch response.result{
                
            case .success:
                
                guard let mypageVO = response.result.value else{
                    return
                }
                
                print(mypageVO)
                print(mypageVO.result)
                self.view.networkResult(resultData:mypageVO.result , code: "1-3")
                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }
            
        }
    }
    func resettingProfile(userNick:String, nickname:String, part:String,statemessage:String,image:UIImage){
        
        let url = "\(mypageBaseURL)/edit"

        let resizingImg = ImageResizing().resizeImage(image: image, targetSize: CGSize(width:200, height: 200))
        let img = UIImageJPEGRepresentation(resizingImg,1)
        
        let englishpart = ChangePart().getEngPart(part: part)
        
        Utility().myLog(object: userNick)
        Utility().myLog(object: nickname)
        Utility().myLog(object: englishpart)
        Utility().myLog(object: statemessage)
        
        let imag = UIImage(named:"checkbox")!
        
        let URLs = "http://52.78.166.21:3000/login/profile"
        let userNick = userNick.data(using: String.Encoding.utf8)
        let nickname = nickname.data(using: String.Encoding.utf8)
        let part = englishpart.data(using: String.Encoding.utf8)
        let statemessage = statemessage.data(using: String.Encoding.utf8)
        
        if URLs == nil{
            
        }else{
            
            Alamofire.upload(multipartFormData : { multipartFormData in
                
                //멀티파트를 이용해 데이터를 담습니다
                multipartFormData.append(img!, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
                multipartFormData.append(userNick!, withName: "user_nick")
                multipartFormData.append(nickname!, withName: "nickname")
                multipartFormData.append(part!, withName: "part")
                multipartFormData.append(statemessage!, withName: "statemessage")
                
            },
                             
                             to: url,
                             encodingCompletion: { encodingResult in
                                
                                switch encodingResult{
                                case .success(let upload, _, _):
                                    upload.responseData { res in
                                        switch res.result {
                                        case .success:
                                            
                                            
                                            DispatchQueue.main.async(execute: {
                                                self.view.networkResult(resultData: "ok", code: "1-4")
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
                
            )//Alamofire.upload
            
        }
    }

    
    func recheckNickname(oldname:String,newnick:String){
         let url = "\(mypageBaseURL)/nickcheck"
        print(url)
        
        let body : [String:String] = [
            
            
            "oldnick": oldname,
            "newnick": newnick
            
            ]
        Alamofire.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: nil).responseObject { (response:DataResponse<CheckVO>) in
            
            
            switch response.result{
                
            case .success:
                
                guard let result = response.result.value else{
                    return
                }
                
                if let message = result.message {
                    print("!@#!@#")
                    self.view.networkResult(resultData: message, code: "1-5")
                }
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }
            
            
        }
        
        
        
        
    }
    

}
