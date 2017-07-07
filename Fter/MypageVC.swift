//
//  MypageVC.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 7. 3..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import UIKit
import Kingfisher
class MypageVC: UIViewController,NetworkingCallBack,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var statementLabel: UILabel!
    @IBOutlet weak var profilePartLabel: UILabel!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var myContentsTableview: UITableView!
    @IBOutlet weak var profileImageView: UIImageView!
    var mypageInfo: MypageInfo?
    var myContent: [MyContent]?
    
    @IBOutlet weak var menuSegment: UIView!
    @IBOutlet weak var modifyButton: UIButton!
    override func viewWillAppear(_ animated: Bool) {
        let optUserNick = UserDefaults.standard.string(forKey: "nickName")
        guard let usernick = optUserNick else { return  }
        
        
        MypageNM(self).getMypageInfo(nickName: usernick)
        
        let btn = menuSegment.subviews.first as! UIButton
        btn.underLineView(isSelect:true)
        for subView in menuSegment.subviews {
            
            if(subView .isKind(of:UIButton.self) == true){
                
                let btn = subView as! UIButton
                
                if(btn.tag == 0){
                    
                    btn.underLineView(isSelect: true)
                    btn.isSelected = true
                    
                    let optNick = UserDefaults.standard.string(forKey:"nickName")
                    let nickName = OptChange().gsno(optNick)
                    MypageNM(self).getMyWriteContent(nickName:nickName)
                } else{
                    
                    btn.underLineView(isSelect: false)
                    btn.isSelected = false
                }
          
            }
        }
       
        
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
         let btnVM = ButtonViewModel.init(fontColor:AppColors.PupleColor, text: "안녕", borderColor: AppColors.PupleColor, borderWidth: 3, borderRadius:Float(modifyButton.frame.height/2), backgroundColor: .white)
         self.modifyButton.DefaultButton(style:.fillStyle, buttonVM: btnVM)
        myContentsTableview.delegate = self
        myContentsTableview.dataSource = self
        

    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            guard let contents = self.myContent else { return 0 }
        
        return contents.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"myContentsCell", for: indexPath) as! myContentsCell
        
       guard let content = myContent?[indexPath.row] else { return UITableViewCell() }
        
        
        cell.titleLabel.text = content.title
        cell.dateLabel.text =  content.written_time
        
        
        return cell
        
    }
    
    
    @IBAction func touchUpInsideReSetting(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier:"MyPageDetailVC") as! MyPageDetailVC
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func touchUpInsideSegmentButton(_ sender: UIButton) {
        
        let nickName =  OptChange().gsno(UserDefaults.standard.string(forKey:"nickName"))
        for subView in menuSegment.subviews {
            
            if(subView.isKind(of: UIButton.self) == true){
            
                let btn = subView as! UIButton
                btn.isSelected = false
                btn.underLineView(isSelect: false)
                
                if(sender.tag == btn.tag && sender.isSelected != true){

                    if(sender.tag == 0 ){
                        btn.underLineView(isSelect: true)
                     
                     MypageNM(self).getMyWriteContent(nickName:nickName)
                    } else if(sender.tag == 1){
                    
                        
                        btn.underLineView(isSelect: true)
                     
                        MypageNM(self).getMyfavoriteContent(nickName: nickName)
                         
                    
                    }
                    
                    
                }
                
            }
            
            
        }
       
        
        
        
        
    }
    
    
    
    @IBAction func touchUpInsideModifyProfile(_ sender: Any) {
    }

    
    func networkResult(resultData: Any, code: String) {
        
        if(code == "1-1"){
        
            mypageInfo =  resultData as? MypageInfo
            
            guard let profiles = mypageInfo?.profile else { return  }
            
            let url = URL(string:profiles)
            profileImageView.kf.setImage(with: url)
            
            let name = OptChange().gsno(mypageInfo?.nickname)
            let level = OptChange().gino(mypageInfo?.level)
            
            profileName.text = "LV.\(level) \(name)"
            
            let statement = OptChange().gsno(mypageInfo?.statemessage)
            self.statementLabel.text = statement

        
        
        } else if(code == "1-2"){
        
               myContent =  resultData as? [MyContent]
             myContentsTableview.reloadData()
        
            self.myContentsTableview.reloadSections(IndexSet(integersIn: 0...0), with: UITableViewRowAnimation.right)
            
        } else if(code == "1-3"){
        
    
            myContent =  resultData as? [MyContent]
            myContentsTableview.reloadData()
            
            self.myContentsTableview.reloadSections(IndexSet(integersIn: 0...0), with: UITableViewRowAnimation.left)
            
        }
        
        
        
        
        
    }
    func networkFailed() {}
    

   

}
