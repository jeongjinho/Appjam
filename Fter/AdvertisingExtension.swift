//
//  AdvertisingExtension.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 6. 27..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import Foundation
import UIKit



extension UIButton{

    func configureAdButton(_ viewModel: ImageForCellProtocol) {
        
        //self.titleLabel?.text = viewModel.title
        // print("\(self.text)")
        // self.setTitleColor(viewModel.textColor, for: .normal)
        
        
     //   self.setImage(viewModel.image, for:.normal)
    }
    


}

extension UILabel{


    func adTitleLabelConfiugure(_ viewModel: TextForCellProtocol) {
        
        self.text = viewModel.title
        self.textColor = viewModel.textColor
        self.font = viewModel.textFontStyle
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
        
    }

}
