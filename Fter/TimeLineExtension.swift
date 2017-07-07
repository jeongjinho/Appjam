//
//  TimeLineExteion.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 6. 27..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UILabel{
   
    
    
    
}

extension UITextView{

   

}



extension UILabel{
   
    
    func configureTimeLineLabel(_ viewModel: TextForCellProtocol) {
        print(viewModel.title)
        self.text = viewModel.title
        print(self.text)
        self.textColor = viewModel.textColor
    }
        func configurePostTextView(_ viewModel: TextForCellProtocol) {
            
            self.text = viewModel.title
            print("\(self.text)")
            self.textColor = viewModel.textColor
            self.numberOfLines = 3
            self.lineBreakMode = .byWordWrapping
            
        }
        
        func onePostTextView(_ viewModel: TextForCellProtocol) {
            
            self.text = viewModel.title
            print("\(self.text)")
            self.textColor = viewModel.textColor
            self.numberOfLines = 0
            self.lineBreakMode = .byWordWrapping

            
        }

    
    
}
extension UIButton{
   
    
    func configureTimeLineButton(_ viewModel: TextForCellProtocol) {
        
      //  self.titleLabel?.text = viewModel.title
        // print("\(viewModel.title)")
     
        self.setTitle(viewModel.title, for: .normal)
        self.setTitleColor(viewModel.textColor, for: .normal)
        
    }
    func configureTimeLineButtonImage(_ viewModel: ImageForCellProtocol) {
        
        if(viewModel.image == nil){
            
        }
        let url = URL(string: viewModel.image)
        print(url)
        self.layer.cornerRadius = viewModel.radious
        self.kf.setBackgroundImage(with: url, for: .normal)
      //  self.imageView?.contentMode = .scaleAspectFill
        self.layer.masksToBounds = true
        
            
        // print("\(self.text)")
      
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignment.fill
        self.contentVerticalAlignment = UIControlContentVerticalAlignment.fill;
    }
   
    
}

extension UIImageView{
    
    func configureTimeLineImage(_ viewModel: ImageForCellProtocol){
        let url = URL(string:viewModel.image)
        
        self.kf.setImage(with: url)
        self.layer.cornerRadius = viewModel.radious
    }
    
    func configureReplyImage(_ viewModel: ImageForCellProtocol){
        let url = URL(string:viewModel.image)
        self.kf.setImage(with: url)
        self.layer.cornerRadius = viewModel.radious
    }
    
    func configureUploadedPhotosImage(_ viewModel: ImageForCellProtocol){
        let url = URL(string:viewModel.image)
        self.kf.setImage(with: url)
        self.layer.cornerRadius = viewModel.radious
    }
    func configureAdPhotosImage(_ viewModel: ImageForCellProtocol){
      
        self.image = UIImage(named: viewModel.image)
        self.layer.cornerRadius = viewModel.radious
    }
    
    func configurePHImage(_ viewModel: PhotoForCellProtocol){
        self.image = viewModel.image
       // self.layer.cornerRadius = viewModel.radious
    }
    
}
