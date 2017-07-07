

//
//  MultiPHSelection.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 7. 1..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import UIKit
import Photos
import PhotosUI
class MultiPHSelection: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var photoCollectionView: UICollectionView!
    var allPhotos: PHFetchResult<PHAsset>!
    var photoDelegate: PHCollectionDelegate?
    let imageManager = PHCachingImageManager()
    var selectData: [PhotoInfo]!
    var  parentDelegate: PHSelectionCallback?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(selectData)
      // allPhotos = self.fetchAllPhotos()
       // delegate = PHCollectionDelegate(vc:self, allData: allPhotos, selectData: allPhotos)
        self.photoCollectionView.delegate = self
        self.photoCollectionView.dataSource = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      //  print(selectData)
         self.photoCollectionView.register(UINib(nibName: "AdverTisingCell", bundle: nil), forCellWithReuseIdentifier: "AdverTisingCell")
     //    selectData = []
          self.fetchAllPhotos()
     photoDelegate = PHCollectionDelegate(vc: self, selectData: self.selectData, allPhotos: allPhotos)

      
        photoCollectionView.allowsMultipleSelection = true;
        
        // Do any additional setup after loading the view.
    }

    func fetchAllPhotos() {
        
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [NSSortDescriptor.init(key:"creationDate", ascending: false)]
        
        
        allPhotos = PHAsset.fetchAssets(with: allPhotosOptions)
        self.photoCollectionView.reloadData()
        
    }
    
    func  getParentSelectionData(parent:PHSelectionCallback){
    
    
            self.parentDelegate = parent
    
    
    }

    @IBAction func touchUpInsideSelectButton(_ sender: UIButton) {
        
     
       
        self.view.removeFromSuperview()
         self.parentDelegate?.getPHImage(images: self.selectData!)
        
       
    }
   
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print(allPhotos.count)
        return (allPhotos?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var img :UIImage?
        print(allPhotos.count)
        
        let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier:"AdverTisingCell", for: indexPath) as! AdverTisingCell
        photoCell.albumCheckButton.isHidden  = true
        photoCell.isSelected = false
        guard let data = allPhotos else { return AdverTisingCell() }
        let asset = data.object(at: indexPath.row)
        
        photoCell.representedAssetIdentifier = asset.localIdentifier
        
        
        self.imageManager.requestImage(for: asset, targetSize: CGSize(width:UIScreen.main.bounds.width/3 - 1, height: UIScreen.main.bounds.width/3 - 1), contentMode: .aspectFill, options: nil, resultHandler: {
            
            image, _ in
            if photoCell.representedAssetIdentifier == asset.localIdentifier
                
            {
                
                
                img = image
                //                var isSeleted:Bool = false
                
                
                print("선택되었니?" + "\(photoCell.isSelected)")
                let vm = PhotoAlbumImage.init(image: img!)
                
                
                photoCell.configureSelectPhoto(vm, isSeleted: photoCell.isSelected)
                
                for index in self.selectData{
                    
                    
                    if(indexPath.row == index.row){
                        
                        
                       photoCell.isSelected = true
                      collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init() )
                        photoCell.albumCheckButton.isHidden = false
                        
                    } else{
                        
                      
                    }
                    
                }
            }
        })
        return photoCell
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell =  collectionView.cellForItem(at: indexPath) as! AdverTisingCell
        if(cell.isSelected == false){
            var selectedNum = 0
            for indexData in self.selectData {
                selectedNum += 1
                if(indexPath.row == indexData.row){
                    cell.albumCheckButton.isHidden = true
                    self.selectData.remove(at:selectedNum - 1)
                    
                }
            }
        }
        print(self.selectData.count)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(self.selectData.count < 5){
        
            let cell =  collectionView.cellForItem(at: indexPath) as! AdverTisingCell
            self.selectData.append(PhotoInfo(row: indexPath.row, image: cell.advertisingImageView.image!))
            cell.albumCheckButton.isHidden = false
            //   cell.isSelected = false
            print(self.selectData.count)
        
        }
      
        
    }
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width:UIScreen.main.bounds.width/3 - 1, height:UIScreen.main.bounds.width/3 - 1)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func returnDataToVC() -> [PhotoInfo] {
        print(self.selectData.count)
        return self.selectData
    }

    
}
