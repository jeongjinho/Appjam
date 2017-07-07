//
//  ProfileInfoVC.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 6. 30..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import UIKit
import Kingfisher
class ProfileInfoVC: UIViewController {

    @IBOutlet weak var profileImageButton: UIButton!
    @IBOutlet weak var profileState: UILabel!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var InfoView: UIView!
    var ree: CGRect?
    var profileCallbck: ProfileCallBack?
    var isCancel: Bool = false
    var profileString: String?
    var stateString: String?
    var nameString: String?

    
    
    
    
    
    func  getProfileInfoDelegate(callback: ProfileCallBack) {
        
            profileCallbck = callback
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
   
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initialButton()
        self.InfoView.layer.cornerRadius = 20
        ree = InfoView.frame
    
        InfoView.alpha = 0
        InfoView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        
        
        UIView.animate(withDuration: 0.15) {
            
            self.InfoView.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.InfoView.alpha = 1
        }
        
        let url = URL(string:profileString!)
        self.profileImageButton.kf.setBackgroundImage(with:url, for: .normal)
        self.profileState.text = self.stateString
        self.profileNameLabel.text = nameString
    }

    func initialButton()  {
        let cancelBtnVM = ButtonViewModel.init(fontColor:AppColors.GrayColor2, text: "안녕", borderColor: AppColors.GrayColor, borderWidth: 1, borderRadius:Float(cancelButton.frame.height/2), backgroundColor: .white)
        
        cancelButton.DefaultButton(style:.borderStyle, buttonVM: cancelBtnVM)
        
         let followBtnVM = ButtonViewModel.init(fontColor:AppColors.PupleColor, text: "안녕", borderColor: AppColors.PupleColor, borderWidth: 5, borderRadius:Float(cancelButton.frame.height/2), backgroundColor: .white)
        
        followButton.DefaultButton(style: .fillStyle, buttonVM: followBtnVM)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

        @IBAction func touchUpInsideCancelButton(_ sender: UIButton) {
        
        isCancel = true
        InfoView.alpha = 1
   
       // InfoView.frame = ree!
        InfoView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
       
        
        UIView.animate(withDuration: 0.15, animations: {
            
            self.InfoView.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            self.InfoView.alpha = 0
            self.profileCallbck?.cancel(isCancel:self.isCancel)
        }) { (iscoplete) in
            
         
        }
        

       
    }

    
}
