//
//  ReplyWindow.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 6. 29..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import Foundation
import UIKit

class ReplyWindow: UIView{

    var replyWindowCallbck: ReplyWindowCallBack?
    @IBOutlet weak var inputTextView: UITextField!
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "ReplyWindow", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    
    }
    func  getProfileInfoDelegate(callback: ReplyWindowCallBack) {
        
        replyWindowCallbck = callback
        
        }

    
    
    @IBAction func touchUpInsideVariableButton(_ sender: UIButton) {
        if sender.isSelected {
            
         sender.isSelected = false
        } else{
        sender.isSelected = true
        }
        
        self.replyWindowCallbck?.replyWindowDidSelectedUseful(result: sender.isSelected)
        
    }
    
    @IBAction func touchUpInsideSendButton(_ sender: UIButton) {
        
        self.replyWindowCallbck?.sendReply(content:self.inputTextView.text!)
        self.replyWindowCallbck?.resignWindowKeyBoard(textfield: self.inputTextView)
        self.inputTextView.text = ""
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    func setDelegate(vc:LookPostVC)  {
        
        self.inputTextView.delegate = vc
    }
    func getDelegate(vc:LookVC)  {
        
        self.inputTextView.delegate = vc
        self.replyWindowCallbck = vc
    }
    func setDelegateAllReplyVC(vc: AllReplyVC)  {
        
        self.inputTextView.delegate = vc
         self.replyWindowCallbck = vc
    }

    

}
