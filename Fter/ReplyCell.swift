//
//  ReplyCell.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 6. 27..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import UIKit

class ReplyCell: UITableViewCell,ProfileCallBack {

    @IBOutlet weak var replyerNameButton: UIButton!
    @IBOutlet weak var replyTimeLabel: UILabel!
    @IBOutlet weak var replyLabel: UILabel!
 
    @IBOutlet weak var replyerButton: UIButton!
    
    var replyVM: Reply?
    var oneVM: OneReply?
    var allVM: AllReply?
    var mainVC: MainTimeLineVC?
    var lookVC: LookPostVC?
    var allVC: AllReplyVC?
    func contfigureMainTime(_ model: Reply,vc:MainTimeLineVC )  {
        
        self.replyVM = model
        configureReply()
        //configureReplyTime()
        self.replyTimeLabel.isHidden = true
        configureReplyerName()
        configureReplyerImageButoon()
        self.mainVC = vc
        
        
    }
    
    func contfigureLookPost(_ model: OneReply,vc:LookPostVC )  {
        
        self.oneVM = model
        configureReply()
        //configureReplyTime()
        self.replyTimeLabel.isHidden = true
        configureReplyerName()
        configureReplyerImageButoon()
        self.lookVC = vc
        
        
    }
    
    func contfigureAllReplyVC(_ model: Reply )  {
        
        self.replyVM = model
        configureAllReply()
        configureReplyTime()
        configureReplyerName()
        configureReplyerImageButoon()
        
    }
    
    func contfigureAllReplyOneVC(_ model: OneReply )  {
        
        self.oneVM = model
         oneVCAllReply()
         oneVCReplyTime()
         oneVCReplyerName()
         oneVCReplyerImageButoon()
        
    }
    func contfigureAllReplyVC(_ model: AllReply )  {
        
        self.allVM = model
        oneVCAllReply()
        oneVCReplyTime()
        oneVCReplyerName()
        oneVCReplyerImageButoon()
        
    }

    func configureReplyerName() {
        let vm = ReplyerNameViewModel(indata:replyVM!)
        
        self.replyerNameButton.configureReplyButton(vm!)
    }
    func configureReply() {
        let vm = ReplyViewModel(indata:replyVM!)
        
      
        self.replyLabel.configureReplyLabel(vm!)
    }
    func configureAllReply() {
        let vm = ReplyViewModel(indata:replyVM!)
        
        
        self.replyLabel.configureAllReplyLabel(vm!)
    }
    func configureReplyTime() {
        let vm = ReplyTimeViewModel(indata:replyVM!)
        
        self.replyTimeLabel.configureReplyLabel(vm!)
    }
    func configureReplyerImageButoon() {
        let ss = ReplyerButtonModel(indata:replyVM!, my:self.replyerButton)
        print(ss)
        self.replyerButton.replyerImageButtonConfigure(ss!)
    }
    
    
    func oneVCReplyerName() {
        let vm = ReplyerNameViewModel(indata:oneVM!)
        
        self.replyerNameButton.configureReplyButton(vm!)
    }
    func  oneVCReply() {
        let vm = ReplyViewModel(indata:oneVM!)
        
        
        self.replyLabel.configureReplyLabel(vm!)
    }
    func  oneVCAllReply() {
        let vm = ReplyViewModel(indata:oneVM!)
        
        
        self.replyLabel.configureAllReplyLabel(vm!)
    }
    func  oneVCReplyTime() {
        let vm = ReplyTimeViewModel(indata:oneVM!)
        
        self.replyTimeLabel.configureReplyLabel(vm!)
    }
    func  oneVCReplyerImageButoon() {
        let ss = ReplyerButtonModel(indata:oneVM!, my:self.replyerButton)
        print(ss)
        self.replyerButton.replyerImageButtonConfigure(ss!)
    }
    
//////////////all
    
    

    
    
    
    
    @IBAction func touchUpInsideProfileButton(_ sender: UIButton) {
        
        let profileVC = ProfileInfoVC(nibName:"ProfileInfoVC", bundle:nil)
        
        
        
        if self.mainVC != nil {
            self.mainVC?.addChildViewController(profileVC)
        
            
            let level = OptChange().gino(replyVM?.replyerLevel)
            let name = OptChange().gsno(replyVM?.replyerName)
            profileVC.nameString = "LV.\(level) \(name)"
            print(replyVM?.replyerImage)
            
            profileVC.profileString = replyVM?.replyerImage
            profileVC.stateString = replyVM?.replyerStateMent
           profileVC.view.frame = UIScreen.main.bounds
            self.mainVC?.view.addSubview(profileVC.view)
            
            profileVC.didMove(toParentViewController: self.mainVC)
            profileVC.getProfileInfoDelegate(callback:self)
        }
        else{
            let level = OptChange().gino(allVM?.replyerLevel)
            let name = OptChange().gsno(allVM?.replyerName)
            profileVC.nameString = "LV.\(level) \(name)"
            profileVC.stateString = OptChange().gsno(allVM?.replyerStateMent)
            profileVC.profileString = allVM?.replyerImage
            print(allVM?.replyerImage)
            self.allVC?.addChildViewController(profileVC)
            profileVC.view.frame = UIScreen.main.bounds
            self.allVC?.view.addSubview(profileVC.view)
            profileVC.didMove(toParentViewController: self.allVC)
          
            
        }
       

        profileVC.getProfileInfoDelegate(callback:self)

    }
  
    
    func cancel(isCancel: Bool) {
        if(isCancel == true){
            DispatchQueue.background(delay: 0.2, background:nil, completion: {
                
                if self.mainVC  != nil{
                     self.mainVC?.view.subviews.last?.removeFromSuperview()
                } else if(self.lookVC != nil){
                
                self.lookVC!.view.subviews.last?.removeFromSuperview()
                } else{
                 self.allVC!.view.subviews.last?.removeFromSuperview()
                    
                }
                
               
            })
            
            
            
        }
    }

}



    

