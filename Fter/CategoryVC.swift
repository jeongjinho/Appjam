//
//  CategoryVC.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 6. 29..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import UIKit

class CategoryVC: UIViewController,NetworkingCallBack{

    @IBOutlet weak var categoryTableView: UITableView!
    @IBOutlet weak var adImageView: UIView!
    
    var categoryData = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
         self.tabBarController?.tabBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowNabiBar()
        
      
        
        
      
        
       
        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func touchUpInsideCategory(_ sender: UIButton) {
        
        
        
      let nickname = UserDefaults.standard.string(forKey:"nickName")
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier:"MainTimeLineVC") as! MainTimeLineVC
         vc.categoryTag = sender.tag + 1
       
        
        switch sender.tag {
        case  0 :
             vc.categoryName = "고민이에요"
           
            
             break
        case  1 :
            
            vc.categoryName = "궁금해요"

            break
        case  2 :
             vc.categoryName = "일상이야기"
            break
        case  3 :
               vc.categoryName = "함께해요"
            break
        default:
            break
        }
         self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    func networkResult(resultData: Any, code: String) {
        
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier:"CategoryTimeVC") as! CategoryTimeVC
        
   //   self.navigationController?.pushViewController(vc, animated: true)
        switch code {
        case  "1-1":
            
            
            break
        case  "1-2":
            break
        case  "1-3":
            break
        case  "1-4":
            break
        default:
            break
        }
        
        
    }
    
    func networkFailed() {
        
    }
}
