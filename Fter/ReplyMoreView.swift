//
//  ReplyMoreView.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 6. 28..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import UIKit

class ReplyMoreView: UIView {

    var fromVC: LookPostVC?
     var lookVC: LookVC?
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        let layer = CALayer()
        layer.frame = CGRect(x: 0.0, y: 0, width: self.frame.size.width, height: 1.0)
        
        layer.backgroundColor = AppColors.GrayColor2.cgColor
        
        self.layer.addSublayer(layer)
    }
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "ReplyMoreView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    func setFromVC(vc:LookPostVC){
        
        self.fromVC = vc
    
    }
    func setFromVC(lookVC:LookVC){
        
        self.lookVC = lookVC
        
    }

    
    @IBAction func touchUpInsideAllReplyButton(_ sender: UIButton) {
        
        
        
        
//        let toVC = self.fromVC?.storyboard?.instantiateViewController(withIdentifier:"AllReplyVC") as! AllReplyVC
//        self.fromVC?.navigationController?.pushViewController(toVC, animated:true)
//        guard let replies = self.fromVC?.postData?.replies
//            else { return  }
       // toVC.replies = replies
    }
    
   
    

}
