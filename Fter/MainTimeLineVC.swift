//
//  MainTimeLineVC.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 6. 25..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import UIKit

class MainTimeLineVC: UIViewController,UITabBarControllerDelegate,UITableViewDelegate,UITableViewDataSource ,NetworkingCallBack,CenterCallBack,MapCallBack{
    @IBOutlet weak var advertisingCollectionView: UICollectionView!
    @IBOutlet weak var timeLineTableView: UITableView!
    @IBOutlet weak var menuSegment: DefaultSegment!
    @IBOutlet weak var adPagingControl: UIPageControl!
    var dummy: [TimeLine?]?
    var timeLineVO:  [TimeLine]?
    var uploadImages: [UploadedImage?]?
    var adDelegate: AdvertisingDelegate?
    var  photoData :[AdverTising?]?
    var isAutoScroll: Bool = true
    var idx : Int = 0
    var currentSegment:Int = 0
    ////////////////////////
    var storedID : String?
    var storedPart: String?
    /////////////////////////
    
    ///////////////////////////
    var partName: String?
    ///////////////////////////
    //////////////////////////
    var categoryName:String = ""
    var categoryTag:Int = 0
    //////////////////////////
    @IBOutlet weak var partNameLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.timeLineTableView.delegate = self;
        self.timeLineTableView.dataSource = self;
        timeLineVO = []
         self.tabBarController?.tabBar.isHidden = false
     
        
        if(categoryName == ""){
        
            partNameLabel.text = storedPart
    MainTimeLineNetwork.init(self).getTimeLineForRecently(userid:self.storedID!, part:self.storedPart!, rule:"partlatest")
           
        
        } else{
        
            CategoryNetworking.init(self).getCategoryForRecently(userid:storedID!, category:categoryName, rule: "categorylatest", tag: categoryTag)
        
            }
       
         initialData()
        self.advertisingCollectionView.register(UINib(nibName: "AdverTisingCell", bundle: nil), forCellWithReuseIdentifier: "AdverTisingCell")
         adDelegate = AdvertisingDelegate.init(sc:self, data:photoData! as! [AdverTising])
        self.advertisingCollectionView.dataSource = adDelegate
        self.advertisingCollectionView.delegate = adDelegate
        self.adPagingControl.numberOfPages = (self.photoData?.count)!
       
            let btn = menuSegment.subviews.first as! UIButton
               btn.underLineView(isSelect:true)
        for subView in menuSegment.subviews {
            
            if(subView .isKind(of:UIButton.self) == true){
                
                let btn = subView as! UIButton
                
                if(btn.tag == 0){
                
                btn.underLineView(isSelect: true)
                btn.isSelected = true
                } else{
                
                    btn.underLineView(isSelect: false)
                    btn.isSelected = false
                }
            
                
                
                
            }
        }
      infiniteScroll()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.isAutoScroll = false

    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        storedID =  UserDefaults.standard.string(forKey: "nickName")!
        storedPart =   UserDefaults.standard.string(forKey: "part")!
        self.automaticallyAdjustsScrollViewInsets = false
        self.tabBarController?.delegate = self;
        self.timeLineTableView.estimatedRowHeight = 521
        let userPart = UserDefaults.standard.string(forKey: "part")
        storedPart = ChangePart().getKoreanPart(part: userPart!)
        partNameLabel.text = storedPart
    //    self.timeLineTableView.rowHeight = UITableViewAutomaticDimension;
       
        
      
        
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(timeLineVO?[indexPath.row].replies?.count == 0){
        
            return timeLineTableView.frame.size.height - 100
        }
        
