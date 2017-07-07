//
//  NetworkingModel.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 6. 26..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//



import Foundation
import Alamofire
import AlamofireObjectMapper




class LoginNM: DefaultNM{
    

    var checkNickame = "nickcheck"
    var signUp = "profile"
    
    
    
    func checkNicknameNetworking(nickName:String){
        let url = "\(self.baseURL + self.checkNickame)"
        print(url)
        
        let body : [String:String] = [
            
            
            "nickname": nickName,
            
            
            ]
        Alamofire.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: nil).responseObject { (response:DataResponse<CheckNicknameVO>) in
         
            
            switch response.result{
                
            case .success:
                
                guard let result = response.result.value else{
                    return
                }
                
                if let message = result.message {
                    print("!@#!@#")
                    self.view.networkResult(resultData: message, code: "1-1")
                }
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }
            
            
        }

            
            
           
        }
    
    
    func signUpForUserInfo(id:String, nickname:String, part:String,statemessage:String,imageData:UIImage){
        
   
         let resizingImg = ImageResizing().resizeImage(image: imageData, targetSize: CGSize(width:200, height: 200))
         let img = UIImageJPEGRepresentation(resizingImg,0.5)
        
        let englishpart = ChangePart().getEngPart(part: part)
        
        Utility().myLog(object: id)
        Utility().myLog(object: nickname)
        Utility().myLog(object: englishpart)
        Utility().myLog(object: statemessage)
        
       // let imag = UIImage(named:"checkbox")!
        
            let URLs = "http://52.78.166.21:3000/login/profile"
                let id = id.data(using: String.Encoding.utf8)
            let nickname = nickname.data(using: String.Encoding.utf8)
            let part = englishpart.data(using: String.Encoding.utf8)
             let state = statemessage.data(using: String.Encoding.utf8)
        
        Utility().myLog(object: id)
        Utility().myLog(object: nickname)
        Utility().myLog(object: englishpart)
        Utility().myLog(object: statemessage)
            if URLs == nil{
                
            }else{
                
                Alamofire.upload(multipartFormData : { multipartFormData in
                    
                    //멀티파트를 이용해 데이터를 담습니다
                    multipartFormData.append(img!, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
                    multipartFormData.append(id!, withName: "id")
                    multipartFormData.append(nickname!, withName: "nickname")
                    multipartFormData.append(part!, withName: "part")
                       multipartFormData.append(state!, withName: "statemessage")
                    
                },
                                 
                                 to: URLs,
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
                    
                )//Alamofire.upload
                
            }
        }

    
    
    

    
    
    
    
    }

    






