//
//  LoginVC.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 6. 25..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import UIKit
import FBSDKLoginKit
class LoginVC: UIViewController,NetworkingCallBack {
    var loginFlag: String?
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var kakaoButton: UIButton!
    var id: String?
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
            guard let storedID = UserDefaults.standard.string(forKey: "ID")  else { return  }
          print(storedID)
        self.id = storedID
         LoginNetworkModel(self).getUserLoginInfo(id: storedID)
        self.navigationController?.navigationBar.isHidden = true
        initialButton()
        initialNaViBar()
    
        // Do any additional setup after loading the view.
    }

    func initialButton() {
        self.kakaoButton.contentMode = .scaleAspectFill
        self.facebookButton.contentMode = .scaleAspectFill
    }
    
    func initialNaViBar()  {
        
        guard let naviBar = self.navigationController?.navigationBar else { return  }
    
        naviBar.shadowNabiBar()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func loginKakaoTalk(_ sender: UIButton) {
        let kakaoID = KakaoLoginNetworkModel(vc: self).getUserIdForKaKao { (ID) in
          self.id = ID
             LoginNetworkModel(self).getUserLoginInfo(id: ID)
        }
        
        
    
    
    }
    @IBAction func loginFacebook(_ sender: UIButton){
        
          FBLoginNetwork(vc: self).callFaceBook { (data) -> Void in
            print(data)
            self.id = data
            LoginNetworkModel(self).getUserLoginInfo(id: data)
            
        }
        
    }
        func networkFailed() {
        
        print("네트워크실패")
            
        
    }
    
    func networkResult(resultData: Any, code: String) {
        let login = resultData as! LoginModel
        if(login.message == "new"){
            print(login)
            guard let id = self.id else { return  }
            
          
            UserDefaults.standard.set(id, forKey: "ID")
            
            Utility().myLog(object:  UserDefaults.standard.string(forKey: "ID"))
        let profileVC = self.storyboard?.instantiateViewController(withIdentifier:"ProfileVC") as! ProfileVC
        self.navigationController?.pushViewController(profileVC, animated: true)
        
        } else if(login.message == "old"){
               print(login.result?.part)
                UserDefaults.standard.set(self.id, forKey: "ID")
                 UserDefaults.standard.set(login.result?.nickName, forKey: "nickName")
            print()
             UserDefaults.standard.set(login.result?.part, forKey: "part")
               Utility().myLog(object:  UserDefaults.standard.string(forKey: "part"))
            let tabBar = self.storyboard?.instantiateViewController(withIdentifier:"TabBarVC") as! UITabBarController
            
            
            
            self.present(tabBar, animated: true, completion: nil)
        
        }
        
    }
}