        if(timeLineVO?[indexPath.row].postInfo?.uploadedImage?.count == 0 ){
        
        
            return timeLineTableView.frame.size.height - 100
        
        }else{
            return timeLineTableView.frame.size.height
        }
        
        
        
    }
  
    func networkFailed() {
        
        print("실패")
    }
    
    func networkResult(resultData: Any, code: String) {
        self.timeLineVO = resultData as? [TimeLine]
     //   print(resultData)
        print(self.timeLineVO)
       self.timeLineTableView.reloadData()
    }

    //scroll
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let numberOfCells = self.photoData?.count
        idx = Int(scrollView.contentOffset.x) / Int(scrollView.frame.size.width)
        
        print("page:" + "\(idx)")
        
        if (idx == (self.photoData?.count)!-1){
            
            scrollView.contentOffset = CGPoint(x:0.0, y: 0.0)
            self.adPagingControl.currentPage = 0
        }
        self.adPagingControl.currentPage = idx
    }

    func initialData()  {
        self.photoData = [AdverTising.init(title:"개발자에게 필요한 툴 알아보기 제1탄!", photos:"1"),AdverTising.init(title:"개발자에게 필요한 툴 알아보기 제2탄!", photos:"2"),AdverTising.init(title:"개발자에게 필요한 툴 알아보기 제3탄!", photos:"3"),AdverTising.init(title:"개발자에게 필요한 툴 알아보기 제4탄!", photos:"4"),AdverTising.init(title:"개발자에게 필요한 툴 알아보기 제5탄!", photos:"5"),AdverTising.init(title:"개발자에게 필요한 툴 알아보기 제5탄!", photos:"6")]
    }
  
    //------------------------------
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            print((self.timeLineVO?.count))
        
        
        if(self.timeLineVO == nil){
        
            return 0
        }
        
            return (self.timeLineVO!.count)
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let timeLineCell = Bundle.main.loadNibNamed("CustomTimeLineCell", owner: self, options:nil)?.first as! CustomTimeLineCell
         let data = self.timeLineVO?[indexPath.row]
            print(data)
        
                DispatchQueue.main.async {
                timeLineCell.contfigure(data!, vc: self)
                timeLineCell.writerPartButton.setTitle(data?.postInfo?.part, for: .normal)
                timeLineCell.likebutton.isSelected = !((data?.postInfo?.likeCheck) != nil)
                timeLineCell.favoriteButton.isSelected = !((data?.postInfo?.markcheck) != nil)
                timeLineCell.postId = data?.postInfo?.id
                timeLineCell.seletedIndex = indexPath.row
               
                }
        return timeLineCell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let lookVC = self.storyboard?.instantiateViewController(withIdentifier:"LookVC") as! LookVC
        
        lookVC.selectedPostID = self.timeLineVO?[indexPath.row].postInfo?.id
        self.navigationController?.pushViewController(lookVC, animated:true)
        
    }
    
       func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let numberOfCells =  self.photoData?.count
        let page = Int(scrollView.contentOffset.x) / Int(scrollView.frame.size.width)
        
        print("page:" + "\(page)")
        
        if (page ==  (self.photoData?.count)! - 1){
            
            scrollView.contentOffset = CGPoint(x:0.0, y: 0.0)
            
        }
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let index = viewController.tabBarItem.tag;
        
        if(index == 1 ){
            
           let stoy = UIStoryboard.init(name:"Main", bundle:nil)
             let vc  = stoy.instantiateViewController(withIdentifier:"PostingVC")
            
           self.tabBarController?.present(vc, animated: true, completion: nil)
            return false;
            
        }
        
        return true;
    }
    @IBAction func touchUpInsideSearchButton(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchVC")as! SearchVC
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func touchUpInsideMapButton(_ sender: UIButton) {
        
        let mapVC = self.storyboard?.instantiateViewController(withIdentifier:"MapVC") as! MapVC
        
        mapVC.getMapDelegate(callback: self)
        
        self.present(mapVC, animated: true) {
            
            self.tabBarController?.tabBar.isHidden = true
        }
    }
    
    @IBAction func touchUpInsideFeedButton(_ sender: UIButton) {
      
       // var subBtn :UIButton
     for subView in menuSegment.subviews {
            
        if(subView .isKind(of:UIButton.self) == true){
            
            let btn = subView as! UIButton
                btn.isSelected = false
                btn.underLineView(isSelect: false)
                
                if(sender.tag == btn.tag && sender.isSelected != true){
                   
                    btn.underLineView(isSelect:true)
                    if(categoryName == ""){
          
                        if(sender.tag == 0){
                            
                            
                            MainTimeLineNetwork.init(self).getTimeLineForRecently(userid:storedID!, part:storedPart!, rule:"partlatest")
                            self.timeLineTableView.reloadSections(IndexSet(integersIn: 0...0), with: UITableViewRowAnimation.left)
                            
                        } else{
                            
                            
                            MainTimeLineNetwork.init(self).getTimeLineForRecently(userid:storedID!, part:storedPart!, rule:"partpopular")
                            
                            self.timeLineTableView.reloadSections(IndexSet(integersIn: 0...0), with: UITableViewRowAnimation.right)
                        }

                        
                        
                        } else {
                        
                        if(sender.tag == 0){
                            
                            CategoryNetworking.init(self).getCategoryForRecently(userid:storedID!, category:categoryName, rule: "categorylatest", tag: categoryTag)
                            self.timeLineTableView.reloadSections(IndexSet(integersIn: 0...0), with: UITableViewRowAnimation.left)
                            
                        } else{
                             CategoryNetworking.init(self).getCategoryForRecently(userid:storedID!, category:categoryName, rule: "categorypopular", tag: categoryTag)
                            
                            self.timeLineTableView.reloadSections(IndexSet(integersIn: 0...0), with: UITableViewRowAnimation.right)
                        }

                        
                }
            }
     
        }
        
    }
    
}
    
    
    func cancelPhoto(isCancel: Bool) {
        
        if(isCancel == true){
            
            DispatchQueue.background(delay: 0.2, background:nil, completion: {
                self.tabBarController?.tabBar.isHidden = false
                self.view.subviews.last?.removeFromSuperview()
            })
            
        }
        
        
    }

    
    func infiniteScroll(){
        
        guard let  cnt = self.photoData?.count else { return  }
        if(isAutoScroll){
            DispatchQueue.background(delay: 3.5, background: {
                self.advertisingCollectionView.scrollToItem(at:IndexPath(row:self.idx,section:0), at: .right, animated: true)
            }, completion: {
                
                self.idx += 1
                self.adPagingControl.currentPage = self.idx
                
                if(self.idx >= cnt){
                    self.idx = 0
                    self.adPagingControl.currentPage = self.idx
                    self.advertisingCollectionView.scrollToItem(at:IndexPath(row:self.idx,section:0), at:.right, animated: true)
                }
                self.infiniteScroll()
                self.isAutoScroll = true
            })
            
        }
        
    }
    
    
    func getPart(part: String) {
        
        self.storedPart = part
        
         MainTimeLineNetwork.init(self).getTimeLineForRecently(userid:self.storedID!, part:self.storedPart!, rule:"partlatest")
    }

    
}
