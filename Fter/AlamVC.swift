//
//  AlamVC.swift
//  Fter
//
//  Created by 진호놀이터 on 2017. 7. 7..
//  Copyright © 2017년 진호놀이터. All rights reserved.
//

import UIKit

class AlamVC: UIViewController,UITableViewDelegate,UITableViewDataSource,NetworkingCallBack {
    var alamVO: [AlamInfo]?
    @IBOutlet weak var alamTableView: UITableView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let usernick = UserDefaults.standard.string(forKey: "nickName")
        AlamNM(self).getAlamInfo(nickName: usernick!)
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alamTableView.delegate = self
        alamTableView.dataSource = self
    
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
         guard let data = alamVO else { return 0 }
        
        return data.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"AlamCell", for: indexPath) as! AlamCell
        
        guard let datas = alamVO?[indexPath.row] else { return UITableViewCell()}
        
                    cell.alamTitle.text = datas.title
                    cell.alamDate.text = datas.writtentime
                    
                    
        
            return cell
        }
    
    
    func networkFailed() {
        
    }
    
    func networkResult(resultData: Any, code: String) {
        
        
        if(code == "1-1"){
        
            self.alamVO  = resultData as! [AlamInfo]
            
            
            self.alamTableView.reloadData()
        
        }
        
        
        
        
        
        
    }

    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
