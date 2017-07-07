//
//  ReplyExtension.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 6. 28..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import Foundation
import UIKit

extension UIButton{

    func configureReplyButton(_ viewModel: TextForCellProtocol) {
        
        self.setTitle(viewModel.title, for: .normal)
             self.setTitleColor(viewModel.textColor, for: .normal)
        
    }
    
    func replyerImageButtonConfigure(_ viewModel: ImageForCellProtocol) {
       
       self.layer.masksToBounds = true
        self.layer.cornerRadius = viewModel.radious
       
        let url = URL(string: viewModel.image)
       
        self.kf.setImage(with: url, for: .normal)
     //   self.imageView?.contentMode = .scaleAspectFill
       
    }
}
extension UILabel{
    func configureReplyLabel(_ viewModel: TextForCellProtocol) {
        
        self.text = viewModel.title
        
        self.textColor = viewModel.textColor
        //        self.numberOfLines = 0
        //        self.lineBreakMode = .byWordWrapping
        
    }
    
    func configureAllReplyLabel(_ viewModel: TextForCellProtocol) {
        
        self.text = viewModel.title
        
        self.textColor = viewModel.textColor
                self.numberOfLines = 0
                self.lineBreakMode = .byWordWrapping
        
        
    }
}

