//
//  SearchVC.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 7. 5..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import UIKit

class SearchVC: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDelegate,UITableViewDataSource,NetworkingCallBack,UITextFieldDelegate{

    @IBOutlet weak var searchEmptyView: UIView!
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var partTextField: CircleTextField!
    var pickerView = UIPickerView()
    var searchData : [SearchVO]? = []
    
    var menuData = ["경영/마케팅","개발","디자인"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.searchEmptyView.isHidden = true
        searchTableView.delegate = self
        searchTableView.dataSource = self
        pickerView.delegate = self
        pickerView.dataSource = self
        partTextField.inputView = pickerView
        partTextField.inputAccessoryView = CustomPickerView().toolbarForpickerView(vc: self, completeHandler: { () in
            
            //추후나감
            let row = self.pickerView.selectedRow(inComponent: 0)
            self.partTextField.text = self.menuData[row]
            self.partTextField.endEditing(true)
            self.partTextField.isEnabled = true
        })
        
        inputTextField.delegate = self

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let data = searchData else { return 0 }
        
        
        return data.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"SearchCell", for: indexPath) as! SearchCell
        
        
           guard let data  = self.searchData?[indexPath.row] else { return UITableViewCell()}
            cell.nameLabel.text = data.usernick
            cell.contentLabel.text = data.title
        
        
        
        return  cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let lookVC = self.storyboard?.instantiateViewController(withIdentifier:"LookVC") as! LookVC
        lookVC.selectedPostID = self.searchData?[indexPath.row].id
        self.navigationController?.pushViewController(lookVC, animated: true)
    }
    
    
    
    
    
    
    
    
    
    
    @IBAction func touchUpInsideSearchButton(_ sender: UIButton) {
        
      
        
        SearchNM(self).searchKeyword(part:partTextField.text!, content:inputTextField.text!)
        inputTextField.resignFirstResponder()
        
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
    

    func networkResult(resultData: Any, code: String) {
        
        if(code == "1-1"){
            
            
            
            searchData = resultData as! [SearchVO]
            
            print(searchData?.count)
            if(searchData?.count == 0){
            
            searchEmptyView.isHidden = false
            }
            searchTableView.reloadData()
            
        }

        
        
        
    }
    
    func networkFailed(){
            }
    
    
    
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}
