
//
//  CustomTimeLineCell.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 6. 26..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import UIKit
import Kingfisher
class CustomTimeLineCell: UITableViewCell,UITableViewDataSource,UITableViewDelegate,ProfileCallBack,NetworkingCallBack{

  
    
 
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var likebutton: UIButton!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var textContraint: NSLayoutConstraint!
 //   @IBOutlet weak var textConstraint: NSLayoutConstraint!
    @IBOutlet weak var likeButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var ImageCollecHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var feelButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var repliesTableView: UITableView!
    @IBOutlet weak var replyNumberLabel: UILabel!
    @IBOutlet weak var likeNumberLabel: UILabel!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var postTextView: UILabel!
    @IBOutlet weak var PostTitleLabel: UILabel!
    @IBOutlet weak var writtenDateLabel: UILabel!
    @IBOutlet weak var writerNameButton: UIButton!
    @IBOutlet weak var writerLevelButton: UIButton!
    @IBOutlet weak var writerImageButton: UIButton!
    @IBOutlet weak var writerPartButton: UIButton!
    @IBOutlet weak var feelButton: UIButton!
    @IBOutlet weak var partButton: UIButton!
    var vc: MainTimeLineVC?
    var onePostVC : LookPostVC?
    var timeLineVM: TimeLine?
    var onePostVM: OnePost?
    var replies: [Reply?] = []
    var oneReplies: [OneReply?] = []
    var uploadedDelegate: ImageCollectionDelegate?
    // 더보기삽입 본문에
    var moreText = "...더보기"
    var Point :CGFloat?
    var uploadedImages: [String?] = []
      var checkVO : CheckVO?
//    var repliesOpt : [Reply] 
    var postId: Int?
    var seletedIndex: Int?
    func contfigure(_ model: TimeLine, vc:MainTimeLineVC)  {
     
        self.timeLineVM = model
        self.vc = vc
        configureWriterImageView()
        configureWriterLevelView()
        configureWriterNameView()
        configureWriterDateView()
        configurePostTitleView()
        configurePostTextView()
        configureLikeNumberView()
        configurereplyNumberView()
       print(model.replies)
        self.replies = model.replies!
        self.repliesTableView.delegate = self
        self.repliesTableView.dataSource = self
   //    self.repliesTableView.rowHeight = UITableViewAutomaticDimension;
        self.repliesTableView.estimatedRowHeight = 50.0;
        
        
         self.imageCollectionView.register(UINib(nibName: "AdverTisingCell", bundle: nil), forCellWithReuseIdentifier: "AdverTisingCell")
        
   
        
        for images in (timeLineVM?.postInfo?.uploadedImage)! {
            if  (images != nil){
            
                uploadedImages.append(images)
            }

        }
            
            
    
        
      uploadedDelegate = ImageCollectionDelegate.init(sc: self.vc!, data:uploadedImages as! [String] )
        
        self.imageCollectionView.delegate =  uploadedDelegate
        self.imageCollectionView.dataSource = uploadedDelegate
        
        self.postTextView.isUserInteractionEnabled = true
    
        
        let str = postTextView!.text!
        let range = (str as NSString).range(of: moreText, options: .backwards)
        let attributedStr = NSMutableAttributedString(string: str)
        attributedStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.blue, range: range)
        postTextView.attributedText = attributedStr
     
        
        if(self.uploadedImages.count == 0){
        
        
            self.heightConstraint.constant  = 0
        }
        
        ////////////////
      
         self.feelButtonHeightConstraint.constant = 0
        self.partButton.isHidden = true
        self.feelButton.isHidden = true
        if(self.timeLineVM?.postInfo?.uploadedImage?.count == 0){
        
         self.ImageCollecHeightConstraint.constant = 0
           //  self.likeButtonTopConstraint.constant = 0
            
        }
        let cnt: CGFloat = CGFloat((self.timeLineVM?.replies?.count)!)

