//
//  PostingTextFieldDelegate.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 7. 1..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import Foundation
import UIKit


class PostingTextFieldDelegate: NSObject{

    var vc: PostingVC
    var categoryDelete:CategoryPickerDelegate?
    var partDelegate:PartPickerDelegate?
    init(_ vc: PostingVC){
    
        self.vc = vc
        self.categoryDelete =  CategoryPickerDelegate(self.vc)
        self.vc.categoryPickerView.delegate = categoryDelete
        
        
        self.partDelegate =  PartPickerDelegate(self.vc)
        self.vc.partPickerVeiw.delegate = partDelegate
        
    }

   
    

}

extension PostingTextFieldDelegate: UITextFieldDelegate{

    
    func textFieldDidBeginEditing(_ textField: UITextField) {
         vc.postingVieTopConstraint.constant = -120
              if(textField.tag == 0){
        
           
            vc.categoryTextField.inputView = vc.categoryPickerView
            vc.categoryTextField.inputAccessoryView = CustomPickerView().toolbarForpickerView(vc: vc, completeHandler: { () in
                
                //추후나감
                let row = self.vc.categoryPickerView.selectedRow(inComponent: 0)
                self.vc.categoryTextField.text = self.categoryDelete?.categoryData[row]
                self.vc.categoryTextField.endEditing(true)
                self.vc.categoryTextField.isEnabled = true
            })
        
        } else{
             vc.partTextField.inputView = vc.partPickerVeiw
            vc.partTextField.inputAccessoryView = CustomPickerView().toolbarForpickerView(vc: vc, completeHandler: { () in
                
                //추후나감
                let row = self.vc.partPickerVeiw.selectedRow(inComponent: 0)
                self.vc.partTextField.text = self.partDelegate?.partData[row]
                self.vc.partTextField.endEditing(true)
                self.vc.partTextField.isEnabled = true
            })

        
        
        }
               
       
        
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        self.vc.postingVieTopConstraint.constant = 0
        
        return true
    }

}
