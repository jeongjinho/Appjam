//
//  CenterSideVC.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 7. 3..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import UIKit
class CenterSideVC: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
   
    @IBOutlet weak var currentPageControl: UIPageControl!
     var photos: [String]!
    @IBOutlet weak var centerPhotoCollectionView: UICollectionView!
    var idx: Int?
     var centerSideCallback: CenterCallBack?
    
    
    func  getCenterSideCallback(callback: CenterCallBack) {
        
        centerSideCallback = callback
        
    }
    
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
         self.centerPhotoCollectionView.register(UINib(nibName: "AdverTisingCell", bundle: nil), forCellWithReuseIdentifier: "AdverTisingCell")
        self.centerPhotoCollectionView.delegate = self
        self.centerPhotoCollectionView.dataSource = self
        centerPhotoCollectionView.layer.cornerRadius = 20
          self.currentPageControl.numberOfPages = (self.photos?.count)!
         self.currentPageControl.pageIndicatorTintColor = AppColors.PupleColor
         
        centerPhotoCollectionView.alpha = 0
        centerPhotoCollectionView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        
        
        UIView.animate(withDuration: 0.15) {
            
            self.centerPhotoCollectionView.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.centerPhotoCollectionView.alpha = 1
        }
        // Do any additional setup after loading the view.
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"AdverTisingCell", for: indexPath)as! AdverTisingCell
        
//             let vm = PhotoAlbumImage.init(image: self.photos[indexPath.row])
                let ph = photos[indexPath.row]
            cell.configureExpandPhoto(ph)
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width:collectionView.frame.size.width, height:collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        idx = Int(scrollView.contentOffset.x) / Int(scrollView.frame.size.width)
        
       
        
        if (idx == (self.photos?.count)!-1){
            
            scrollView.contentOffset = CGPoint(x:0.0, y: 0.0)
            self.currentPageControl.currentPage = 0
        }
        self.currentPageControl.currentPage = idx!
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func touchInsideCacelButton(_ sender: UIButton) {
        
        self.centerSideCallback?.cancelPhoto(isCancel: true)
        
        
    }


   
}
