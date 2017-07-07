//
//  LookCell.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 7. 5..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import UIKit
protocol HeightForTextView {
    func heightOfTextView(height: CGFloat)
    
}
class LookCell: UITableViewCell,UITextViewDelegate,NetworkingCallBack {
    var delgate:HeightForTextView?
        var uploadedDelegate: ImageCollectionDelegate?
    var lookVC: LookVC?
    var uploadedImages: [String?]? = []
    var data: [OneReply?]? = []
    @IBOutlet weak var txtHeightconst: NSLayoutConstraint!
    @IBOutlet weak var person2replyLbl: UILabel!
    @IBOutlet weak var person2nameBtn: UIButton!
    @IBOutlet weak var person2ProfileBtn: UIButton!
    @IBOutlet weak var person1replyLbl: UILabel!
    @IBOutlet weak var person1nameBtn: UIButton!
    @IBOutlet weak var person1ProfileBtn: UIButton!
    @IBOutlet weak var userPartLbl: UILabel!
   
    @IBOutlet weak var replycntLbl: UILabel!
    @IBOutlet weak var heartcntLbl: UILabel!
    @IBOutlet weak var replyBtn: UIButton!
    @IBOutlet weak var heartBtn: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var uploadedCollectionView: UICollectionView!
    @IBOutlet weak var categoryBtn: UIButton!
    @IBOutlet weak var contentTxtView: UITextView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
  
    @IBOutlet weak var moreReplyBtn: UIStackView!
  
    @IBOutlet weak var partBtn: UIButton!
    @IBOutlet weak var nameBtn: UIButton!
    @IBOutlet weak var profileBtn: UIButton!
    
    var checkVO : CheckVO?
  
    func configUploadedImage(vc:LookVC,data:[String?])  {
        self.lookVC = vc
        self.uploadedImages = data
        self.uploadedCollectionView.register(UINib(nibName: "AdverTisingCell", bundle: nil), forCellWithReuseIdentifier: "AdverTisingCell")
        
        uploadedDelegate = ImageCollectionDelegate.init(lookVC: self.lookVC!, data:uploadedImages as! [String] )
        
        self.uploadedCollectionView.delegate =  uploadedDelegate
        self.uploadedCollectionView.dataSource = uploadedDelegate

        
    }
    
    
    func configureReplies(data:[OneReply])  {
        self.data = data
        var url1:URL
        var url2:URL
        if(data.count == 2){
           
            url1 = URL(string: ( self.data?[0]?.replyerImage)!)!
            self.person1ProfileBtn.kf.setImage(with: url1, for: .normal)
            self.person1replyLbl.text =  self.data?[0]?.reply
            print(self.data?[0]?.reply)
            self.person1nameBtn.setTitle( self.data?[0]?.replyerName, for: .normal)
            url2 = URL(string: ( self.data?[1]?.replyerImage)!)!
            self.person2ProfileBtn.kf.setImage(with: url2, for: .normal)
            self.person2nameBtn.setTitle( self.data?[1]?.replyerName, for: .normal)
            self.person2replyLbl.text =  self.data?[1]?.reply
            self.person1nameBtn.setNeedsLayout()
            self.person1nameBtn.layoutIfNeeded()
            self.person2nameBtn.setNeedsLayout()
            self.person2nameBtn.layoutIfNeeded()
         

        
            } else  if(data.count == 1){
             url1 = URL(string: (data[0].replyerImage)!)!
            self.person1ProfileBtn.kf.setImage(with: url1, for: .normal)
            self.person1replyLbl.text = data[0].reply
            self.person1nameBtn.setTitle(data[0].replyerName, for: .normal)
                self.person2nameBtn.isHidden = true
                self.person2replyLbl.isHidden = true
                self.person2ProfileBtn.isHidden = true
                self.moreReplyBtn.isHidden = true
            self.person1nameBtn.setNeedsLayout()
            self.person1nameBtn.layoutIfNeeded()

            
        }
        
        
        else{
                self.person1nameBtn.isHidden = true
                self.person1replyLbl.isHidden = true
                self.person1ProfileBtn.isHidden = true
                self.person2nameBtn.isHidden = true
                self.person2replyLbl.isHidden = true
                self.person2ProfileBtn.isHidden = true
                self.moreReplyBtn.isHidden = true

            
        
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentTxtView.delegate = self
        self.textViewDidChange(self.contentTxtView)
        
        
        let btnVM = ButtonViewModel.init(fontColor:AppColors.PupleColor, text: "안녕", borderColor: AppColors.PupleColor, borderWidth: 3, borderRadius:Float(categoryBtn.frame.height/2), backgroundColor: .white)
        
        self.categoryBtn.DefaultButton(style:.fillStyle, buttonVM: btnVM)
        
        let btnVM2 = ButtonViewModel.init(fontColor:AppColors.PupleColor, text: "안녕", borderColor: AppColors.PupleColor, borderWidth: 3, borderRadius:Float(partBtn.frame.height/2), backgroundColor: .white)
        
        self.partBtn.DefaultButton(style:.fillStyle, buttonVM: btnVM2)
        
        
        
              }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        
        let fixedWidth: CGFloat = contentTxtView.frame.size.width
        
        
        let newSize:CGSize = contentTxtView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
       
        let height: CGFloat = newSize.height - txtHeightconst.constant
        
        if(txtHeightconst.constant <= newSize.height){
            
             txtHeightconst.constant   = newSize.height
        
        }  else{
            
            
        }
        
        let contentSize = self.contentTxtView.sizeThatFits(self.contentTxtView.bounds.size)
        var frame = self.contentTxtView.frame
        frame.size.height = contentSize.height
        self.contentTxtView.frame = frame
       
        guard let heightDelegate = self.delgate else {return }
        
        heightDelegate.heightOfTextView(height:height)

    }
    
