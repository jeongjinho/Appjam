//
//  FBLoginNetwork.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 6. 30..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import Foundation
import FBSDKLoginKit

class fbNetworkingVO:NSObject{


    var para: [[String:String]]?
    
    init(inputPara:[[String:String]]?) {
        para = inputPara
    }
}


class FBLoginNetwork: NSObject{

     var completeHandler: ((String) -> Void )?

    var vc: LoginVC?
    var id:  String?

     init(vc:LoginVC) {
        self.vc = vc
       
    }

    func callFaceBook(complete:((String) -> Void)?) {
    
    self.completeHandler = complete
    let fbLoginManager = FBSDKLoginManager()
    fbLoginManager.logIn(withReadPermissions: ["public_profile", "email", "user_friends"], from: vc) { (result, error) in
        if (error == nil) {
            let fbloginresult : FBSDKLoginManagerLoginResult = result!
            if(fbloginresult.grantedPermissions.contains("email"))
            {
                self.getFBUserData()
                
            }
        }
    }
  
}
    func getFBUserData() {
       var datas:[String:AnyObject]
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    //everything works print the user data
                let fbDetails = result as! [String:String]
                    
                    self.id = fbDetails["id"]!
                       self.completeHandler?(self.id!)
                }
            })
            
        }else{
                 self.id = ""
        }
       
    }

}


extension FBLoginNetwork {

    var appDelegate: AppDelegate?{
    
    
    return self.appDelegate
    }
    
    func callFistFaceBook(complete:((String) -> Void)?) {
        
        self.completeHandler = complete
        let fbLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["public_profile", "email", "user_friends"], from: vc) { (result, error) in
            if (error == nil) {
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    self.getFBUserData()
                    
                }
            }
        }
        
    }
    func getFistFBUserData() {
        var datas:[String:AnyObject]
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    //everything works print the user data
                    let fbDetails = result as! [String:String]
                    
                    self.id = fbDetails["id"]!
                    self.completeHandler?(self.id!)
                }
            })
            
        }else{
            self.id = ""
        }
        
    }
    

}
