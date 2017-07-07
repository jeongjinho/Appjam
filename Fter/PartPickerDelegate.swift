//
//  PartPickerDelegate.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 7. 1..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import Foundation
import UIKit
class PartPickerDelegate:NSObject{
    
    
    var partData:[String] = ["디자인","개발","경영/마케팅"]
    var vc: PostingVC
    
    
    init(_ vc: PostingVC) {
        self.vc = vc
    }
    
    
   
    
    
    
}

extension PartPickerDelegate: UIPickerViewDelegate,UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return partData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return partData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        
        vc.partTextField.text = partData[row]
        
    }
    
}
