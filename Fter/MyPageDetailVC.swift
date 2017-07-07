//
//  ProfileVC.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 6. 24..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import UIKit

class MyPageDetailVC: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,NetworkingCallBack{
    @IBOutlet weak var nickNameTextField: UnderlineTextField!
    @IBOutlet weak var stateMessageTextField: UnderlineTextField!
    let imagePicker = UIImagePickerController()
    var menuPickerView = UIPickerView()
    var menuData = ["경영/마케팅","개발","디자인"]
    var nickCheck: String = ""
    var rightButton: UIButton = UIButton()
    @IBOutlet weak var profilePhotoButton: UIButton!
    @IBOutlet weak var partTextField: UITextField!
    
    @IBOutlet weak var completeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        //  self.menuArray ={"경영/마케팅"}
        initialNaViBar()
        initialButton()
        setStateTextField()
        
        
        let leftView = UIView()
        leftView.frame = CGRect(x:0, y: 0, width:15, height: 40)
        partTextField.leftViewMode = .always
        partTextField.leftView = leftView
        //~~~~~~~~~~
        let rightImageView = UIImageView()
        rightImageView.image = UIImage(named: "down")
        
        let rightView = UIView()
        rightView.addSubview(rightImageView)
        
        rightView.frame = CGRect(x: partTextField.frame.size.width-40, y: 0, width: 40, height: 40)
        rightImageView.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
        partTextField.rightViewMode = .always
        partTextField.rightView = rightView
        //~~~~~~~~~~~~~~~~~~~~~~~~~~~
        
        
        menuPickerView.delegate = self
        menuPickerView.dataSource = self
        partTextField.inputView = menuPickerView
        partTextField.inputAccessoryView = CustomPickerView().toolbarForpickerView(vc: self, completeHandler: { () in
            
            //추후나감
            let row = self.menuPickerView.selectedRow(inComponent: 0)
            self.partTextField.text = self.menuData[row]
            self.partTextField.endEditing(true)
            self.partTextField.isEnabled = true
        })
        
        self.partTextField.backgroundColor = AppColors.GrayColor3
        
    }
    
    func initialButton() {
        let btnVM = ButtonViewModel.init(fontColor:AppColors.PupleColor, text: "안녕", borderColor: AppColors.PupleColor, borderWidth: 3, borderRadius:Float(completeButton.frame.height/2), backgroundColor: .white)
        
        self.completeButton.DefaultButton(style:.fillStyle, buttonVM: btnVM)
    }
    
    func initialNaViBar()  {
        guard let naviBar = self.navigationController?.navigationBar else { return  }
        
        naviBar.shadowNabiBar()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return menuData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return menuData[row]
        
    }
    
    @IBAction func touchUpInsidePhotoButton(_ sender: UIButton) {
        
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func touchUpInsideCompleteButton(_ sender: UIButton) {
        
        let oldNick = UserDefaults.standard.string(forKey: "nickName")
            let part = OptChange().gsno(partTextField.text)
            let state = OptChange().gsno(stateMessageTextField.text)
            let newNick = OptChange().gsno(self.nickNameTextField.text)
            MypageNM(self).resettingProfile(userNick:oldNick!, nickname: newNick, part: part, statemessage: state, image: self.profilePhotoButton.image(for: .normal)!)
       
        
        
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var  chosenImage = UIImage()
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        profilePhotoButton.setImage(chosenImage, for: .normal)
        profilePhotoButton.imageView?.contentMode = .scaleAspectFill
        dismiss(animated:true, completion: nil)
        
        
        
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func setStateTextField(){
        
        
        
        rightButton.setTitle("중복확인", for: .normal)
        rightButton.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 12.0)!
        rightButton.setTitleColor(UIColor.black, for:.normal)
        rightButton.backgroundColor = UIColor.clear
        let rightView = UIView()
        rightView.addSubview(rightButton)
        
        rightView.frame = CGRect(x: partTextField.frame.size.width-80, y: 0, width: 80, height: 40)
        rightButton.frame = CGRect(x: 15, y:8, width:80, height: 20)
        nickNameTextField.rightViewMode = .always
        nickNameTextField.rightView = rightView
        
        rightButton.addTarget(self, action: #selector(pressButton(button:)), for: .touchUpInside)
        
        
    }
    
    func pressButton(button: UIButton) {
        
        let checkname = self.nickNameTextField.text
        if(checkname != ""){
            
            let oldnick = OptChange().gsno(UserDefaults.standard.string(forKey: "nickName"))
            
            MypageNM(self).recheckNickname(oldname: oldnick, newnick: checkname!)
        }
        
        
    }
    
    func networkResult(resultData: Any, code: String) {
        
        if(code == "1-5"){
            self.nickCheck = resultData as! String
            if(self.nickCheck == "true"){
                
                self.nickNameTextField.textColor = AppColors.PupleColor
            } else if(self.nickCheck == "false"){
                
                self.nickNameTextField.textColor = AppColors.pinkColor
            }
            
        } else if(code == "1-4"){
            let result = resultData as! String
            
//           
            if(result == "update"){
                UserDefaults.standard.set(self.nickNameTextField.text, forKey:"nickName")
                UserDefaults.standard.set(self.partTextField.text, forKey:"part")
                self.navigationController?.popViewController(animated: true)
                
            }
        
        
        }
        
        
    }
    func networkFailed() {
        print("실패")
    }
    
    
}
