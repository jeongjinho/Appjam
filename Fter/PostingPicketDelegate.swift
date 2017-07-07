//
//  PostingPicketDelegate.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 7. 1..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import Foundation
import UIKit


class CategoryPickerDelegate:NSObject{


    var categoryData:[String] = ["고민있어요","궁금해요","일상이야기","함께해요"]
    var vc: PostingVC?

    
    init(_ vc: PostingVC) {
        self.vc = vc
    }
    
    
    func vcOptCheck() -> PostingVC{
        guard let nonOptVC = self.vc else { return PostingVC() }
        return nonOptVC
    
    }
    
    
    
}

extension CategoryPickerDelegate: UIPickerViewDelegate,UIPickerViewDataSource{

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return categoryData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return categoryData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let vc = vcOptCheck()
        
        vc.categoryTextField.text = categoryData[row]
        
    }

}
