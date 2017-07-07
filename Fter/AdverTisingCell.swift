//
//  AdverTisingCell.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 6. 27..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import UIKit

class AdverTisingCell: UICollectionViewCell {

    var representedAssetIdentifier: String?
    
    @IBOutlet weak var albumCheckButton: UIButton!
  
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var advertisingTitle: UILabel!
    @IBOutlet weak var advertisingImageView: UIImageView!
  
        var data: AdverTising?
    var uploadedImageData: String?
    var selectPhoto: PhotoAlbumImage?
       
  //  override var isSelected: Bool {
//        didSet {
//            self.contentView.backgroundColor = isSelected ? UIColor.blue : UIColor.yellow
//            self.albumCheckButton.isHidden = isSelected ? false : true
//        }
        

        
        
//    }

    func configure(_ model:AdverTising) {
      
        self.data = model
        configurePhotoImage()
        confiugureAdTitle()
        self.albumCheckButton.isHidden = true
    }
    func configureAd(_ model:AdverTising) {
        
        self.data = model
        configureAdImage()
        confiugureAdTitle()
        self.albumCheckButton.isHidden = true
    }
    
    func configureUploaded(_ model:String) {
        
        self.uploadedImageData = model
        configureUploadedImage()
        self.albumCheckButton.isHidden = true

    }
    func configureExpandPhoto(_ model:String) {
        
        self.uploadedImageData = model
        configureUploadedImage()
        self.albumCheckButton.isHidden = true
        self.shadowView.isHidden = true
        
    }
    
    func configureSelectPhoto(_ model:PhotoAlbumImage,isSeleted:Bool) {
        
        self.selectPhoto = model
        configureAlbum()
        self.shadowView.isHidden = true
        self.albumCheckButton.isHidden = true

    }
    func configureDeSelectPhoto(_ model:PhotoAlbumImage) {
        
        self.selectPhoto = model
        configureAlbum()
        self.shadowView.isHidden = true
        self.albumCheckButton.isHidden = true
        
    }
    
    
    
//////////////////////////////////////////////////////////////////////
    
    
    
    
    
    
    
    
    
    func configureAlbum(){
        
        
        let vm = PhotoAlbumImageViewModel.init(indata:selectPhoto!)
        
        self.advertisingImageView.configurePHImage(vm!)
        
    }
    
    
    func configureUploadedImage(){
        
        
        let vm = UploadImageViewModel.init(indata:uploadedImageData!)
        
        self.advertisingImageView.configureUploadedPhotosImage(vm!)
        
    }
    
    func configureAdImage(){
        
        
        let vm = AdImageViewModel.init(indata:data!)
        
        self.advertisingImageView.configureAdPhotosImage(vm!)
        
    }


    func configurePhotoImage(){
    
    
        let vm = AdImageViewModel.init(indata:data!)
    
        self.advertisingImageView.configureUploadedPhotosImage(vm!)
        
    }
    
    func confiugureAdTitle() {
        
     let vm = AdTitleViewModel.init(indata: data!)
        
        self.advertisingTitle.adTitleLabelConfiugure(vm!)
    }

    
    
}
