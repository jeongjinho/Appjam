//
//  PostingVC.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 6. 26..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import UIKit

class PostingVC: UIViewController,PHSelectionCallback,UICollectionViewDataSource,UICollectionViewDelegate,NetworkingCallBack,UITextFieldDelegate,UITextViewDelegate{
    @IBOutlet weak var selectionPHCollectionView: UICollectionView!
    var selectCollectionDeleage: SelectionPHCollectionDelegate?
    var UserProfile:[PostingInfo]?
    @IBOutlet weak var userPart: UILabel!
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var contentTxtView: UITextView!
    @IBOutlet weak var titleTxtField: UITextField!
    @IBOutlet weak var postingVieTopConstraint: NSLayoutConstraint!
    var categoryPickerView = UIPickerView()
    var partPickerVeiw = UIPickerView()
      var textfieldDelegate: PostingTextFieldDelegate?
    var partFieldDelegate: PostingTextFieldDelegate?
    var part = ["경영/마케팅","개발","디자인"]
    var categoryData:[String] = ["고민있어요","궁금해요","일상이야기","함께해요"]
    @IBOutlet weak var partTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
         PostingNM(self).getUserPostingInfo(nickName: UserDefaults.standard.string(forKey: "nickName")!)
        
    }
    
    var selectData:[PhotoInfo]!
    override func viewDidLoad() {
        super.viewDidLoad()
       categoryTextField.delegate = self
        titleTxtField.delegate = self
        partTextField.delegate = self
        contentTxtView.delegate = self
        
       selectData = []
        textfieldDelegate = PostingTextFieldDelegate(self)
        partFieldDelegate = PostingTextFieldDelegate(self)
      //  self.profileImageView.clipsToBounds = true
        self.profileImageView.layer.masksToBounds = true
        self.profileImageView.layer.cornerRadius = profileImageView.frame.size.width/2
         self.partTextField.delegate = textfieldDelegate
        self.categoryTextField.delegate = partFieldDelegate
          self.selectionPHCollectionView.register(UINib(nibName: "AdverTisingCell", bundle: nil), forCellWithReuseIdentifier: "AdverTisingCell")
        // Do any additional setup after loading the view.
        self.initialNaiBar()
       selectCollectionDeleage = SelectionPHCollectionDelegate.init(vc:self, selectPhoto:self.selectData)
    
        self.selectionPHCollectionView.delegate = self
           self.selectionPHCollectionView.dataSource = self
        self.contentTxtView.inputAccessoryView = CustomPickerView().toolbarForpickerView(vc: self, completeHandler: { (
            ) in
           self.contentTxtView.resignFirstResponder()
        })
        
        
        
        
//        if (contentTxtView.text == "") {
//            textViewDidEndEditing(contentTxtView)
//        }
//        let tapDismiss = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
//        self.view.addGestureRecognizer(tapDismiss)
        
       
    }

    
    
    func getPHImage(images: [PhotoInfo]) {
      
        self.selectData  = images
        self.selectionPHCollectionView.reloadData()
        
    }
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        print("올라온다")
        
    }
    
    @IBAction func touchInsidePostingButton(_ sender: UIButton) {
        let usernick = UserDefaults.standard.string(forKey:"nickName")
        var isPossible: Bool = false
        for selecPart in part {
            
            for selectCategory in categoryData {
                
                if(titleTxtField.text != "" && contentTxtView.text != ""){
                
                        isPossible = true
                
                }
            }
        }
        
        var imgs:[UIImage] = []
        for img in selectData {
            
            imgs.append(img.image!)
        }
        
        if(isPossible == true){
            
            
            
            
            PostingNM(self).postingMyCotents(categoty:categoryTextField.text!, part:partTextField.text!, title: titleTxtField.text!, contents: contentTxtView.text!, usernick:usernick!, images: imgs)
        
        }
        
        
        
    }
    
    
    @IBAction func touchUpInsideBackButton(_ sender: Any) {
        self.dismiss(animated:true, completion:nil)
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func touchUpInsidepicButton(_ sender: UIButton) {
        
        //해당뷰컨가져오고
        let mainVC = MultiPHSelection(nibName:"MultiPHSelection", bundle:nil) 
        //데이터넘기고
        mainVC.selectData = self.selectData
        //차일드로추가하고
         self.addChildViewController(mainVC)
         //크기지정하고
        
         mainVC.view.frame = UIScreen.main.bounds
        //뷰를 추가
        self.view.addSubview(mainVC.view)
        //메인을 부모뷰선정
          mainVC.didMove(toParentViewController:self)
        
        mainVC.getParentSelectionData(parent: self)
    
      //  print(self.selectData)
       
        
    }

    func initialNaiBar()  {
        
        guard let naviBar = self.navigationController?.navigationBar else { return  }
        
        naviBar.shadowNabiBar()
      //  self.navigationController?.setNavigationBarHidden(false, animated:false)
    }

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(selectData.count)
        return selectData.count
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier:"AdverTisingCell", for: indexPath) as! AdverTisingCell
        let vm = PhotoAlbumImage.init(image: selectData[indexPath.row].image!)
        
        photoCell.configureSelectPhoto(vm, isSeleted: photoCell.isSelected)
        
        return photoCell
        
    }
    

    
    
    
    func networkFailed() {
        print("실패")
        
    }
    
    func networkResult(resultData: Any, code: String) {
    
    
        
        if(code == "1-1"){
             self.UserProfile = resultData as! [PostingInfo]
            let url = URL(string: (UserProfile?[0].profile)!)
            self.profileImageView.kf.setImage(with: url)
            
            
            let name  = OptChange().gsno(UserProfile?[0].nickName)
            let level = OptChange().gino(UserProfile?[0].level)
            self.UserName.text = "LV.\(level) \(name)"
            self.userPart.text = self.UserProfile?[0].part
            
        } else  if(code == "1-2"){
        
            
            
            let alert  = UIAlertController(title:"저장", message:"게시물이 작성되었습니다.", preferredStyle: .alert)
            
            
            alert.addAction(UIAlertAction(title: "삭제하기", style: UIAlertActionStyle.destructive, handler: {
                    
                                    //부모뷰찾는거해야함
                alertAction in
                                    if let vc = self.presentationController {
                                        self.dismiss(animated: true, completion:nil)
                                       
                                    }
                                    
                                    self.navigationController?.popViewController(animated: true)
                                }))
        
        
     self.present(alert, animated: true, completion:nil)
            
    }
            
        }
        

    
    
    
    
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        if text == "\n" {
//            self.contentTxtView.resignFirstResponder()
//            return false
//        }
//        return true
//    }
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        
//      textField.resignFirstResponder()
//       return true
//    }
//    
//    func dismissKeyboard(){
//        contentTxtView.resignFirstResponder()
//    }
//    
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if (contentTxtView.text == "") {
//            contentTxtView.text = "내용입력"
//            contentTxtView.textColor = .gray
//        contentTxtView.resignFirstResponder()
//    }
//    
//    func textViewDidBeginEditing(textView: UITextView){
//        if (contentTxtView.text == "내용입력"){
//            contentTxtView.text = ""
//            contentTxtView.textColor = .gray
//        }
//        contentTxtView.becomeFirstResponder()
//    }
//    
//}
}
