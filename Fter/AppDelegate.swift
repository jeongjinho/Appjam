//
//  AppDelegate.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 6. 24..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import UIKit
import FBSDKLoginKit
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,NetworkingCallBack {

    var window: UIWindow?
    var getId: String = ""
    func networkFailed() {
    
    }
    
    func networkResult(resultData: Any, code: String) {
        
//        print("성공")
//        let flag = resultData as! String
//            let root = self.window?.rootViewController
//        if(flag == "old"){
//           
//           
//                
//              UserDefaults.standard.setValue(self.getId, forKey:"ID")
//          //  self.window?.rootViewController =
//            
//            
//            let vc = root?.storyboard?.instantiateViewController(withIdentifier:"MainTimeLineVC") as! MainTimeLineVC
//
//            self.window?.rootViewController = vc
//           
//            
//           
//        } else if(flag != "old"){
//            UserDefaults.standard.setValue(self.getId, forKey:"ID")
//          self.window?.rootViewController = root
//            
//        }
//        
//     self.window?.makeKeyAndVisible()
        
    }

 
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        
        if KOSession.isKakaoAccountLoginCallback(url) {
            return KOSession.handleOpen(url)
        }
        
        
        return FBSDKApplicationDelegate.sharedInstance().application(app, open: url as URL!, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        if KOSession.isKakaoAccountLoginCallback(url) {
            return KOSession.handleOpen(url)
        }
        return false
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
            
       //  getId = UserDefaults.standard.object(forKey:"ID") as! String
       // self.window = UIWindow(frame: UIScreen.main.bounds)
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
      
//        if( UserDefaults.standard.object(forKey:"ID") != nil){
//            getId = UserDefaults.standard.object(forKey:"ID") as! String
//            
//        }
//        print(getId)
        
     //   LoginNetworkModel(self).getUserLoginInfo(id:getId)
        return true
        
    }
    
    
   

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
           KOSession.handleDidBecomeActive()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

