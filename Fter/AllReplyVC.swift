//
//  AllReplyVC.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 6. 29..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import UIKit
import Kingfisher
class AllReplyVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,NetworkingCallBack,ReplyWindowCallBack{
    @IBOutlet weak var replyWindowBottom: NSLayoutConstraint!
    var selectedPostID: Int? 
    @IBOutlet weak var replyWindow: UIView!
    @IBOutlet weak var replesTableView: UITableView!
    @IBOutlet weak var menuSegment: DefaultSegment!
    var wid: ReplyWindow?
    var isUseful: Bool = false
       var replies: [AllReply?]?
    
    //@IBOutlet weak var menuSegment: DefaultSegment!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        LookNetwork(self).recentlyAllReply(postID: selectedPostID!)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow),
                                               name: Notification.Name.UIKeyboardWillShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide),
                                               name: Notification.Name.UIKeyboardWillHide,
                                               object: nil)
        
        for subView in menuSegment.subviews {
            
            if(subView .isKind(of:UIButton.self) == true){
                
                let btn = subView as! UIButton
                btn.isSelected = false
                
                if(btn.tag == 0){
                    
                    btn.underLineView(isSelect:true)
                }else{
                    btn.underLineView(isSelect: false)
                }
                
            }
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tabBarController?.tabBar.barTintColor = UIColor.white
//        self.tabBarController?.tabBar.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.pureNabiBar()
//        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.tabBarController?.tabBar.isTranslucent = false
        setReplyWindowView()

        
        self.replesTableView.delegate = self
        self.replesTableView.dataSource = self
        self.replesTableView.rowHeight = UITableViewAutomaticDimension;
        self.replesTableView.estimatedRowHeight = 80.0;
        
       
    }
    
    func setReplyWindowView(){
       
        
        let window = Bundle.main.loadNibNamed("ReplyWindow", owner:nil, options: nil)?.first as! ReplyWindow
        window.frame = CGRect(x: 0, y:0, width:self.replyWindow.frame.size.width, height:self.replyWindow.frame.size.height)
        window.setDelegateAllReplyVC(vc: self)
        wid = window
        self.replyWindow.addSubview(window)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        wid?.inputTextView.resignFirstResponder()
        return true
    }
    
    func keyboardWillHide(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            print(keyboardHeight)
            let duration = (notification.userInfo? [UIKeyboardAnimationDurationUserInfoKey])as? Double
            
            UIView.animate(withDuration:duration!, animations: {
                
                self.replesTableView.contentOffset = CGPoint(x:0, y:0)
                self.replyWindowBottom.constant = 0
                
            })
        }
        
    }
    func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            print(keyboardHeight)
            let duration = (notification.userInfo? [UIKeyboardAnimationDurationUserInfoKey])as? Double
            
            UIView.animate(withDuration:duration!, animations: {
                
                self.replesTableView.contentOffset = CGPoint(x:0, y: keyboardHeight)
                print(self.tabBarController?.tabBar.frame.size.height)
                self.replyWindowBottom.constant = keyboardHeight - (self.tabBarController?.tabBar.frame.size.height)!
                
                
                
            })
        }
        
        
        
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let cnt = replies?.count else { return 0 }
        print(cnt)
        return cnt
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let replyCell = Bundle.main.loadNibNamed("ReplyCell", owner:self, options: nil)?.first as! ReplyCell
        if let data = self.replies?[indexPath.row] {
            let url = URL(string: data.replyerImage!)
            DispatchQueue.main.async {
                replyCell.replyerButton.kf.setImage(with: url, for: .normal)
                replyCell.replyerNameButton.setTitle(data.replyerName, for: .normal)
                replyCell.replyTimeLabel.text = data.replyTime
                replyCell.replyLabel.text = data.reply
                replyCell.allVC = self
                replyCell.allVM = data
                
            }
            
        }
        return replyCell
    }
    
    @IBAction func touchUpInsideFeedButton(_ sender: UIButton) {
        
        // var subBtn :UIButton
        for subView in menuSegment.subviews {
            
            if(subView .isKind(of:UIButton.self) == true){
                
                let btn = subView as! UIButton
                btn.isSelected = false
                btn.underLineView(isSelect: false)
                if(sender.tag == btn.tag){
                    if(sender.isSelected != true){
                        
                        btn.underLineView(isSelect:true)
                        if(btn.tag == 0){
                            LookNetwork(self).recentlyAllReply(postID: selectedPostID!)
                            self.replesTableView.reloadSections(IndexSet(integersIn: 0...0), with: UITableViewRowAnimation.left)
                        
                        }else{
                        LookNetwork(self).usefulAllReply(postID: selectedPostID!)
                              self.replesTableView.reloadSections(IndexSet(integersIn: 0...0), with: UITableViewRowAnimation.right)
                        }
                    }
                    
                }
            }
            
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardWillHide, object: nil);
    }
   
    @IBAction func touchUplnsideBackButton(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    func networkResult(resultData: Any, code: String) {
        
        
        if(code == "1-1"){
        
        self.replies = resultData as! [AllReply]
        
    
        } else if(code == "1-2"){
        
        
            
             LookNetwork(self).recentlyAllReply(postID: selectedPostID!)
        }
    
        
        self.replesTableView.reloadData()
        
    }
    
    func networkFailed() {
        Utility().myLog(object:"올리플 실패이닷!!!!!!!!!!!!!!!!!")
    }
    
    
    func replyWindowDidSelectedUseful(result: Bool) {
        
        self.isUseful = result
    }
    
    func sendReply(content: String) {
        
        let userNick = UserDefaults.standard.string(forKey: "nickName")
        
        
        LookNetwork(self).addReply(nickName: userNick!, postID: selectedPostID!, useful:Int(NSNumber(value:isUseful)), content: content)
        
    }
    
    
    func resignWindowKeyBoard(textfield: UITextField) {
        textfield.delegate = self
        textfield.resignFirstResponder()
    }
   
}





