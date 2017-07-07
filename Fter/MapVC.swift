//
//  MapVC.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 6. 27..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import UIKit

class MapVC: UIViewController {

    
    var  mapDelegate: MapCallBack?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
    }
    
    
   func getMapDelegate(callback:MapCallBack){
    
        mapDelegate = callback
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func touchUpInsidePartButton(_ sender: UIButton) {
        
        
//       let vc = self.storyboard?.instantiateViewController(withIdentifier:"MainTimeLineVC") as! MainTimeLineVC
      //  let vc = self.parent as! MainTimeLineVC
        
        var storePart : String = UserDefaults.standard.string(forKey: "nickName")!
        switch  sender.tag {
        case 0:
            
            storePart = "경영마케팅"
            break
        case 1:
              storePart = "디자인"
            break
        case 2:
             storePart = "개발"
            break
        default:
            break
        }
        
        
        self.mapDelegate?.getPart(part: storePart)
            self.dismiss(animated: true) { 
                
              //  vc.tabBarController?.tabBar.isHidden = false
        }
        
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