        if(self.timeLineVM?.replies?.count == 0){
               self.repliesTableView.translatesAutoresizingMaskIntoConstraints = false
    self.repliesTableView.isHidden = true
              self.repliesTableView.frame = CGRect(x:self.repliesTableView.frame.origin.x, y: self.repliesTableView.frame.origin.y, width: self.repliesTableView.frame.size.width, height: 0)
           //    repliesConstraint.constant = 0
        } else{
            self.repliesTableView.isHidden = false

            
          //  self.repliesTableView.translatesAutoresizingMaskIntoConstraints = true
            print(self.repliesTableView.frame.size.height)
            
//            self.repliesTableView.frame = CGRect(x:self.repliesTableView.frame.origin.x, y: self.repliesTableView.frame.origin.y, width: self.repliesTableView.frame.size.width, height: cnt*50)
        }
    //   self.repliesTableView.reloadData()
        
  //     self.repliesTableView.estimatedRowHeight = 60
  
        
    }
    
    
    func contfigureOnePost(_ model: OnePost, vc:LookPostVC)  {
  
        self.onePostVM = model
        self.onePostVC = vc
        onePostWriterImageView()
        onePostWriterLevelView()
        onePostWriterNameView()
       onePostWriterDateView()
        onePostPostTitleView()
        onePostPostTextView()
        onePostLikeNumberView()
        onePostreplyNumberView()
        
        
        print(model.replies)
        self.oneReplies = model.replies!
       self.repliesTableView.delegate = self
        self.repliesTableView.dataSource = self
      //  self.repliesTableView.rowHeight = UITableViewAutomaticDimension;
        self.repliesTableView.estimatedRowHeight = 80.0;
          self.repliesTableView.estimatedSectionFooterHeight = 37
        
        self.imageCollectionView.register(UINib(nibName: "AdverTisingCell", bundle: nil), forCellWithReuseIdentifier: "AdverTisingCell")
        
    
        
        for images in (onePostVM?.postInfo?.uploadedImage)! {
            if  (images != nil){
                
                uploadedImages.append(images)
            }
            
        }
        print(uploadedImages)
        uploadedDelegate = ImageCollectionDelegate.init(lookPostVC: self.onePostVC!, data:uploadedImages as! [String] )
        self.imageCollectionView.delegate =  uploadedDelegate
        self.imageCollectionView.dataSource = uploadedDelegate
        
        
        let btnVM = ButtonViewModel.init(fontColor:AppColors.PupleColor, text: "안녕", borderColor: AppColors.PupleColor, borderWidth: 3, borderRadius:Float(feelButton.frame.height/2), backgroundColor: .white)
        
        self.feelButton.DefaultButton(style:.fillStyle, buttonVM: btnVM)
        
        
        
        self.partButton.DefaultButton(style:.fillStyle, buttonVM: btnVM)
    
        if(self.onePostVM?.postInfo?.uploadedImage?.count == 0){
        
            self.ImageCollecHeightConstraint.constant = 0
            self.likeButtonTopConstraint.constant = 0
        }
        
       //  self.onePostVC?.onePostTableView.sizeToFit()
        let contentSize = postTextView.sizeThatFits(postTextView.bounds.size)
       // self.translatesAutoresizingMaskIntoConstraints = true
     //   self.textContraint.constant = 200
      
       // self.onePostVC?.onePostTableView.estimatedRowHeight = 400
      //  self.repliesTableView.reloadData()
    }

    
    
    func configureWriterImageView() {
        
       
        
      let vm = TimeLineWriterButtonViewModel(indata:timeLineVM!, my:self.writerImageButton)
     //   self.timeLineVM.
        if(vm != nil){
        self.writerImageButton.configureTimeLineButtonImage(vm!)
        
        } else{
        
            self.writerImageButton.setImage(UIImage(named:"DefaultProfile"), for: .normal)
        }
        
        
    }
    func configureWriterLevelView() {
      
        let vm = TimeLineLevelViewModel(indata:timeLineVM!)
          print(vm)
        self.writerLevelButton.configureTimeLineButton(vm!)
    }

    func configureWriterNameView() {
        let vm = TimeLineNameViewModel(indata:timeLineVM!)
        
        self.writerNameButton.configureTimeLineButton(vm!)
    }
    
    func configureWriterDateView() {
        let vm = TimeLineTimeViewModel(indata:timeLineVM!)
        
        self.writtenDateLabel.configureTimeLineLabel(vm!)
    }
    
    func configurePostTitleView() {
        let vm = TimeLineTitleViewModel(indata:timeLineVM!)
        
        self.PostTitleLabel.configureTimeLineLabel(vm!)
    }
    
    func configurePostTextView() {
        let vm = TimeLinePostViewModel(indata:timeLineVM!)
        
        self.postTextView.configurePostTextView(vm!)
    }
    
    func configureLikeNumberView() {
        let vm = TimeLineLikeNumberViewModel(indata:timeLineVM!)
        
        self.likeNumberLabel.configureTimeLineLabel(vm!)
    }
    
    func configurereplyNumberView() {
        let vm = TimeLineReplyNumberViewModel(indata:timeLineVM!)
        
        self.replyNumberLabel.configureTimeLineLabel(vm!)
    }
    func configureLikeButtonView() {
       let vm = TimeLineLikeOrCotentsButtonViewModel(indata:timeLineVM!, my:self.feelButton)
        
        self.feelButton.configureTimeLineButtonImage(vm!)
    }
    
    ///////////////////////
    func onePostWriterImageView() {
        
        
        
        let vm = TimeLineWriterButtonViewModel(postData:onePostVM!, my:self.writerImageButton)
        //   self.timeLineVM.
        self.writerImageButton.configureTimeLineButtonImage(vm!)
    }
    func onePostWriterLevelView() {
        let vm = TimeLineLevelViewModel(postData:onePostVM!)
        
        self.writerLevelButton.configureTimeLineButton(vm!)
    }
    
    func onePostWriterNameView() {
        let vm = TimeLineNameViewModel(postData:onePostVM!)
        
        self.writerNameButton.configureTimeLineButton(vm!)
    }
    
    func onePostWriterDateView() {
        let vm = TimeLineTimeViewModel(postData:onePostVM!)
        
        self.writtenDateLabel.configureTimeLineLabel(vm!)
    }
    
    func onePostPostTitleView() {
        let vm = TimeLineTitleViewModel(postData:onePostVM!)
        print(onePostVM?.postInfo?.writerName)
        self.PostTitleLabel.configureTimeLineLabel(vm!)
    }
    
    func onePostPostTextView() {
        let vm = TimeLinePostViewModel(postData:onePostVM!)
        
        self.postTextView.onePostTextView(vm!)
    }
    
    func onePostLikeNumberView() {
        let vm = TimeLineLikeNumberViewModel(postData:onePostVM!)
        
        self.likeNumberLabel.configureTimeLineLabel(vm!)
    }
    
    func onePostreplyNumberView() {
        let vm = TimeLineReplyNumberViewModel(postData:onePostVM!)
        
        self.replyNumberLabel.configureTimeLineLabel(vm!)
    }
    func onePostLikeButtonView() {
        let vm = TimeLineLikeOrCotentsButtonViewModel(postData:onePostVM!, my:self.feelButton)
        
        self.feelButton.configureTimeLineButtonImage(vm!)
    }

    
    


    
    @IBAction func touchUpInsideFavoriteButton(_ sender: UIButton) {
        
        let userID = UserDefaults.standard.string(forKey:"nickName")
        MainTimeLineNetwork(self).checkFavoriteButton(nickName: userID!, postID:(self.postId)!)
    
    }

    
    @IBAction func touchUpInsideLikeButton(_ sender: UIButton) {
        
        let userID = UserDefaults.standard.string(forKey:"nickName")
        MainTimeLineNetwork(self).checkLikeButton(nickName: userID!, postID:self.postId!)
    
        
    
    }
    
    
    func networkFailed() {
        
    }
    
    func networkResult(resultData: Any, code: String) {
        
        checkVO = resultData as! CheckVO
        
        if(code == "1-3"){
            
            let num = OptChange().gino(checkVO?.result?[0].likeCount)
            likeNumberLabel.text = "\(num)"
            if(checkVO?.message == "like"){
                likebutton.isSelected = true
                
            }else{
                
                likebutton.isSelected = false
                
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
            
                DefaultAlert().basicAlert(title: "더보기", inputMessage:"더보기", viewController: self.vc!, alertButtonStyle:.OneButtonStyle, complete: { (
                    ) in
                    //공유하기
                })
            
            
            }else if(checkVO?.message == "ok"){
            
                DefaultAlert().basicAlert(title: "더보기", inputMessage:"더보기", viewController: self.vc!, alertButtonStyle:.TwoButtonStyle, complete: { (
                    ) in
                     let userID = UserDefaults.standard.string(forKey:"nickName")
                        MainTimeLineNetwork(self).deletePost(nickName:userID!,postID:self.postId!)
                    
                })
            }
            
        
        
    }
        
        if(code == "1-6"){
        
            if(checkVO?.message == "success"){
            
                DefaultAlert2().basicAlert(title:"삭제", inputMessage:"삭제되었습니다.", viewController:self.vc!, alertButtonStyle:.OneButtonStyle, complete: { (
                    ) in
                    
                   
                    self.vc?.viewWillAppear(true)
                })
            
            }
        
        }
    }
    @IBAction func touchUpInsideMoreButton(_ sender: UIButton) {
        
        
         let optUserID = UserDefaults.standard.string(forKey:"nickName")
        guard let userID = optUserID else { return  }
        
        guard let postId = postId else { return  }
        
        MainTimeLineNetwork(self).deleteCheckPost(nickName:userID, postID: postId)
        
        

//        DefaultAlert().basicAlert(title:"더보기", inputMessage:"", viewController: optVC, alertButtonStyle:.TwoButtonStyle) { (
//            ) in
//            
//        }
    }
    
    
    
    @IBAction func touchUpInsideProfileButton(_ sender: UIButton) {
        

         let mainVC = ProfileInfoVC(nibName:"ProfileInfoVC", bundle:nil)
       
     guard let  userInfo = timeLineVM?.postInfo else { return  }
        
        let level = OptChange().gino(timeLineVM?.postInfo?.writerLevel)
        let name = OptChange().gsno(timeLineVM?.postInfo?.writerName)
       
        mainVC.nameString = "LV.\(level) \(name)"
        mainVC.stateString = timeLineVM?.postInfo?.writerState
        
        
        mainVC.profileString = userInfo.writerImage
            
            
            mainVC.view.frame = UIScreen.main.bounds
        
        if self.vc != nil {
            self.vc?.addChildViewController(mainVC)
            self.vc?.view.addSubview(mainVC.view)
            mainVC.didMove(toParentViewController: self.vc)
        }else {
         self.onePostVC?.addChildViewController(mainVC)
            self.onePostVC?.view.addSubview(mainVC.view)
            mainVC.didMove(toParentViewController: self.onePostVC)
        }
        
        mainVC.getProfileInfoDelegate(callback:self)
    
        
        
    }
    // 델리게이트빼내기
    func numberOfSections(in tableView: UITableView) -> Int {
        
     return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
          //  guard let cnt = replies.count else { return 0 }
     //   print(cnt)
        print(replies.count)
        return replies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let replyCell = Bundle.main.loadNibNamed("ReplyCell", owner:self, options: nil)?.first as! ReplyCell
        
        if  (self.onePostVC != nil) {
            
            if let data = self.oneReplies[indexPath.row]{
                
                replyCell.contfigureLookPost(data, vc: self.onePostVC!)
            }
        } else{
            
            if let data = self.replies[indexPath.row]{
                
                replyCell.contfigureMainTime(data, vc: self.vc!)
            }
           
        }
        
        
        if let data = self.replies[indexPath.row] {
            
            if let current = self.vc{
           
            
            } else{
         //    replyCell.contfigureLookPost(data, vc: onePostVC!)
            
            }
            
           
            
        }
        return replyCell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerView = UIView(frame:CGRect(x: 0, y: 0, width:self.frame.size.width, height: 37))
        let replyView = ReplyMoreView.instanceFromNib() as! ReplyMoreView
        footerView.addSubview(replyView)
        replyView.setFromVC(vc: self.onePostVC!)
        return footerView
    }

    //profileCallback
    func cancel(isCancel: Bool) {
        if(isCancel == true){
        DispatchQueue.background(delay: 0.2, background:nil, completion: {
            
            guard let backVC = self.vc else { return (self.onePostVC!.view.subviews.last?.removeFromSuperview())!  }
            
            backVC.view.subviews.last?.removeFromSuperview()
        })
           
        }
}


}

