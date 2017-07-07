//
//  KakaoLoginNetwork.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 7. 3..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import Foundation
import UIKit

class KakaoLoginNetworkModel:NSObject{
    var vc: LoginVC?
    var id:  String?
    
    init(vc:LoginVC) {
        self.vc = vc
    }
    func  getUserIdForKaKao(complete:((String) -> Void)?) -> String {
        var  idVale:String = ""
        let session = KOSession.shared()
        if let s = session {
            
            if s.isOpen() {
                s.close()
            }
            else {
                
                s.open(completionHandler: { (err) in
                    print(err)
                    print("실패")
                    if(err == nil){
                        
                        KOSessionTask.meTask(completionHandler: { (result, err) in
                            let userInfo:KOUser = result as!KOUser
                            DispatchQueue.main.async {
                                
                                if(userInfo != nil){
                                    let userID = userInfo.id.stringValue
                                    complete!(userID)
                                    Utility().myLog(object:userID)
                                }
                            }
                           
                        })
                    } else{
                        DefaultAlert().basicAlert(title:"오류", inputMessage:"정보를 받아오지 못했습니다.", viewController: self.vc!, alertButtonStyle:.OneButtonStyle, complete: nil)
                    }
                        }, authParams:nil, authTypes: [NSNumber(value: KOAuthType.talk.rawValue)])
            }
        }
        return idVale
    }
    

    
    
}