    @IBAction func touchUpInsideMoreButton(_ sender: Any) {
       let userID = UserDefaults.standard.string(forKey:"nickName")
      
        MainTimeLineNetwork(self).deleteCheckPost(nickName:userID!, postID: (self.lookVC?.selectedPostID)!)
        
    }
    
    @IBAction func touchUpInsideDeleteButton(_ sender: UIButton) {
        let optUserID = UserDefaults.standard.string(forKey:"nickName")
        guard let userID = optUserID else { return  }
        
        
        
        MainTimeLineNetwork(self).deleteCheckPost(nickName:userID, postID: (self.lookVC?.selectedPostID)!)
        
    }
    @IBAction func touchInsideLikeButton(_ sender: UIButton) {
        let userID = UserDefaults.standard.string(forKey:"nickName")
        MainTimeLineNetwork(self).checkLikeButton(nickName: userID!, postID:(self.lookVC?.selectedPostID)!)
        
    }
    
    
    
    
    @IBAction func touchUpInsideFavoriteButton(_ sender: UIButton) {
         let userID = UserDefaults.standard.string(forKey:"nickName")
         MainTimeLineNetwork(self).checkFavoriteButton(nickName: userID!, postID:(self.lookVC?.selectedPostID)!)
    }
    
    func networkFailed() {
        
    }
    
    func networkResult(resultData: Any, code: String) {
        
        checkVO = resultData as! CheckVO

        if(code == "1-3"){
        
                      let num = OptChange().gino(checkVO?.result?[0].likeCount)
            heartcntLbl.text = "\(num)"
            if(checkVO?.message == "like"){
                heartBtn.isSelected = true
            
            }else{
            
                heartBtn.isSelected = false

            }
            
            
            
        
        }
       
        if(code == "1-4"){
            
            
            if(checkVO?.message == "mark"){
                favoriteButton.isSelected = true
                
            }else{
                
                favoriteButton.isSelected = false
                
            }
            
            
        }
        if(code == "1-5"){
            
            
            checkVO = resultData as? CheckVO
            
            
            
            
            if(checkVO?.message == "deny"){
                
                DefaultAlert().basicAlert(title: "더보기", inputMessage:"더보기", viewController: self.lookVC!, alertButtonStyle:.OneButtonStyle, complete: { (
                    ) in
                    //공유하기
                })
                
                
            }else if(checkVO?.message == "ok"){
                
                DefaultAlert().basicAlert(title: "더보기", inputMessage:"더보기", viewController: self.lookVC!, alertButtonStyle:.TwoButtonStyle, complete: { (
                    ) in
                    let userID = UserDefaults.standard.string(forKey:"nickName")
                    MainTimeLineNetwork(self).deletePost(nickName:userID!,postID:(self.lookVC?.selectedPostID!)!)
                    
                })
            }
            
            
            
        }
        
        if(code == "1-6"){
            
            if(checkVO?.message == "success"){
                
                DefaultAlert2().basicAlert(title:"삭제", inputMessage:"삭제되었습니다.", viewController:self.lookVC!, alertButtonStyle:.OneButtonStyle, complete: { (
                    ) in
                    
                    
                    self.lookVC?.navigationController?.popViewController(animated: true)
                })
                
            }


        
        }
        
        
//        if(code == "1-5"){
//
//
//            DefaultAlert().basicAlert(title: "더보기", inputMessage:"더보기", viewController:self.lookVC!, alertButtonStyle: .FourButtonStyle, complete: nil)
//        
//        }
        
    }
    
    
}



