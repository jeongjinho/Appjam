//
//  LookVC.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 7. 5..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import UIKit
import Kingfisher
class LookVC: UIViewController,UITableViewDelegate,UITableViewDataSource,HeightForTextView,ProfileCallBack,NetworkingCallBack,UITextFieldDelegate,ReplyWindowCallBack,CenterCallBack {
    @IBOutlet weak var replyWinView: UIView!
    @IBOutlet weak var LookPostTableView: UITableView!
    var textViewHeight = CGFloat()
    var selectedPostID: Int?
    var postData: OnePost?
    var inputReplyTxt: ReplyWindow?
    var isUseful: Bool = false
    @IBOutlet weak var replymoreView: UIView!
    
    @IBOutlet weak var replyWinBottomConst: NSLayoutConstraint!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         setReplyWindowView()
        let userInfo  = UserDefaults.standard.string(forKey: "nickName")
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow),
                                               name: Notification.Name.UIKeyboardWillShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide),
                                               name: Notification.Name.UIKeyboardWillHide,
                                               object: nil)

         LookPostNetwork(self).getLookPost(userid:userInfo!, postID:selectedPostID!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
         LookPostTableView.delegate = self
         LookPostTableView.dataSource = self
        print(LookPostTableView.contentSize.height)
        print(LookPostTableView.frame.size.height)
         LookPostTableView.contentSize = LookPostTableView.frame.size
        LookPostTableView.rowHeight = UITableViewAutomaticDimension
        
        
       
    
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardWillHide, object: nil);
    }
    @IBAction func touchUpInisdeProfileBtn(_ sender: Any) {
        
        let profileVC = ProfileInfoVC(nibName:"ProfileInfoVC", bundle:nil)
        
        profileVC.nameString =  "안녕"
        profileVC.stateString = "반가워"
        profileVC.profileString = "url"
        profileVC.view.frame = UIScreen.main.bounds
        self.addChildViewController(profileVC)
        self.view.addSubview(profileVC.view)
        profileVC.didMove(toParentViewController: self)
         profileVC.getProfileInfoDelegate(callback:self)
    }

    /// tableViewDatasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"LookCell", for:indexPath) as! LookCell
        cell.delgate = self
        
        if let data = self.postData {
            
            cell.contentTxtView.text = data.postInfo?.postText
            cell.titleLbl.text = data.postInfo?.postTitle
            cell.nameBtn.setTitle(data.postInfo?.writerName, for: .normal)
            
            let category =  ChangeCategory().getKoreanCategory(category: (data.postInfo?.category)!)
            cell.categoryBtn.setTitle(category, for: .normal)
            
            let part = ChangePart().getKoreanPart(part:(data.postInfo?.postPart)!)
            cell.partBtn.setTitle(part, for: .normal)
            
            let userPart = ChangePart().getKoreanPart(part:(data.postInfo?.userPart)!)
            cell.userPartLbl.text = userPart
            
            let profileURL = URL(string: (data.postInfo?.writerImage)!)
            cell.profileBtn.kf.setBackgroundImage(with: profileURL, for: .normal)
            
            cell.dateLbl.text = data.postInfo?.writtenDate
            
            cell.heartBtn.isSelected = !((data.postInfo?.likeCheck) != nil)
            cell.replyBtn.isSelected = !((data.postInfo?.markcheck) != nil)
            let heartnum = OptChange().gino(data.postInfo?.likeNumber)
            cell.heartcntLbl.text =  "\(heartnum)"
            let replynum = OptChange().gino(data.postInfo?.replyNumber)
            cell.replycntLbl.text =  "\(replynum)"
//            cell.replycntLbl.text = OptChange().gsno("\(String(describing: data.postInfo?.likeNumber))")
            print(data.postInfo?.uploadedImage)
            cell.configUploadedImage(vc: self, data: (data.postInfo?.uploadedImage)!)
            cell.configureReplies(data: data.replies!)
        }  
        
     
        cell.textViewDidChange(cell.contentTxtView)
        return cell
        
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerView = UIView(frame:CGRect(x: 0, y:0, width:self.view.frame.size.width, height: 37))
        let replyView = ReplyMoreView.instanceFromNib() as! ReplyMoreView
        footerView.addSubview(replyView)
        replyView.setFromVC(lookVC: self)
        return footerView
    }
   
    
    ///  tableViewDelegate
    
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return self.LookPostTableView.contentSize.height + textViewHeight
    }
    
    

    func heightOfTextView(height: CGFloat) {
             textViewHeight = height
        
            LookPostTableView.beginUpdates()
        LookPostTableView.endUpdates()
        
    }

    func keyboardWillHide(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            print(keyboardHeight)
            let duration = (notification.userInfo? [UIKeyboardAnimationDurationUserInfoKey])as? Double
            
            UIView.animate(withDuration:duration!, animations: {
                
                self.LookPostTableView.contentOffset = CGPoint(x:0, y:0)
                self.replyWinBottomConst.constant = 0
                
            })
        }
        
    }
    func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            print(keyboardHeight)
            let duration = (notification.userInfo? [UIKeyboardAnimationDurationUserInfoKey])as? Double
            
            UIView.animate(withDuration:duration!, animations: {
                
                self.LookPostTableView.contentOffset = CGPoint(x:0, y: keyboardHeight)
                self.replyWinBottomConst.constant = keyboardHeight - (self.tabBarController?.tabBar.frame.size.height)!
  
            })
        }
    }
    func setReplyWindowView(){
        let window = Bundle.main.loadNibNamed("ReplyWindow", owner:nil, options: nil)?.first as! ReplyWindow
        window.frame = CGRect(x: 0, y:0, width:self.replyWinView.frame.size.width, height:self.replyWinView.frame.size.height)
        window.getDelegate(vc: self)
        inputReplyTxt = window
        self.replyWinView.addSubview(window)
    }
    
    //profile callbaock
    func cancel(isCancel: Bool) {
        
        if(isCancel == true){
            DispatchQueue.background(delay: 0.2, background:nil, completion: {
                
                self.view.subviews.last?.removeFromSuperview()
                
            })
        }
        
    }
    //networkCallback
    func networkFailed() {
        
    }
    
    func networkResult(resultData: Any, code: String) {
        
           let userInfo  = UserDefaults.standard.string(forKey: "nickName")
        if(code == "1-1"){
            self.postData = resultData as? OnePost
            print(resultData)
           
         
        } else if(code == "1-2"){
            let userInfo  = UserDefaults.standard.string(forKey: "nickName")
            LookPostNetwork(self).getLookPost(userid:userInfo!, postID:selectedPostID!)
         
        }
         self.LookPostTableView.reloadData()
        
       
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputReplyTxt?.inputTextView.resignFirstResponder()
        return true
    }
    
    @IBAction func touchUpInsideBackButton(_ sender: UIButton) {
    
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpInsideAllReplyBtn(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AllReplyVC") as! AllReplyVC
        
        vc.selectedPostID = self.selectedPostID
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func sendReply(content: String) {
        
        let userNick = UserDefaults.standard.string(forKey: "nickName")
        
        
        LookNetwork(self).addReply(nickName: userNick!, postID: selectedPostID!, useful:Int(NSNumber(value:isUseful)), content: content)
    
    }
    
    func replyWindowDidSelectedUseful(result: Bool) {
        
        self.isUseful = result
        print(self.isUseful)
        
    }
    
    func cancelPhoto(isCancel: Bool) {
        
        if(isCancel == true){
            
            DispatchQueue.background(delay: 0.2, background:nil, completion: {
                
               self.tabBarController?.tabBar.isHidden = false
                self.view.subviews.last?.removeFromSuperview()
            })
            
        }
        
        
    }
    
    func resignWindowKeyBoard(textfield: UITextField) {
        
        textfield.delegate = self
        textfield.resignFirstResponder()
    }

   
    
}
